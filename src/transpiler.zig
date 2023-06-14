const std = @import("std");
const debug = std.debug;
const io = std.io;
const log = std.log;
const json = std.json;
const mem = std.mem;
const fmt = std.fmt;
const Allocator = mem.Allocator;

const Self = @This();

const FnSig = struct {
    const_self: bool = false,
    varidatic: bool = false,
    ret_type: []const u8 = "",
};

const Parent = enum {
    none,
    cxx_translation_unit_decl,
    cxx_namespace,
    cxx_record_decl,
};

const State = struct {
    parent: Parent = .none,
    parent_name: ?[]const u8 = null,
    ctors: usize = 0,
    fields: usize = 0,
    fields_out: ?std.ArrayList(u8).Writer = null,
};

const DefData = struct {
    is_polymorphic: bool,
};

allocator: Allocator,
out: std.ArrayList(u8).Writer,
visited: usize,
nodes: std.AutoHashMap(u64, json.Value),
definition_data: std.StringArrayHashMap(DefData),
state: State = .{},

// options
transpile_includes: bool = false,
zigify: bool = false,

pub fn init(buffer: *std.ArrayList(u8), allocator: Allocator) Self {
    return Self{
        .allocator = allocator,
        .out = buffer.writer(),
        .visited = 0,
        .nodes = std.AutoHashMap(u64, json.Value).init(allocator),
        .definition_data = std.StringArrayHashMap(DefData).init(allocator),
    };
}

pub fn deinit(self: *Self) void {
    self.nodes.deinit();
    self.definition_data.deinit();
}

pub fn visit(self: *Self, value: *const json.Value) anyerror!void {
    if (value.*.object.get("isImplicit")) |implicit| {
        if (implicit.bool) {
            self.visited += nodeCount(value);
            return;
        }
    }
    if (self.shouldSkip(value)) {
        self.visited += nodeCount(value);
        return;
    }

    var kind = value.*.object.get("kind").?.string;
    if (mem.eql(u8, kind, "TranslationUnitDecl")) {
        try self.visitTranslationUnitDecl(value);
    } else if (mem.eql(u8, kind, "LinkageSpecDecl")) {
        try self.visitLinkageSpecDecl(value);
    } else if (mem.eql(u8, kind, "CXXRecordDecl")) {
        try self.visitCXXRecordDecl(value);
    } else if (mem.eql(u8, kind, "EnumDecl")) {
        try self.visitEnumDecl(value);
    } else if (mem.eql(u8, kind, "TypedefDecl")) {
        try self.visitTypedefDecl(value);
    } else if (mem.eql(u8, kind, "NamespaceDecl")) {
        try self.visitNamespaceDecl(value);
    } else if (mem.eql(u8, kind, "FunctionDecl")) {
        try self.visitFunctionDecl(value);
    } else if (mem.eql(u8, kind, "ClassTemplateDecl")) {
        try self.visitClassTemplateDecl(value);
    } else if (mem.eql(u8, kind, "CompoundStmt")) {
        try self.visitCompoundStmt(value);
    } else if (mem.eql(u8, kind, "ReturnStmt")) {
        try self.visitReturnStmt(value);
    } else if (mem.eql(u8, kind, "BinaryOperator")) {
        try self.visitBinaryOperator(value);
    } else if (mem.eql(u8, kind, "ImplicitCastExpr")) {
        try self.visitImplicitCastExpr(value);
    } else if (mem.eql(u8, kind, "MemberExpr")) {
        try self.visitMemberExpr(value);
    } else if (mem.eql(u8, kind, "IntegerLiteral")) {
        try self.visitIntegerLiteral(value);
    } else if (mem.eql(u8, kind, "CStyleCastExpr")) {
        try self.visitCStyleCastExpr(value);
    } else if (mem.eql(u8, kind, "ArraySubscriptExpr")) {
        try self.visitArraySubscriptExpr(value);
    } else if (mem.eql(u8, kind, "UnaryExprOrTypeTraitExpr")) {
        try self.visitUnaryExprOrTypeTraitExpr(value);
    } else if (mem.eql(u8, kind, "DeclRefExpr")) {
        try self.visitDeclRefExpr(value);
    } else {
        log.err("unhandled `{s}`", .{kind});
    }
}

