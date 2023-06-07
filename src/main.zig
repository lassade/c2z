const std = @import("std");
const clap = @import("clap");
const debug = std.debug;
const io = std.io;
const log = std.log;
const json = std.json;
const mem = std.mem;
const fmt = std.fmt;
const Allocator = mem.Allocator;

// const smol = @import("smol.zig");

// prim_defaults = {
//     'int':          '0',
//     'bool':         'false',
//     'int8_t':       '0',
//     'uint8_t':      '0',
//     'int16_t':      '0',
//     'uint16_t':     '0',
//     'int32_t':      '0',
//     'uint32_t':     '0',
//     'int64_t':      '0',
//     'uint64_t':     '0',
//     'float':        '0.0',
//     'double':       '0.0',
//     'uintptr_t':    '0',
//     'intptr_t':     '0',
//     'size_t':       '0'
// }

// https://github.com/floooh/sokol/blob/master/bindgen/gen_ir.py

const primitives = std.ComptimeStringMap([]const u8, .{
    .{ "bool", "bool" },

    .{ "char", "u8" },
    .{ "signed char", "i8" },
    .{ "unsigned char", "u8" },
    .{ "short", "c_short" },
    .{ "unsigned short", "c_ushort" },
    .{ "int", "c_int" },
    .{ "unsigned int", "c_uint" },
    .{ "long", "c_long" },
    .{ "unsigned long", "c_ulong" },
    .{ "long long", "c_longlong" },
    .{ "unsigned long long", "c_ulonglong" },

    .{ "float", "f32" },
    .{ "double", "f64" },

    .{ "int8_t", "i8" },
    .{ "uint8_t", "u8" },
    .{ "int16_t", "i16" },
    .{ "uint16_t", "u16" },
    .{ "int32_t", "i32" },
    .{ "uint32_t", "u32" },
    .{ "int64_t", "i64" },
    .{ "uint64_t", "u64" },
    .{ "uintptr_t", "usize" },
    .{ "intptr_t", "isize" },
    .{ "size_t", "usize" },

    .{ "void *", "*anyopaque" },
});

const operators = std.ComptimeStringMap([]const u8, .{
    .{ "operator[]", "get" },
});

