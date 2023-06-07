const std = @import("std");
const clap = @import("clap");
const debug = std.debug;
const io = std.io;
const log = std.log;
const json = std.json;
const mem = std.mem;
const fmt = std.fmt;

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

inline fn isPointerType(name: []const u8) bool {
    return mem.containsAtLeast(u8, name, 1, '*');
}

fn resolveType(decl: json.Value, allocator: mem.Allocator) ![]u8 {
    const type_object = decl.object.get("type").?.object;
    const type_qualifer = type_object.get("qualType").?.string;
    return try transpileType(type_qualifer, allocator);
}

fn resolveReturnType(decl: json.Value, self_ptr: *[]const u8, allocator: mem.Allocator) ![]const u8 {
    const type_object = decl.object.get("type").?.object;
    const type_qualifer = type_object.get("qualType").?.string;

    if (mem.endsWith(u8, type_qualifer, ") const")) {
        self_ptr.* = "const";
    } else {
        self_ptr.* = "";
    }

    var type_iter = mem.split(u8, type_qualifer, "(");
    return try transpileType(type_iter.first(), allocator);
}

fn transpileTypeArgs(in: []const u8, i: *usize, out: *std.ArrayList(u8)) anyerror!void {
    var j = i.*;
    while (i.* < in.len) {
        const ch = in[i.*];
        if (ch == '<') {
            try out.*.appendSlice(in[j..i.*]);
            try out.*.append('(');
            i.* += 1;

            try transpileTypeArgs(in, i, out);
            j = i.*;
            continue;
        } else if (ch == '>') {
            const name = try transpileType(in[j..i.*], out.*.allocator);
            defer out.*.allocator.free(name);
            try out.*.appendSlice(name);
            try out.*.append(')');
            i.* += 1;
            return;
        } else if (ch == ',') {
            if (i.* > j) {
                const name = try transpileType(in[j..i.*], out.*.allocator);
                defer out.*.allocator.free(name);
                try out.*.appendSlice(name);
                try out.*.append(',');
                j = i.* + 1;
            } else {
                j = i.*;
            }
        }
        i.* += 1;
    }
}

// i think I really need a
fn transpileType(in: []const u8, allocator: mem.Allocator) ![]u8 {
    var name = mem.trim(u8, in, " ");
    const ch = name[name.len - 1];
    if (ch == '*' or ch == '&') {
        // pointer
        if (mem.startsWith(u8, name, "const ")) {
            var inner_name = try transpileType(name[("const ".len)..(name.len - 1)], allocator);
            defer allocator.free(inner_name);
            return try fmt.allocPrint(allocator, "*const {s}", .{inner_name});
        } else {
            var inner_name = try transpileType(name[0..(name.len - 1)], allocator);
            defer allocator.free(inner_name);
            return try fmt.allocPrint(allocator, "*{s}", .{inner_name});
        }
    } else if (ch == ']') {
        // fixed sized array
        const len = mem.lastIndexOf(u8, name, "[").?;
        var inner_name = try transpileType(name[0..len], allocator);
        defer allocator.free(inner_name);
        return try fmt.allocPrint(allocator, "{s}{s}", .{ name[len..], inner_name });
    } else if (ch == ')') {
        if (mem.indexOf(u8, name, "(*)")) |ptr| {
            const raw = mem.trim(u8, name[(ptr + "(*)".len)..], " ");
            var i: usize = 0;
            var args = std.ArrayList(u8).init(allocator);
            defer args.deinit();
            try transpileTypeArgs(raw[1 .. raw.len - 1], &i, &args);

            const ret = try transpileType(name[0..ptr], allocator);
            defer allocator.free(ret);

            return try fmt.allocPrint(allocator, "*const fn({s}) {s}", .{ args.items, ret });
        } else {
            log.err("??? {s}", .{name});
            name = "*anyopaque";
        }
    } else if (ch == '>') {
        var i: usize = 0;
        var args = std.ArrayList(u8).init(allocator);
        defer args.deinit();
        try transpileTypeArgs(in, &i, &args);
        var buf = try allocator.alloc(u8, args.items.len);
        mem.copyForwards(u8, buf, args.items);
        return buf;
    } else {
        // common primitives
        if (primitives.get(name)) |pname| {
            name = pname;
        }
    }

    var buf = try allocator.alloc(u8, name.len);
    mem.copyForwards(u8, buf, name);
    return buf;
}