fn visitLinkageSpecDecl(self: *Self, value: *const json.Value) !void {
    self.visited += 1;

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

fn visitTranslationUnitDecl(self: *Self, value: *const json.Value) !void {
    self.visited += 1;

    if (value.object.get("inner")) |inner| {
        for (inner.array.items) |inner_item| {
            try self.visit(&inner_item);
        }
    }
}

fn visitCXXRecordDecl(self: *Self, value: *const json.Value) !void {
    // c++ class or struct
    if (self.shouldSkip(value)) {
        self.visited += nodeCount(value);
        return;
    }
    self.visited += 1;

    const tag = value.*.object.get("tagUsed").?.string;

    // nested unamed strucs or unions are treated as implicit fields
    var is_field = false;

    var free_name = false;
    var name: []const u8 = undefined;
    if (value.*.object.get("name")) |v| {
        name = v.string;
    } else if (self.state.parent == .cxx_record_decl) {
        is_field = true;
        free_name = true;
        name = try fmt.allocPrint(self.allocator, "field{d}", .{self.state.fields});
        self.state.fields += 1;
        self.out = self.state.fields_out.?;
    } else {
        // referenced by someone else
        const id = try std.fmt.parseInt(u64, value.*.object.get("id").?.string, 0);
        _ = try self.nodes.put(id, value.*);
        return;
    }
    defer if (free_name) self.allocator.free(name);

    var ov_inner = value.*.object.get("inner");
    if (ov_inner == null) {
        log.warn("opaque `{s} {s}`", .{ tag, name });
        // try self.out.print("pub const {s} = anyopaque;\n", .{name});
        return;
    }

    var is_polymorphic = false;
    if (value.*.object.get("definitionData")) |v_def_data| {
        if (v_def_data.object.get("isPolymorphic")) |v_is_polymorphic| {
            is_polymorphic = v_is_polymorphic.bool;
        }
    }

    if (is_field) {
        try self.out.print("{s}: extern {s} {{\n", .{ name, tag });
    } else {
        try self.out.print("pub const {s} = extern {s} {{\n", .{ name, tag });
    }

    const v_bases = value.*.object.get("bases");

    if (is_polymorphic and v_bases != null) {
        if (v_bases.?.array.items.len == 1) {
            const parent_type_name = typeQualifier(&v_bases.?.array.items[0]).?;
            if (self.definition_data.get(parent_type_name)) |def_data| {
                if (def_data.is_polymorphic) {
                    // when the parent is polymorphic don't add the vtable pointer in the base class
                    is_polymorphic = false;
                }
            } else {
                log.warn("base class of `{s}` might not be polymorphic", .{name});
            }
        }
    }

    if (is_polymorphic) {
        try self.out.print("    vtable: *const anyopaque,\n\n", .{});
    }

    _ = try self.definition_data.put(name, .{ .is_polymorphic = is_polymorphic });

    if (v_bases != null) {
        if (v_bases.?.array.items.len > 1) {
            log.err("multiple inheritance not supported in `{s}`", .{name});
        }
        // generate a non working code on purpose in case of many bases,
        // because the user must manually fix it
        for (v_bases.?.array.items) |v_base| {
            const parent_type = try self.transpileType(typeQualifier(&v_base).?);
            defer self.allocator.free(parent_type);
            try self.out.print("    base: {s},\n", .{parent_type});
        }
        try self.out.print("\n", .{});
    }

    var fns = std.ArrayList(u8).init(self.allocator);
    defer fns.deinit();

    var prev_state = self.state;
    self.state = .{
        .parent = .cxx_record_decl,
        .parent_name = name,
        .ctors = 0,
        .fields = 0,
        .fields_out = self.out,
    };
    defer self.state = prev_state;

    for (ov_inner.?.array.items) |inner_item| {
        if (inner_item.object.get("isImplicit")) |implicit| {
            if (implicit.bool) {
                self.visited += nodeCount(&inner_item);
                continue;
            }
        }

        const kind = inner_item.object.get("kind").?.string;
        if (mem.eql(u8, kind, "FieldDecl")) {
            self.visited += 1;

            const field_name = inner_item.object.get("name").?.string;

            if (inner_item.object.get("isInvalid")) |invalid| {
                if (invalid.bool) {
                    log.err("invalid field `{s}::{s}`", .{ name, field_name });
                    continue;
                }
            }

            const field_type = try self.transpileType(typeQualifier(&inner_item).?);
            defer self.allocator.free(field_type);
            try self.out.print("    {s}: {s},\n", .{ field_name, field_type });
        } else if (mem.eql(u8, kind, "CXXMethodDecl")) {
            const tmp = self.out;
            self.out = fns.writer();
            try self.visitCXXMethodDecl(&inner_item, name);
            self.out = tmp;
        } else if (mem.eql(u8, kind, "CXXRecordDecl")) {
            // nested stucts, classes and unions
            try self.visitCXXRecordDecl(&inner_item);
        } else if (mem.eql(u8, kind, "VarDecl")) {
            const tmp = self.out;
            self.out = fns.writer();
            try self.visitVarDecl(&inner_item);
            self.out = tmp;
        } else if (mem.eql(u8, kind, "CXXConstructorDecl")) {
            const tmp = self.out;
            self.out = fns.writer();
            try self.visitCXXConstructorDecl(&inner_item, name);
            self.out = tmp;
        } else if (mem.eql(u8, kind, "CXXDestructorDecl")) {
            const dtor_name = inner_item.object.get("mangledName").?.string;
            var w = fns.writer();
            try w.print("    extern fn {s}(self: *{s}) void;\n", .{ dtor_name, name });
            try w.print("    pub inline fn deinit(self: *{s}) void {{ self.{s}(); }}\n\n", .{ name, dtor_name });
        } else if (mem.eql(u8, kind, "AccessSpecDecl")) {
            // ignore, all fields are public in zig
        } else {
            self.visited -= 1;
            log.err("unhandled `{s}` in `{s} {s}`", .{ kind, tag, name });
        }
    }

    // delcarations must be after fields
    if (fns.items.len > 0) {
        try self.out.print("\n{s}", .{fns.items});
    }

    if (is_field) {
        try self.out.print("}},\n\n", .{});
    } else {
        try self.out.print("}};\n\n", .{});
    }
}

fn visitVarDecl(self: *Self, value: *const json.Value) !void {
    const var_name = value.*.object.get("name").?.string;
    const var_storage = value.*.object.get("storageClass").?.string;
    if (mem.eql(u8, var_storage, "static")) {
        // ok
    } else {
        log.err("unhandled storage class `{s}` in var `{s}`", .{ var_storage, var_name });
    }

    self.visited += 1;

    var var_taw_type = typeQualifier(value).?;
    var is_const = false;
    if (mem.startsWith(u8, var_taw_type, "const ")) {
        is_const = true;
        var_taw_type = var_taw_type["const ".len..];
    }

    var var_type = try self.transpileType(var_taw_type);
    defer self.allocator.free(var_type);

    const var_mangled_name = value.*.object.get("mangledName").?.string;
    if (is_const) {
        try self.out.print("extern const {s}: {s};\n", .{ var_mangled_name, var_type });
        try self.out.print("pub inline fn {s}() {s} {{\n    return {s};\n}}\n\n", .{ var_name, var_type, var_mangled_name });
    } else {
        try self.out.print("extern var {s}: {s};\n", .{ var_mangled_name, var_type });
        try self.out.print("pub inline fn {s}() *{s} {{\n    return &{s};\n}}\n\n", .{ var_name, var_type, var_mangled_name });
    }
}

fn visitCXXConstructorDecl(self: *Self, value: *const json.Value, parent: []const u8) !void {
    self.visited += 1;

    const sig = parseFnSignature(value).?;

    if (value.*.object.get("isInvalid")) |invalid| {
        if (invalid.bool) {
            self.visited -= 1;
            log.err("invalid ctor `{s}`", .{parent});
            return;
        }
    }

    // todo: copy code from visitCXXMethodDecl

    // note: if the function has a `= 0` at the end it will have "pure" = true attribute

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

    const method_mangled_name = value.*.object.get("mangledName").?.string;

    try self.out.print("extern fn {s}(", .{method_mangled_name});

    if (sig.const_self) {
        try self.out.print("self: *const {s}", .{parent});
    } else {
        try self.out.print("self: *{s}", .{parent});
    }

    var comma = false;
    var init_args = std.ArrayList(u8).init(self.allocator);
    defer init_args.deinit();
    var forward_init_args = std.ArrayList(u8).init(self.allocator);
    defer forward_init_args.deinit();

    // method args
    if (value.*.object.get("inner")) |v_inner| {
        for (v_inner.array.items, 0..) |v_item, i| {
            self.visited += 1;

            const arg_kind = v_item.object.get("kind").?.string;
            if (mem.eql(u8, arg_kind, "ParmVarDecl")) {
                const v_type = v_item.object.get("type").?;
                var v_qual = v_type.object.get("qualType").?.string;

                // va_list is in practice a `char*`, but we can double check this by verifing the desugared type
                if (mem.eql(u8, v_qual, "va_list")) {
                    if (v_type.object.get("desugaredQualType")) |v_desurgared| {
                        v_qual = v_desurgared.string;
                    }
                }

                var arg_type = try self.transpileType(v_qual);
                defer self.allocator.free(arg_type);

                var free_arg_name = false;
                var arg_name: []const u8 = undefined;
                if (v_item.object.get("name")) |v_item_name| {
                    arg_name = v_item_name.string;
                } else {
                    free_arg_name = true;
                    arg_name = try fmt.allocPrint(self.allocator, "arg{d}", .{i});
                }
                defer if (free_arg_name) self.allocator.free(arg_name);

                if (comma) try init_args.writer().print(", ", .{});
                comma = true;
                try init_args.writer().print("{s}: {s}", .{ arg_name, arg_type });
                try forward_init_args.writer().print(", {s}", .{arg_name});

                try self.out.print(", {s}: {s}", .{ arg_name, arg_type });
            } else if (mem.eql(u8, arg_kind, "FormatAttr")) {
                // varidatic function with the same properties as printf
            } else {
                self.visited -= 1;
                log.err("unhandled `{s}` in ctor `{s}`", .{ arg_kind, parent });
            }
        }
    }

    if (sig.varidatic) {
        try self.out.print(", ...) callconv(.C) void;\n", .{});
    } else {
        try self.out.print(") void;\n", .{});
    }

    // sig
    try self.out.print("pub inline fn init", .{});
    if (self.state.ctors != 0) try self.out.print("{d}", .{self.state.ctors}); // avoid name conflict
    try self.out.print("({s}) {s} {{\n", .{ init_args.items, parent });
    // body
    try self.out.print("    var self: {s} = undefined;\n", .{parent});
    try self.out.print("    {s}(&self{s});", .{ method_mangled_name, forward_init_args.items });
    try self.out.print("    return self;\n", .{});
    try self.out.print("}}\n\n", .{});

    self.state.ctors += 1;
}

fn visitCXXMethodDecl(self: *Self, value: *const json.Value, parent: ?[]const u8) !void {
    self.visited += 1;

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
                    method_name = "getPointer";
                } else {
                    // value = class[i];
                    method_name = "getValue";
                }
                // } else if (mem.eql(u8, op, " new")) {
                // } else if (mem.eql(u8, op, " delete")) {
            } else {
                self.visited -= 1;
                log.err("unhandled operator `{s}` in `{?s}`", .{ op[1..], parent });
                return;
            }
        }
    }

    if (value.*.object.get("isInvalid")) |invalid| {
        if (invalid.bool) {
            self.visited -= 1;
            log.err("invalid method `{?s}::{s}`", .{ parent, method_name });
            return;
        }
    }

    // note: if the function has a `= 0` at the end it will have "pure" = true attribute

    const method_tret = try self.transpileType(sig.ret_type);
    defer self.allocator.free(method_tret);

    var is_mangled: bool = undefined;
    var method_mangled_name: []const u8 = undefined;
    // template function doent have the `mangledName` field
    if (value.*.object.get("mangledName")) |v_mangled_name| {
        method_mangled_name = v_mangled_name.string;
        // functions decorated with `extern "C"` won't be mangled
        is_mangled = !mem.eql(u8, method_mangled_name, method_name);
    } else {
        method_mangled_name = method_name;
        is_mangled = false;
    }

    const v_inner = value.*.object.get("inner");
    var has_body = false;
    if (v_inner != null and v_inner.?.array.items.len > 0) {
        const item_kind = v_inner.?.array.items[v_inner.?.array.items.len - 1].object.get("kind").?.string;
        has_body = mem.eql(u8, item_kind, "CompoundStmt");
    }

    if (has_body) {
        try self.out.print("pub ", .{});
        if (value.*.object.get("inline")) |v_inline| {
            if (v_inline.bool) try self.out.print("inline ", .{});
        }
        try self.out.print("fn {s}(", .{method_name});
    } else {
        if (!is_mangled) try self.out.print("pub ", .{});
        try self.out.print("extern fn {s}(", .{method_mangled_name});
    }

    var comma = false;

    if (parent) |name| {
        comma = true;
        if (sig.const_self) {
            try self.out.print("self: *const {s}", .{name});
        } else {
            try self.out.print("self: *{s}", .{name});
        }
    }

    var body = std.ArrayList(u8).init(self.allocator);
    defer body.deinit();

    // method args

    for (v_inner.?.array.items) |v_item| {
        const arg_kind = v_item.object.get("kind").?.string;
        if (mem.eql(u8, arg_kind, "ParmVarDecl")) {
            self.visited += 1;

            const v_type = v_item.object.get("type").?;
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
            if (v_item.object.get("name")) |v_item_name| {
                arg_name = v_item_name.string;
            }

            if (comma) {
                try self.out.print(", ", .{});
            }
            comma = true;

            try self.out.print("{s}: {s}", .{ arg_name, arg_type });
        } else if (mem.eql(u8, arg_kind, "FormatAttr")) {
            // varidatic function with the same properties as printf
            self.visited += 1;
        } else if (mem.eql(u8, arg_kind, "CompoundStmt")) {
            const tmp = self.out;
            self.out = body.writer();
            try self.visitCompoundStmt(&v_item);
            self.out = tmp;
        } else {
            log.err("unhandled `{s}` in function `{?s}::{s}`", .{ arg_kind, parent, method_name });
            continue;
        }
    }

    if (sig.varidatic) {
        if (comma) {
            try self.out.print(", ", .{});
        }
        try self.out.print("...) callconv(.C) {s}", .{method_tret});
    } else {
        try self.out.print(") {s}", .{method_tret});
    }

    // body must be after fields
    if (has_body) {
        try self.out.print(" {s}\n", .{body.items});
    } else {
        try self.out.print(";\n", .{});
    }

    if (is_mangled) {
        try self.out.print("pub const {s} = {s};\n\n", .{ method_name, method_mangled_name });
    }
}