const Transpiler = struct {
    allocator: Allocator,
    out: std.ArrayList(u8).Writer,

    pub fn init(buffer: *std.ArrayList(u8), allocator: Allocator) Transpiler {
        return Transpiler{
            .allocator = allocator,
            .out = buffer.writer(),
        };
    }

    pub fn visit(self: *Transpiler, value: *const json.Value) anyerror!void {
        if (value.*.object.get("isImplicit")) |implicit| {
            if (implicit.bool) return;
        }
        const Kind = enum {
            TranslationUnitDecl,
            CXXRecordDecl,
            EnumDecl,
            TypedefDecl,
            NamespaceDecl,
            FunctionDecl,
        };
        const kind_branch = std.ComptimeStringMap(Kind, .{
            .{ "TranslationUnitDecl", .TranslationUnitDecl },
            .{ "CXXRecordDecl", .CXXRecordDecl },
            .{ "EnumDecl", .EnumDecl },
            .{ "TypedefDecl", .TypedefDecl },
            .{ "NamespaceDecl", .NamespaceDecl },
            .{ "FunctionDecl", .FunctionDecl },
        });
        var kind_tag = value.*.object.get("kind").?.string;
        if (kind_branch.get(kind_tag)) |kind| {
            switch (kind) {
                .TranslationUnitDecl => try self.visitTranslationUnitDecl(value),
                .CXXRecordDecl => try self.visitCXXRecordDecl(value),
                .EnumDecl => try self.visitEnumDecl(value),
                .TypedefDecl => try self.visitTypedefDecl(value),
                .NamespaceDecl => try self.visitNamespaceDecl(value),
                .FunctionDecl => try self.visitFunctionDecl(value),
            }
        } else {
            log.err("unhandled {s}", .{kind_tag});
        }
    }

    fn visitTranslationUnitDecl(self: *Transpiler, value: *const json.Value) !void {
        if (value.object.get("inner")) |inner| {
            for (inner.array.items) |inner_item| {
                try self.visit(&inner_item);
            }
        }
    }

    fn visitCXXRecordDecl(self: *Transpiler, value: *const json.Value) !void {
        // c++ class or struct

        var name: []const u8 = undefined;
        if (value.*.object.get("name")) |v| {
            name = v.string;
        } else {
            log.err("unnamed \"CXXRecordDecl\"", .{});
            return;
        }

        var inner = value.*.object.get("inner");
        if (inner == null) {
            log.warn("typedef {s};", .{name});
            return;
        }

        try self.out.print("pub const {s} = extern struct {{\n", .{name});

        var declbuf = std.ArrayList(u8).init(self.allocator);
        var declw = declbuf.writer();
        defer declbuf.deinit();

        const Kind = enum {
            FieldDecl,
            CXXMethodDecl,
        };
        const kind_branch = std.ComptimeStringMap(Kind, .{
            .{ "FieldDecl", .FieldDecl },
            .{ "CXXMethodDecl", .CXXMethodDecl },
        });

        for (inner.?.array.items) |inner_item| {
            if (inner_item.object.get("isImplicit")) |implicit| {
                if (implicit.bool) continue;
            }
            const kind_tag = inner_item.object.get("kind").?.string;
            if (kind_branch.get(kind_tag)) |kind| {
                switch (kind) {
                    .FieldDecl => {
                        const field_name = inner_item.object.get("name").?.string;
                        var field_type = try self.transpileType(typeOf(inner_item).?);
                        defer self.allocator.free(field_type);
                        try self.out.print("    {s}: {s},\n", .{ field_name, field_type });
                    },
                    .CXXMethodDecl => {
                        var method_name = inner_item.object.get("name").?.string;
                        if (operators.get(method_name)) |_| {
                            // todo: handle operators
                            continue;
                        }

                        var qself: []const u8 = undefined;
                        const method_tret = try self.transpileType(returnTypeOf(inner_item, &qself).?);
                        defer self.allocator.free(method_tret);

                        const method_mangled_name = inner_item.object.get("mangledName").?.string;
                        try declw.print("    pub const {s} = {s};\n", .{ method_name, method_mangled_name });
                        try declw.print("    extern fn {s}(self: *{s} {s}", .{ method_mangled_name, qself, name });

                        // method args
                        if (inner_item.object.get("inner")) |args| {
                            for (args.array.items) |arg| {
                                const arg_tag = arg.object.get("kind").?.string;
                                if (mem.eql(u8, arg_tag, "ParmVarDecl")) {
                                    var arg_type = try self.transpileType(typeOf(arg).?);
                                    defer self.allocator.free(arg_type);
                                    const arg_name = arg.object.get("name").?.string;
                                    try declw.print(", {s}: {s}", .{ arg_name, arg_type });
                                } else {
                                    log.err("unhandled arg kind {s} in method {s}.{s}", .{ arg_tag, name, method_name });
                                }
                            }
                        } else {
                            // no args
                        }

                        try declw.print(") {s};\n", .{method_tret});
                    },
                }
            } else {
                log.err("unhandled {s} in struct {s}", .{ kind_tag, name });
            }
        }

        // delcarations must be after fields
        if (declbuf.items.len > 0) {
            try self.out.print("\n{s}", .{declbuf.items});
        }

        try self.out.print("}};\n\n", .{});
    }

    fn visitEnumDecl(self: *Transpiler, value: *const json.Value) !void {
        const name = value.*.object.get("name").?.string;
        var inner = value.*.object.get("inner");
        if (inner == null) {
            log.warn("typedef {s};", .{name});
            return;
        }

        // todo: use "fixedUnderlyingType" or figure out the type by himself
        try self.out.print("pub const {s} = enum {{\n", .{name});

        for (inner.?.array.items) |inner_item| {
            if (inner_item.object.get("isImplicit")) |is_implicit| {
                if (is_implicit.bool) continue;
            }

            var variant_name = inner_item.object.get("name").?.string;
            if (mem.startsWith(u8, variant_name, name)) {
                variant_name = variant_name[name.len..];
            }

            const variant_tag = inner_item.object.get("kind").?.string;
            if (mem.eql(u8, variant_tag, "EnumConstantDecl")) {
                try self.out.print("    {s}", .{variant_name});
                // todo: figure out enum constexp
                // if (try transpileOptionalEnumValue(inner_val, allocator)) |enum_value| {
                //     try self.out.print("{s}", .{enum_value});
                //     allocator.free(enum_value);
                // }
                try self.out.print(",\n", .{});
            } else {
                log.err("unhandled {s} in enum {s}.{s}", .{ variant_tag, name, variant_name });
            }
        }

        try self.out.print("}};\n\n", .{});
    }

    fn visitTypedefDecl(self: *Transpiler, value: *const json.Value) !void {
        const name = value.*.object.get("name").?.string;
        const type_alised = try self.transpileType(typeOf(value.*).?);
        defer self.allocator.free(type_alised);
        try self.out.print("pub const {s} = {s};\n", .{ name, type_alised });
    }

    fn visitNamespaceDecl(self: *Transpiler, value: *const json.Value) !void {
        const namespace_name = value.*.object.get("name").?.string;

        var inner = value.*.object.get("inner");
        if (inner == null) {
            log.warn("empty namespace {s}", .{namespace_name});
            return;
        }

        // todo: namespace merging
        try self.out.print("pub const {s} = struct {{\n", .{namespace_name});

        // const pw = self.out;
        // var buffer = std.ArrayList(u8).init(u8);
        // self.out = buffer.writer();

        for (inner.?.array.items) |inner_item| {
            try self.visit(&inner_item);
        }

        //self.out = pw;

        try self.out.print("}};\n\n", .{});
    }

    fn visitFunctionDecl(self: *Transpiler, value: *const json.Value) !void {
        var qself: []const u8 = undefined;
        const method_tret = try self.transpileType(returnTypeOf(value.*, &qself).?);
        defer self.allocator.free(method_tret);

        var function_name = value.*.object.get("name").?.string;
        if (mem.startsWith(u8, function_name, "operator ")) {
            // todo: handle global operators
            return;
        }

        const function_mangled_name = value.*.object.get("mangledName").?.string;
        try self.out.print("    pub const {s} = {s};\n", .{ function_name, function_mangled_name });
        try self.out.print("    extern fn {s}(", .{function_mangled_name});

        // function args
        if (value.*.object.get("inner")) |args| {
            var comma = false;
            for (args.array.items) |arg| {
                const arg_tag = arg.object.get("kind").?.string;
                if (mem.eql(u8, arg_tag, "ParmVarDecl")) {
                    if (comma) {
                        try self.out.print(", ", .{});
                    }
                    comma = true;

                    var arg_type = try self.transpileType(typeOf(arg).?);
                    defer self.allocator.free(arg_type);
                    if (arg.object.get("name")) |arg_name| {
                        try self.out.print("{s}: {s}", .{ arg_name.string, arg_type });
                    } else {
                        try self.out.print("_: {s}", .{arg_type});
                    }
                } else {
                    log.err("unhandled arg kind {s} in function {s}", .{ arg_tag, function_name });
                }
            }
        } else {
            // no args
        }

        try self.out.print(") {s};\n", .{method_tret});
    }

    fn typeOf(value: json.Value) ?[]const u8 {
        if (value.object.get("type")) |tval| {
            if (tval.object.get("qualType")) |qval| {
                return qval.string;
            }
        }
        return null;
    }

    fn returnTypeOf(value: json.Value, qself: *[]const u8) ?[]const u8 {
        if (typeOf(value)) |qstr| {
            if (mem.endsWith(u8, qstr, ") const")) {
                qself.* = "const";
            } else {
                qself.* = "";
            }
            var s = mem.split(u8, qstr, "(");
            return s.first();
        }
        return null;
    }

    // primitives
    // pointers and aliased pointers
    // fixed sized arrays
    // templated types
    // self described pointers to functions: void (*)(Object*, int)
    pub fn transpileType(self: *Transpiler, tname: []const u8) ![]u8 {
        var ttname = mem.trim(u8, tname, " ");
        const ch = ttname[ttname.len - 1];
        if (ch == '*' or ch == '&') {
            // pointer or alised pointer
            if (mem.startsWith(u8, ttname, "const ")) {
                var inner_name = try self.transpileType(ttname[("const ".len)..(ttname.len - 1)]);
                defer self.allocator.free(inner_name);
                return try fmt.allocPrint(self.allocator, "*const {s}", .{inner_name});
            } else {
                var inner_name = try self.transpileType(ttname[0..(ttname.len - 1)]);
                defer self.allocator.free(inner_name);
                return try fmt.allocPrint(self.allocator, "*{s}", .{inner_name});
            }
        } else if (ch == ']') {
            // fixed sized array
            const len = mem.lastIndexOf(u8, ttname, "[").?;
            var inner_name = try self.transpileType(ttname[0..len]);
            defer self.allocator.free(inner_name);
            return try fmt.allocPrint(self.allocator, "{s}{s}", .{ ttname[len..], inner_name });
        } else if (ch == ')') {
            // function pointer or invalid type name
            if (mem.indexOf(u8, ttname, "(*)")) |ptr| {
                var index: usize = 0;
                var targs = std.ArrayList(u8).init(self.allocator);
                defer targs.deinit();
                try self.transpileTypeArgs(mem.trim(u8, ttname[(ptr + "(*)".len) + 1 .. ttname.len - 1], " "), &targs, &index);

                const tret = try self.transpileType(ttname[0..ptr]);
                defer self.allocator.free(tret);

                return try fmt.allocPrint(self.allocator, "*const fn({s}) {s}", .{ targs.items, tret });
            } else {
                log.err("unknow type `{s}`, falling back to `*anyopaque`", .{ttname});
                ttname = "*anyopaque";
            }
        } else if (ch == '>') {
            // templated type
            var index: usize = 0;
            var targs = std.ArrayList(u8).init(self.allocator);
            defer targs.deinit();
            try self.transpileTypeArgs(tname, &targs, &index);

            var buf = try self.allocator.alloc(u8, targs.items.len);
            mem.copyForwards(u8, buf, targs.items);
            return buf;
        } else {
            // common primitives
            if (primitives.get(ttname)) |pname| {
                ttname = pname;
            }
        }

        var buf = try self.allocator.alloc(u8, ttname.len);
        mem.copyForwards(u8, buf, ttname);
        return buf;
    }

    // generics `Vector<TypeArgs>`
    // function arguments without parameters name in fn pointers `const void (x)(TypeArgs)`
    fn transpileTypeArgs(self: *Transpiler, tname: []const u8, buffer: *std.ArrayList(u8), index: *usize) anyerror!void {
        var start = index.*;
        while (index.* < tname.len) {
            const ch = tname[index.*];
            if (ch == '<') {
                try buffer.*.appendSlice(tname[start..index.*]);
                try buffer.*.append('(');
                index.* += 1;
                try self.transpileTypeArgs(tname, buffer, index);
                start = index.*;
                continue;
            } else if (ch == '>') {
                const name = try self.transpileType(tname[start..index.*]);
                defer self.allocator.free(name);
                try buffer.*.appendSlice(name);
                try buffer.*.append(')');
                index.* += 1;
                return;
            } else if (ch == ',') {
                if (index.* > start) {
                    const name = try self.transpileType(tname[start..index.*]);
                    defer self.allocator.free(name);
                    try buffer.*.appendSlice(name);
                    try buffer.*.append(',');
                    start = index.* + 1;
                } else {
                    start = index.*;
                }
            }
            index.* += 1;
        }
    }

    // fn transpileOptionalEnumValue(self: *Transpiler, decl: json.Value, allocator: Allocator) !?[]const u8 {
    //     _ = self;
    //     _ = allocator;
    //     if (decl.object.get("inner")) |inner_val| {
    //         _ = inner_val;
    //         //log.err("unparsed enum value {s}", .{inner_val.object.get("kind").?.string});
    //     }
    //
    //     // nothing to transpile
    //     return null;
    // }

    pub fn deinit(self: *Transpiler) void {
        _ = self;
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.testing.expect(gpa.deinit() != .leak) catch @panic("memory leak");
    const allocator = gpa.allocator();

    const params = comptime clap.parseParamsComptime(
        \\-h, --help             Display this help and exit.
        \\--std <str>            C++ version, default c++11.
        \\<str>...
        \\
    );

    var diag = clap.Diagnostic{};
    var res = clap.parse(clap.Help, &params, clap.parsers.default, .{ .diagnostic = &diag }) catch |err| {
        // Report useful error and exit
        diag.report(io.getStdErr().writer(), err) catch {};
        return err;
    };
    defer res.deinit();

    if (res.args.help != 0) {
        return clap.help(io.getStdErr().writer(), clap.Help, &params, .{});
    }

    var c_ver: []const u8 = "-std=c++11";
    if (res.args.std) |s| {
        c_ver = s;
    }

    const cwd = try std.fs.cwd().realpathAlloc(allocator, "");
    defer allocator.free(cwd);

    for (res.positionals) |input_file| {
        log.info("binding \"{s}\"", .{input_file});

        // zig cc -x c++ -std=c++11 -Xclang -ast-dump=json {input_file}
        var process = try std.ChildProcess.exec(.{
            .allocator = allocator,
            .argv = &.{ "zig", "cc", "-x", "c++", c_ver, "-Xclang", "-ast-dump=json", input_file },
            .max_output_bytes = 512 * 1024 * 1024,
        });
        defer {
            allocator.free(process.stdout);
            allocator.free(process.stderr);
        }

        var parser = json.Parser.init(allocator, .alloc_if_needed);
        defer parser.deinit();

        var tree = try parser.parse(process.stdout);
        defer tree.deinit();

        var buffer = std.ArrayList(u8).init(allocator);
        defer buffer.deinit();
        var transpiler = Transpiler.init(&buffer, allocator);
        defer transpiler.deinit();
        try transpiler.visit(&tree.root);

        var path = std.ArrayList(u8).init(allocator);
        try path.writer().print("{s}.zig", .{std.fs.path.stem(input_file)});
        defer path.deinit();

        var file = try std.fs.cwd().createFile(path.items, .{});
        defer file.close();

        log.debug("bytes: {}", .{buffer.items.len});
        try file.writeAll(buffer.items);
    }
}