fn transpileOptionalEnumValue(decl: json.Value, allocator: mem.Allocator) !?[]u8 {
    _ = allocator;
    if (decl.object.get("inner")) |inner_val| {
        _ = inner_val;
        //log.err("unparsed enum value {s}", .{inner_val.object.get("kind").?.string});
    }

    // nothing to transpile
    return null;
}

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

        var root = &tree.root.object;
        debug.assert(mem.eql(u8, root.get("kind").?.string, "TranslationUnitDecl"));

        var output_path = std.ArrayList(u8).init(allocator);
        try output_path.writer().print("{s}.zig", .{std.fs.path.stem(input_file)});
        defer output_path.deinit();

        var output = try std.fs.cwd().createFile(output_path.items, .{});
        defer output.close();

        var writer = output.writer();
        for (root.get("inner").?.array.items) |val| {
            var decl = val.object;

            // ignore implicit declarations, because they are basically garbage right now
            if (decl.get("isImplicit")) |is_implicit| {
                if (is_implicit.bool) continue;
            }
            var kind = decl.get("kind").?.string;
            if (mem.eql(u8, kind, "CXXRecordDecl")) {
                // c++ class or struct

                const name = blk: {
                    if (decl.get("name")) |name_val| {
                        break :blk name_val.string;
                    } else {
                        log.err("unnamed \"{s}\"", .{kind});
                        continue;
                    }
                };

                var inner = decl.get("inner");
                if (inner == null) {
                    log.warn("typedef {s};", .{name});
                    continue;
                }

                try writer.print("pub const {s} = extern struct {{\n", .{name});

                var decls_buffer = std.ArrayList(u8).init(allocator);
                defer decls_buffer.deinit();
                var decls_writer = decls_buffer.writer();

                for (inner.?.array.items) |inner_val| {
                    const inner_decl = inner_val.object;
                    if (inner_decl.get("isImplicit")) |is_implicit| {
                        if (is_implicit.bool) continue;
                    }
                    const inner_kind = inner_decl.get("kind").?.string;
                    if (mem.eql(u8, inner_kind, "FieldDecl")) {
                        const inner_name = inner_decl.get("name").?.string;
                        var inner_type_qualifer = try resolveType(inner_val, allocator);
                        defer allocator.free(inner_type_qualifer);
                        try writer.print("    {s}: {s},\n", .{ inner_name, inner_type_qualifer });
                    } else if (mem.eql(u8, inner_kind, "CXXMethodDecl")) {
                        var inner_name = inner_decl.get("name").?.string;
                        if (operators.get(inner_name)) |_| {
                            //inner_name = replace;
                            // figure out the get and set functions ...
                            continue;
                        }

                        // todo: if ends with const is should use *const Self
                        var self_ptr: []const u8 = undefined;
                        const inner_type_qualifer = try resolveReturnType(inner_val, &self_ptr, allocator);
                        defer allocator.free(inner_type_qualifer);

                        const inner_mangled_name = inner_decl.get("mangledName").?.string;
                        try decls_writer.print("    pub const {s} = {s};\n", .{ inner_name, inner_mangled_name });
                        try decls_writer.print("    extern fn {s} (self: *{s} {s}", .{ inner_mangled_name, self_ptr, name });

                        // params
                        if (inner_decl.get("inner")) |args| {
                            for (args.array.items) |arg_val| {
                                const arg_decl = arg_val.object;
                                const arg_kind = arg_decl.get("kind").?.string;
                                if (mem.eql(u8, arg_kind, "ParmVarDecl")) {
                                    const arg_type_qualifer = try resolveType(arg_val, allocator);
                                    defer allocator.free(arg_type_qualifer);
                                    const arg_name = arg_decl.get("name").?.string;
                                    // todo: resolveArgType
                                    try decls_writer.print(", {s}: {s}", .{ arg_name, arg_type_qualifer });
                                } else {
                                    log.err("unhandled arg {s} in method {s}.{s}", .{ arg_kind, name, inner_name });
                                }
                            }
                        } else {
                            // method has no args
                        }

                        // firgure out return type
                        try decls_writer.print(") {s};\n", .{inner_type_qualifer});
                    } else {
                        log.err("unhandled {s} in struct {s}", .{ inner_kind, name });
                    }
                }

                // delcarations must be after fields
                if (decls_buffer.items.len > 0) {
                    try writer.print("\n{s}", .{decls_buffer.items});
                }

                try writer.print("}};\n\n", .{});
            } else if (mem.eql(u8, kind, "EnumDecl")) {
                // enum
                const name = decl.get("name").?.string;

                var inner = decl.get("inner");
                if (inner == null) {
                    log.warn("typedef {s};", .{name});
                    continue;
                }

                // handling this crap is throuble some ...
                if (decl.get("fixedUnderlyingType")) |type_object| {
                    var enum_type = try transpileType(type_object.object.get("qualType").?.string, allocator);
                    defer allocator.free(enum_type);
                    try writer.print("pub const {s} = enum({s}) {{\n", .{ name, enum_type });
                } else {
                    // todo: still need to figure out the it's type
                    try writer.print("pub const {s} = enum {{\n", .{name});
                }

                for (inner.?.array.items) |inner_val| {
                    if (inner_val.object.get("isImplicit")) |is_implicit| {
                        if (is_implicit.bool) continue;
                    }
                    const inner_kind = inner_val.object.get("kind").?.string;

                    var inner_name = inner_val.object.get("name").?.string;
                    if (mem.startsWith(u8, inner_name, name)) {
                        inner_name = inner_name[name.len..];
                    }

                    if (mem.eql(u8, inner_kind, "EnumConstantDecl")) {
                        try writer.print("    {s}", .{inner_name});
                        if (try transpileOptionalEnumValue(inner_val, allocator)) |enum_value| {
                            try writer.print("{s}", .{enum_value});
                            allocator.free(enum_value);
                        }
                        try writer.print(",\n", .{});
                    } else {
                        log.err("unhandled {s} in enum {s}.{s}", .{ inner_kind, name, inner_name });
                    }
                }

                try writer.print("}};\n\n", .{});
            } else if (mem.eql(u8, kind, "TypedefDecl")) {
                const name = decl.get("name").?.string;
                const type_alised = try resolveType(val, allocator);
                defer allocator.free(type_alised);
                try writer.print("pub const {s} = {s};\n", .{ name, type_alised });
            } else if (mem.eql(u8, kind, "NamespaceDecl")) {
                const name = decl.get("name").?.string;
                for (decl.get("inner").?.array.items) |inner_val| {
                    var inner_decl = inner_val.object;

                    // ignore implicit declarations, because they are basically garbage right now
                    if (inner_decl.get("isImplicit")) |is_implicit| {
                        if (is_implicit.bool) continue;
                    }

                    const inner_kind = inner_val.object.get("kind").?.string;
                    //const inner_name = inner_val.object.get("name").?.string;
                    log.err("unhandled {s} in namespace {s}", .{ inner_kind, name });

                    // these inner types needed to be handled recursivelly
                }
            } else {
                log.err("unhandled {s}", .{kind});
            }
        }

        // var index: usize = 0;
        // var a = std.ArrayList(u8).init(allocator);
        // defer a.deinit();
        // try transpileTypeArgs("a<b>, c<d, e>", &index, &a);
        // log.info("{s}", .{a.items});

        // var a = smol.Vec2{ .x = 1, .y = 0 };
        // const b = smol.Vec2{ .x = 1, .y = 1 };
        // const c = a.add(b);
        // log.debug("x = {}, y = {}", .{ c.x, c.y });
        // log.debug("{}", .{c});

        // ignore isImplicit: true

        // CXXRecordDecl or RecordDecl, FieldDecl
        // CXXMethodDecl, ParmVarDecl
        // FunctionDecl
        // TypedefDecl

        // demangled functions
        // pub const vec2_sub = _Z8vec2_sub4Vec2S_;
        // extern fn _Z8vec2_sub4Vec2S_(a: Vec2, b: Vec2) Vec2;
    }
}