fn visitEnumDecl(self: *Self, value: *const json.Value) !void {
    if (self.shouldSkip(value)) {
        self.visited += nodeCount(value);
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

    self.visited += 1;

    // todo: use "fixedUnderlyingType" or figure out the type by himself
    try self.out.print("pub const {s} = enum(c_int) {{\n", .{name});

    for (inner.?.array.items) |inner_item| {
        if (inner_item.object.get("isImplicit")) |is_implicit| {
            if (is_implicit.bool) {
                self.visited += nodeCount(&inner_item);
                continue;
            }
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
            continue;
        }

        self.visited += 1;
    }

    try self.out.print("}};\n\n", .{});
}

fn visitTypedefDecl(self: *Self, value: *const json.Value) !void {
    if (self.shouldSkip(value)) {
        self.visited += nodeCount(value);
        return;
    }
    self.visited += 1;

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
            self.visited += nodeCount(v_item);
        } else if (mem.eql(u8, tag, "ElaboratedType")) {
            // c style simplified struct definition
            if (v_item.*.object.get("ownedTagDecl")) |v_owned| {
                const id_name = v_owned.object.get("id").?.string;
                const id = try std.fmt.parseInt(u64, id_name, 0);
                if (self.nodes.get(id)) |node| {
                    const n_tag = node.object.get("kind").?.string;
                    if (mem.eql(u8, n_tag, "CXXRecordDecl")) {
                        self.visited += 1;
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
                    self.visited += nodeCount(v_item);
                    log.warn("missing node `{s}` of `ElaboratedType` in typedef `{s}`", .{ id_name, name });
                }
                return;
            } else {
                // other kind of type alias
                // todo: use the inner "RecordType"
                self.visited += nodeCount(v_item);
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

fn visitNamespaceDecl(self: *Self, value: *const json.Value) !void {
    if (self.shouldSkip(value)) {
        self.visited += nodeCount(value);
        return;
    }
    self.visited += 1;

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

inline fn visitFunctionDecl(self: *Self, value: *const json.Value) !void {
    // a function is a method without a parent struct
    return self.visitCXXMethodDecl(value, null);
}

fn visitClassTemplateDecl(self: *Self, value: *const json.Value) !void {
    if (self.shouldSkip(value)) {
        self.visited += nodeCount(value);
        return;
    }
    self.visited += 1;

    var name: []const u8 = undefined;
    if (value.*.object.get("name")) |v| {
        name = v.string;
    } else {
        self.visited -= 1;
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

    var fns = std.ArrayList(u8).init(self.allocator);
    defer fns.deinit();

    var prev_state = self.state;
    self.state = .{
        .parent = .cxx_record_decl,
        .parent_name = "Self",
        .ctors = 0,
        .fields = 0,
        .fields_out = self.out,
    };
    defer self.state = prev_state;

    // template param
    var tp_comma = false;
    for (inner.?.array.items) |item| {
        self.visited += 1;

        const item_kind = item.object.get("kind").?.string;
        if (mem.eql(u8, item_kind, "TemplateTypeParmDecl")) {
            var v_item_name = item.object.get("name");
            if (v_item_name == null) {
                self.visited -= 1;
                log.err("unnamed template param in `{s}`", .{name});
                continue;
            }

            var v_item_tag = item.object.get("tagUsed");
            if (v_item_tag == null) {
                self.visited -= 1;
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
                self.visited -= 1;
                log.err("unknown template param `{s} {s}` in `{s}`", .{ item_tag, item_name, name });
            }
        } else if (mem.eql(u8, item_kind, "CXXRecordDecl")) {
            // template definition
            try self.out.print(") type {{\n    return extern struct {{\n", .{});
            try self.out.print("        const Self = @This();\n\n", .{});

            var inner_inner = item.object.get("inner");
            if (inner_inner == null) {
                log.warn("blank `{s}` template", .{name});
                return;
            }

            for (inner_inner.?.array.items) |inner_item| {
                self.visited += 1;

                const inner_item_kind = inner_item.object.get("kind").?.string;
                if (mem.eql(u8, inner_item_kind, "CXXRecordDecl")) {
                    // class or struct
                } else if (mem.eql(u8, inner_item_kind, "FieldDecl")) {
                    const field_name = inner_item.object.get("name").?.string;
                    var field_type = try self.transpileType(typeQualifier(&inner_item).?);
                    defer self.allocator.free(field_type);
                    try self.out.print("        {s}: {s},\n", .{ field_name, field_type });
                } else if (mem.eql(u8, inner_item_kind, "CXXMethodDecl")) {
                    const tmp = self.out;
                    self.out = fns.writer();
                    try self.visitCXXMethodDecl(&inner_item, "Self");
                    self.out = tmp;
                } else {
                    self.visited -= 1;
                    log.err("unhandled `{s}` in template `{s}`", .{ inner_item_kind, name });
                }
            }

            // delcarations must be after fields
            if (fns.items.len > 0) {
                try self.out.print("\n{s}", .{fns.items});
            }

            try self.out.print("    }};\n}}\n\n", .{});

            return;
        } else {
            log.err("unhandled `{s}` in template `{s}`", .{ item_kind, name });
        }
    }
}

fn visitCompoundStmt(self: *Self, value: *const json.Value) !void {
    self.visited += 1;

    var inner = value.*.object.get("inner");
    if (inner == null) {
        return;
    }

    try self.out.print("{{\n", .{});

    for (inner.?.array.items) |inner_item| {
        try self.visit(&inner_item);
    }

    try self.out.print("}}", .{});
}

fn visitReturnStmt(self: *Self, value: *const json.Value) !void {
    const v_inner = value.*.object.get("inner");
    if (v_inner == null or v_inner.?.array.items.len == 0) {
        try self.out.print("return;", .{});
        return;
    } else if (v_inner.?.array.items.len > 1) {
        log.err("multiple inner nodes in `ReturnStmt`", .{});
    }

    self.visited += 1;

    _ = try self.out.write("return ");
    try self.visit(&v_inner.?.array.items[0]);
    _ = try self.out.write(";\n");
}

fn visitBinaryOperator(self: *Self, value: *const json.Value) !void {
    const v_opcode = value.*.object.get("opcode");
    if (v_opcode == null) {
        log.err("no opcode in `BinaryOperator`", .{});
        return;
    }

    const v_inner = value.*.object.get("inner");
    if (v_inner == null or v_inner.?.array.items.len != 2) {
        log.err("worng number of operands in `BinaryOperator`", .{});
        return;
    }

    self.visited += 1;

    try self.out.print("(", .{});
    try self.visit(&v_inner.?.array.items[0]);
    try self.out.print(" {s} ", .{v_opcode.?.string});
    try self.visit(&v_inner.?.array.items[1]);
    try self.out.print(")", .{});
}

inline fn visitImplicitCastExpr(self: *Self, value: *const json.Value) !void {
    return self.visitCStyleCastExpr(value);
}

fn visitMemberExpr(self: *Self, value: *const json.Value) !void {
    self.visited += 1;
    const name = value.*.object.get("name").?.string;
    try self.out.print("self.{s}", .{name});
}

fn visitIntegerLiteral(self: *Self, value: *const json.Value) !void {
    const literal = value.*.object.get("value").?.string;
    _ = try self.out.write(literal);
    self.visited += 1;
}

fn visitCStyleCastExpr(self: *Self, value: *const json.Value) !void {
    const cast_type = try self.transpileType(typeQualifier(value).?);
    defer self.allocator.free(cast_type);

    try self.out.print("@as({s}, ", .{cast_type});
    try self.visit(&value.*.object.get("inner").?.array.items[0]);
    try self.out.print(")", .{});

    self.visited += 1;
}

fn visitArraySubscriptExpr(self: *Self, value: *const json.Value) !void {
    self.visited += 1;
    var v_inner = value.*.object.get("inner");
    try self.visit(&v_inner.?.array.items[0]);
    try self.out.print("[", .{});
    try self.visit(&v_inner.?.array.items[1]);
    try self.out.print("]", .{});
}

fn visitUnaryExprOrTypeTraitExpr(self: *Self, value: *const json.Value) !void {
    const name = value.*.object.get("name").?.string;
    if (mem.eql(u8, name, "sizeof")) {
        const size_of = try self.transpileType(value.*.object.get("argType").?.object.get("qualType").?.string);
        defer self.allocator.free(size_of);
        try self.out.print("@sizeOf({s})", .{size_of});
    } else {
        log.err("unknonw `UnaryExprOrTypeTraitExpr` `{s}`", .{name});
        return;
    }

    self.visited += 1;
}

fn visitDeclRefExpr(self: *Self, value: *const json.Value) !void {
    const v_ref = value.*.object.get("referencedDecl").?;
    const kind = v_ref.object.get("kind").?.string;
    if (mem.eql(u8, kind, "ParmVarDecl")) {
        const name = v_ref.object.get("name").?.string;
        _ = try self.out.write(name);
    } else {
        log.err("unhandled `{s}` in `DeclRefExpr`", .{kind});
        return;
    }

    self.visited += 1;
}

///////////////////////////////////////////////////////////////////////////////

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

inline fn shouldSkip(self: *Self, value: *const json.Value) bool {
    // todo: incorporate this?
    // if (value.*.object.get("isImplicit")) |implicit| {
    //     if (implicit.bool) {
    //         return true;
    //     }
    // }
    if (!self.transpile_includes) {
        if (value.*.object.get("loc")) |loc| {
            return loc.object.get("includedFrom") != null;
        }
    }
    return false;
}

pub fn nodeCount(value: *const json.Value) usize {
    var count: usize = 1;
    if (value.object.get("inner")) |inner| {
        for (inner.array.items) |v_item| {
            count += nodeCount(&v_item);
        }
    }
    return count;
}

// primitives
// pointers and aliased pointers
// fixed sized arrays
// templated types
// self described pointers to functions: void (*)(Object*, int)
fn transpileType(self: *Self, tname: []const u8) ![]u8 {
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
            return try fmt.allocPrint(self.allocator, "[*c]{s}", .{inner_name});
        }
        defer self.allocator.free(n);
        return try fmt.allocPrint(self.allocator, "[*c]const {s}", .{n});
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

            return try fmt.allocPrint(self.allocator, "[*c]const fn({s}) {s}", .{ targs.items, tret });
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
fn transpileTypeArgs(self: *Self, tname: []const u8, buffer: *std.ArrayList(u8), index: *usize) anyerror!void {
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
