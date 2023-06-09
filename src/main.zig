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

// const Color = union {
//     mU32: u32,
//     _: struct {
//         r: u8,
//         g: u8,
//         b: u8,
//         a: u8,
//     },

//     const sWhite = Color{ .mU32 = 0xFF_FF_FF_FF };

//     fn rg(self: *Color) [2]u8 {
//         return .{ self._.r, self._.g };
//     }
// };

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

// todo: "inline" methods and functions
const Transpiler = struct {
    const FnSig = struct {
        const_self: bool = false,
        varidatic: bool = false,
        ret_type: []const u8 = "",
    };

    allocator: Allocator,
    out: std.ArrayList(u8).Writer,
    nodes: std.AutoHashMap(u64, json.Value),

    // options
    transpile_includes: bool = false,
    zigify: bool = false,

    pub fn init(buffer: *std.ArrayList(u8), allocator: Allocator) Transpiler {
        return Transpiler{
            .allocator = allocator,
            .out = buffer.writer(),
            .nodes = std.AutoHashMap(u64, json.Value).init(allocator),
        };
    }

    pub fn visit(self: *Transpiler, value: *const json.Value) anyerror!void {
        if (value.*.object.get("isImplicit")) |implicit| {
            if (implicit.bool) return;
        }
        var kind_tag = value.*.object.get("kind").?.string;
        if (mem.eql(u8, kind_tag, "TranslationUnitDecl")) {
            try self.visitTranslationUnitDecl(value);
        } else if (mem.eql(u8, kind_tag, "LinkageSpecDecl")) {
            try self.visitLinkageSpecDecl(value);
        } else if (mem.eql(u8, kind_tag, "CXXRecordDecl")) {
            try self.visitCXXRecordDecl(value);
        } else if (mem.eql(u8, kind_tag, "EnumDecl")) {
            try self.visitEnumDecl(value);
        } else if (mem.eql(u8, kind_tag, "TypedefDecl")) {
            try self.visitTypedefDecl(value);
        } else if (mem.eql(u8, kind_tag, "NamespaceDecl")) {
            try self.visitNamespaceDecl(value);
        } else if (mem.eql(u8, kind_tag, "FunctionDecl")) {
            try self.visitFunctionDecl(value);
        } else if (mem.eql(u8, kind_tag, "ClassTemplateDecl")) {
            try self.visitClassTemplateDecl(value);
        } else {
            log.err("unhandled `{s}`", .{kind_tag});
        }
    }

    fn visitLinkageSpecDecl(self: *Transpiler, value: *const json.Value) !void {
        if (value.*.object.get("language")) |v_lang| {
            if (mem.eql(u8, v_lang.string, "C")) {
                // c lang, basically tells the compiler no function overload so don't mangle
            } else {
                log.err("unknow language `{s}` in  `LinkageSpecDecl`", .{v_lang.string});
                return;
            }
        } else {
            log.err("unspecified language in  `LinkageSpecDecl`", .{});
            return;
        }

        if (value.object.get("inner")) |inner| {
            for (inner.array.items) |inner_item| {
                try self.visit(&inner_item);
            }
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
        if (self.shouldSkip(value)) {
            return;
        }

        var name: []const u8 = undefined;
        if (value.*.object.get("name")) |v| {
            name = v.string;
        } else {
            const id_name = value.*.object.get("id").?.string;
            const id = try std.fmt.parseInt(u64, id_name, 0);
            _ = try self.nodes.put(id, value.*);
            //log.err("unhandled unnamed `CXXRecordDecl` with id `{s}`", .{id_name});
            return;
        }

        var inner = value.*.object.get("inner");
        if (inner == null) {
            log.warn("opaque `{s}`", .{name});
            // try self.out.print("pub const {s} = anyopaque;\n", .{name});
            return;
        }

        try self.out.print("pub const {s} = extern struct {{\n", .{name});

        var declbuf = std.ArrayList(u8).init(self.allocator);
        defer declbuf.deinit();

        for (inner.?.array.items) |inner_item| {
            if (inner_item.object.get("isImplicit")) |implicit| {
                if (implicit.bool) continue;
            }
            const kind_tag = inner_item.object.get("kind").?.string;
            if (mem.eql(u8, kind_tag, "FieldDecl")) {
                const field_name = inner_item.object.get("name").?.string;

                if (inner_item.object.get("isInvalid")) |invalid| {
                    if (invalid.bool) {
                        log.err("invalid field `{s}::{s}`", .{ name, field_name });
                        continue;
                    }
                }

                var field_type = try self.transpileType(typeQualifier(&inner_item).?);
                defer self.allocator.free(field_type);
                try self.out.print("    {s}: {s},\n", .{ field_name, field_type });
            } else if (mem.eql(u8, kind_tag, "CXXMethodDecl")) {
                const tmp = self.out;
                self.out = declbuf.writer();
                try self.visitCXXMethodDecl(&inner_item, name);
                self.out = tmp;
            } else if (mem.eql(u8, kind_tag, "CXXRecordDecl")) {
                // nested stucts
                try self.visitCXXRecordDecl(&inner_item);
            } else {
                log.err("unhandled `{s}` in struct `{s}`", .{ kind_tag, name });
            }
        }

        // delcarations must be after fields
        if (declbuf.items.len > 0) {
            try self.out.print("\n{s}", .{declbuf.items});
        }

        try self.out.print("}};\n\n", .{});
    }

    fn visitCXXMethodDecl(self: *Transpiler, value: *const json.Value, parent: ?[]const u8) !void {
        const sig = parseFnSignature(value).?;

        var method_name = value.*.object.get("name").?.string;
        if (mem.startsWith(u8, method_name, "operator")) {
            var op = method_name["operator".len..];
            if (op.len > 0 and std.ascii.isAlphanumeric(op[0])) {
                // just a function starting with operator
            } else {
                // todo: implicit casting
                // todo: operator overloads
                if (mem.eql(u8, op, "[]")) {
                    if (!sig.const_self and mem.endsWith(u8, sig.ret_type, "&")) {
                        // class[i] = value;
                        method_name = "getRef";
                    } else {
                        // value = class[i];
                        method_name = "get";
                    }
                    // } else if (mem.eql(u8, op, " new")) {
                    // } else if (mem.eql(u8, op, " delete")) {
                } else {
                    log.err("unhandled operator `{s}` in `{?s}`", .{ op[1..], parent });
                    return;
                }
            }
        }

        if (value.*.object.get("isInvalid")) |invalid| {
            if (invalid.bool) {
                log.err("invalid method `{?s}::{s}`", .{ parent, method_name });
                return;
            }
        }

        // todo: deal with inlined methods
        // var inlined = false;
        // if (value.*.object.get("inline")) |v_inline| {
        //     inlined = v_inline.bool;
        //     if (inlined) {
        //         //
        //         log.err("unhandled inlined method `{?s}::{s}`", .{ parent, method_name });
        //         return;
        //     }
        // }

        const method_tret = try self.transpileType(sig.ret_type);
        defer self.allocator.free(method_tret);

        const method_mangled_name = value.*.object.get("mangledName").?.string;

        // functions decorated with `extern "C"` won't be mangled
        const is_mangled = !mem.eql(u8, method_mangled_name, method_name);

        if (!is_mangled) try self.out.print("pub ", .{});
        try self.out.print("extern fn {s}(", .{method_mangled_name});

        var comma = false;

        if (parent) |name| {
            comma = true;
            if (sig.const_self) {
                try self.out.print("self: *const {s}", .{name});
            } else {
                try self.out.print("self: *{s}", .{name});
            }
        }

        // method args
        if (value.*.object.get("inner")) |args| {
            for (args.array.items) |v_arg| {
                const arg_tag = v_arg.object.get("kind").?.string;
                if (mem.eql(u8, arg_tag, "ParmVarDecl")) {
                    const v_type = v_arg.object.get("type").?;
                    var v_qual = v_type.object.get("qualType").?.string;

                    // va_list is in practice a `char*`, but we can double check this by verifing the desugared type
                    if (mem.eql(u8, v_qual, "va_list")) {
                        if (v_type.object.get("desugaredQualType")) |v_desurgared| {
                            v_qual = v_desurgared.string;
                        }
                    }

                    var arg_type = try self.transpileType(v_qual);
                    defer self.allocator.free(arg_type);

                    var arg_name: []const u8 = "_";
                    if (v_arg.object.get("name")) |v_arg_name| {
                        arg_name = v_arg_name.string;
                    }

                    if (comma) {
                        try self.out.print(", ", .{});
                    }
                    comma = true;

                    try self.out.print("{s}: {s}", .{ arg_name, arg_type });
                } else if (mem.eql(u8, arg_tag, "FormatAttr")) {
                    // varidatic function with the same properties as printf
                } else {
                    log.err("unhandled `{s}` in function `{?s}::{s}`", .{ arg_tag, parent, method_name });
                }
            }
        } else {
            // no args
        }

        if (sig.varidatic) {
            if (comma) {
                try self.out.print(", ", .{});
            }
            try self.out.print("...) callconv(.C) {s};\n", .{method_tret});
        } else {
            try self.out.print(") {s};\n", .{method_tret});
        }

        if (is_mangled) {
            try self.out.print("pub const {s} = {s};\n\n", .{ method_name, method_mangled_name });
        }
    }

    fn visitEnumDecl(self: *Transpiler, value: *const json.Value) !void {
        if (self.shouldSkip(value)) {
            return;
        }

        var name: []const u8 = undefined;
        if (value.*.object.get("name")) |v| {
            name = v.string;
        } else {
            // todo: solved by id inside a ElaboratedType.ownedTagDecl.id
            log.err("unhandled unnamed `EnumDecl`", .{});
            return;
        }

        var inner = value.*.object.get("inner");
        if (inner == null) {
            log.warn("typedef `{s}`", .{name});
            return;
        }

        // todo: use "fixedUnderlyingType" or figure out the type by himself
        try self.out.print("pub const {s} = enum(c_int) {{\n", .{name});

        for (inner.?.array.items) |inner_item| {
            if (inner_item.object.get("isImplicit")) |is_implicit| {
                if (is_implicit.bool) continue;
            }

            const variant_tag = inner_item.object.get("kind").?.string;
            if (mem.eql(u8, variant_tag, "EnumConstantDecl")) {
                var variant_name = inner_item.object.get("name").?.string;
                if (mem.startsWith(u8, variant_name, name)) {
                    variant_name = variant_name[name.len..];
                }
                try self.out.print("    {s}", .{variant_name});
                // todo: figure out enum constexp
                // if (try transpileOptionalEnumValue(inner_val, allocator)) |enum_value| {
                //     try self.out.print("{s}", .{enum_value});
                //     allocator.free(enum_value);
                // }
                try self.out.print(",\n", .{});
            } else {
                log.err("unhandled `{s}` in enum `{s}`", .{ variant_tag, name });
            }
        }

        try self.out.print("}};\n\n", .{});
    }

    fn visitTypedefDecl(self: *Transpiler, value: *const json.Value) !void {
        if (self.shouldSkip(value)) {
            return;
        }

        const name = value.*.object.get("name").?.string;

        if (value.*.object.get("inner")) |v_inner| {
            if (v_inner.array.items.len != 1) {
                log.err("complex typedef `{s}`", .{name});
                return;
            }

            const v_item = &v_inner.array.items[0];
            const tag = v_item.*.object.get("kind").?.string;
            if (mem.eql(u8, tag, "BuiltinType") or mem.eql(u8, tag, "TypedefType")) {
                // type alias
            } else if (mem.eql(u8, tag, "ElaboratedType")) {
                // c style simplified struct definition
                if (v_item.*.object.get("ownedTagDecl")) |v_owned| {
                    const id_name = v_owned.object.get("id").?.string;
                    const id = try std.fmt.parseInt(u64, id_name, 0);
                    if (self.nodes.get(id)) |node| {
                        const n_tag = node.object.get("kind").?.string;
                        if (mem.eql(u8, n_tag, "CXXRecordDecl")) {
                            var object = try node.object.clone();
                            defer object.deinit();
                            // rename the object
                            _ = try object.put("name", json.Value{ .string = name });
                            // todo: impl the union or struct or whatever using `name`
                            try self.visitCXXRecordDecl(&json.Value{ .object = object });
                        } else {
                            log.err("unhandled `ElaboratedType` `{s}` in typedef `{s}`", .{ n_tag, name });
                        }
                    } else {
                        // currenly been triggered by: `typedef struct Point { float x, y; } Point;`
                        log.err("missing node `{s}` of `ElaboratedType` in typedef `{s}`", .{ id_name, name });
                    }
                    return;
                } else {
                    // other kind of type alias
                    // todo: use the inner "RecordType"
                }
            } else {
                log.err("unhandled `{s}` in typedef `{s}`", .{ tag, name });
                return;
            }

            // default type alias behaviour
            const type_alised = try self.transpileType(typeQualifier(v_item).?);
            defer self.allocator.free(type_alised);
            try self.out.print("pub const {s} = {s};\n\n", .{ name, type_alised });
        }
    }

    fn visitNamespaceDecl(self: *Transpiler, value: *const json.Value) !void {
        if (self.shouldSkip(value)) {
            return;
        }

        const v_name = value.*.object.get("name");

        var inner = value.*.object.get("inner");
        if (inner == null) {
            if (v_name) |name| {
                log.warn("empty namespace `{s}`", .{name.string});
            } else {
                // super cursed edge case
                log.warn("empty and unamed namespace", .{});
            }
            return;
        }

        // todo: namespace merging

        if (v_name) |name| {
            try self.out.print("pub const {s} = struct {{\n", .{name.string});
        }

        // const pw = self.out;
        // var buffer = std.ArrayList(u8).init(u8);
        // self.out = buffer.writer();

        for (inner.?.array.items) |inner_item| {
            try self.visit(&inner_item);
        }

        //self.out = pw;

        if (v_name) |_| {
            try self.out.print("}};\n\n", .{});
        }
    }

    inline fn visitFunctionDecl(self: *Transpiler, value: *const json.Value) !void {
        // a function is a method without a parent struct
        return self.visitCXXMethodDecl(value, null);
    }

    fn visitClassTemplateDecl(self: *Transpiler, value: *const json.Value) !void {
        if (self.shouldSkip(value)) {
            return;
        }

        var name: []const u8 = undefined;
        if (value.*.object.get("name")) |v| {
            name = v.string;
        } else {
            log.err("unnamed `ClassTemplateDecl`", .{});
            return;
        }

        var inner = value.*.object.get("inner");
        if (inner == null) {
            log.warn("opaque `{s}`", .{name});
            return;
        }

        // pub fn Generic(comptime T: type, ...) {
        //    return struct {
        //    };
        // };

        try self.out.print("pub fn {s}(", .{name});

        // template param
        var tp_comma = false;
        for (inner.?.array.items) |item| {
            const item_kind = item.object.get("kind").?.string;
            if (mem.eql(u8, item_kind, "TemplateTypeParmDecl")) {
                var v_item_name = item.object.get("name");
                if (v_item_name == null) {
                    log.err("unnamed template param in `{s}`", .{name});
                    continue;
                }

                var v_item_tag = item.object.get("tagUsed");
                if (v_item_tag == null) {
                    log.err("untaged template param in `{s}`", .{name});
                    continue;
                }

                const item_name = v_item_name.?.string;
                const item_tag = v_item_tag.?.string;

                if (tp_comma) {
                    try self.out.print(", ", .{});
                }
                tp_comma = true;

                if (mem.eql(u8, item_tag, "typename")) {
                    try self.out.print("comptime {s}: type", .{item_name});
                } else {
                    // todo: use anytype to handle untyped template params
                    log.err("unknown template param `{s} {s}` in `{s}`", .{ item_tag, item_name, name });
                }
            } else if (mem.eql(u8, item_kind, "CXXRecordDecl")) {
                // template definition
                try self.out.print(") type {{\n    return extern struct {{\n", .{});

                var inner_inner = item.object.get("inner");
                if (inner_inner == null) {
                    log.warn("blank `{s}` template", .{name});
                    return;
                }

                for (inner_inner.?.array.items) |inner_item| {
                    const inner_item_kind = inner_item.object.get("kind").?.string;
                    if (mem.eql(u8, inner_item_kind, "CXXRecordDecl")) {
                        // class or struct
                    } else if (mem.eql(u8, inner_item_kind, "FieldDecl")) {
                        const field_name = inner_item.object.get("name").?.string;
                        var field_type = try self.transpileType(typeQualifier(&inner_item).?);
                        defer self.allocator.free(field_type);
                        try self.out.print("        {s}: {s},\n", .{ field_name, field_type });
                    } else {
                        log.err("unhandled `{s}` in template `{s}`", .{ inner_item_kind, name });
                    }
                }

                try self.out.print("    }};\n}}\n\n", .{});

                return;
            }
        }

        // todo: error ?!?!
    }

    inline fn typeQualifier(value: *const json.Value) ?[]const u8 {
        if (value.*.object.get("type")) |tval| {
            if (tval.object.get("qualType")) |qval| {
                return qval.string;
            }
        }
        return null;
    }

    fn parseFnSignature(value: *const json.Value) ?FnSig {
        if (typeQualifier(value)) |sig| {
            var meta: FnSig = undefined;

            var lp = mem.lastIndexOf(u8, sig, ")").?;
            if (mem.endsWith(u8, sig[lp..], ") const")) {
                meta.const_self = true;
            }
            if (mem.endsWith(u8, sig[0 .. lp + 1], "... )")) {
                meta.varidatic = true;
            }

            var s = mem.split(u8, sig, "(");
            meta.ret_type = s.first();

            return meta;
        }
        return null;
    }

    inline fn shouldSkip(self: *Transpiler, value: *const json.Value) bool {
        if (!self.transpile_includes) {
            if (value.*.object.get("loc")) |loc| {
                return loc.object.get("includedFrom") != null;
            }
        }
        return false;
    }

    // primitives
    // pointers and aliased pointers
    // fixed sized arrays
    // templated types
    // self described pointers to functions: void (*)(Object*, int)
    fn transpileType(self: *Transpiler, tname: []const u8) ![]u8 {
        var ttname = mem.trim(u8, tname, " ");

        // remove struct from C style definition
        if (mem.startsWith(u8, ttname, "struct ")) {
            ttname = ttname["struct ".len..];
        }

        const ch = ttname[ttname.len - 1];
        if (ch == '*' or ch == '&') {
            // todo: aliased pointers do not support null, right?
            // cursed c++ pointer or alised pointer
            var buf: [7]u8 = undefined;
            var template = try fmt.bufPrint(&buf, "const {c}", .{ch});
            var n: []u8 = undefined;
            if (mem.endsWith(u8, ttname, template)) {
                // const pointer of pointers
                n = try self.transpileType(ttname[0..(ttname.len - template.len)]);
            } else if (mem.startsWith(u8, ttname, "const ")) {
                // const pointer
                n = try self.transpileType(ttname[("const ".len)..(ttname.len - 1)]);
            } else {
                // mutable pointer case
                var inner_name = try self.transpileType(ttname[0..(ttname.len - 1)]);
                defer self.allocator.free(inner_name);
                return try fmt.allocPrint(self.allocator, "?*{s}", .{inner_name});
            }
            defer self.allocator.free(n);
            return try fmt.allocPrint(self.allocator, "?*const {s}", .{n});
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

        if (buffer.items.len > 0 and buffer.items[buffer.items.len - 1] == ',') {
            _ = buffer.pop();
        }
    }

    pub fn deinit(self: *Transpiler) void {
        self.nodes.deinit();
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.testing.expect(gpa.deinit() != .leak) catch @panic("memory leak");
    const allocator = gpa.allocator();

    const params = comptime clap.parseParamsComptime(
        \\-h, --help                   Display this help and exit.
        \\--std <str>                  C++ version, default c++11.
        \\--cargs <str>                Clang args.
        \\--transpile-includes         By default includes are excluded from final output, use this options to include them.
        //\\--zigify                     Aliases in the zig code style.
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
        log.info("binding `{s}`", .{input_file});

        // zig cc -x c++ -std=c++11 -Xclang -ast-dump=json {input_file}
        var args = std.ArrayList([]const u8).init(allocator);
        defer args.deinit();

        try args.append("zig");
        try args.append("cc");
        try args.append("-x");
        try args.append("c++");
        try args.append(c_ver);
        try args.append("-Xclang");
        try args.append("-ast-dump=json");
        if (res.args.cargs) |cargs| {
            try args.append(cargs);
        }
        try args.append(input_file);

        var process = try std.ChildProcess.exec(.{
            .allocator = allocator,
            .argv = args.items,
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
        transpiler.transpile_includes = res.args.@"transpile-includes" != 0;
        //transpiler.zigify = res.args.zigify != 0;
        defer transpiler.deinit();
        try transpiler.visit(&tree.root);

        var path = std.ArrayList(u8).init(allocator);
        try path.writer().print("{s}.zig", .{std.fs.path.stem(input_file)});
        defer path.deinit();

        var file = try std.fs.cwd().createFile(path.items, .{});
        defer file.close();

        try file.writeAll(buffer.items);
    }
}
