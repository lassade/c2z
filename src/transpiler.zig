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

const PrimitivesTypeLUT = std.ComptimeStringMap([]const u8, .{
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
    // custom types
    .{ "std::vector", "cpp.Vector" },
    .{ "std::array", "cpp.Array" }, // todo: std::array<T, N> -> [N]T
});

const ScopeTag = enum {
    root,
    class,
    local,
};
const Scope = struct {
    tag: ScopeTag,
    name: ?[]const u8,
    /// Constructors indexing
    ctors: usize = 0,
    /// Generate unnamed nodes
    fields: usize = 0,
};

const NamespaceScope = struct {
    // todo: full_path: std.ArrayList(u8),
    unnamed_nodes: std.AutoHashMap(u64, json.Value),
    // todo: didn't find a hashset, maybe by using the key as `void` no extra allocations will be made?
    opaques: std.StringArrayHashMap(void),
    // todo: overloads: std.StringArrayHashMap(usize),

    fn init(allocator: Allocator) NamespaceScope {
        return .{
            .unnamed_nodes = std.AutoHashMap(u64, json.Value).init(allocator),
            .opaques = std.StringArrayHashMap(void).init(allocator),
            // todo: .overloads = std.StringArrayHashMap(usize).init(allocator),
        };
    }

    fn deinit(self: *NamespaceScope) void {
        self.unnamed_nodes.deinit();
        self.opaques.deinit();
        // todo: self.overloads.deinit();
    }
};

const ClassInfo = struct {
    is_polymorphic: bool,
};

allocator: Allocator,

buffer: std.ArrayList(u8),
out: std.ArrayList(u8).Writer,

nodes_visited: usize,
nodes_count: usize,

namespace: NamespaceScope,
scope: Scope,
semicolon: bool = true,
public: bool = true,

class_info: std.StringArrayHashMap(ClassInfo),

// options
transpile_includes: bool,
zigify: bool,

pub fn init(allocator: Allocator) Self {
    return Self{
        .allocator = allocator,
        .buffer = std.ArrayList(u8).init(allocator),
        // can't be initialized because Self will be moved
        .out = undefined,
        .nodes_visited = 0,
        .nodes_count = 0,
        .namespace = NamespaceScope.init(allocator),
        .scope = .{ .tag = .root, .name = null },
        .class_info = std.StringArrayHashMap(ClassInfo).init(allocator),
        .transpile_includes = false,
        .zigify = false,
    };
}

pub fn deinit(self: *Self) void {
    self.buffer.deinit();
    self.namespace.deinit();
    self.class_info.deinit();
}

pub fn run(self: *Self, value: *const json.Value) anyerror!void {
    // todo: clear state
    self.buffer.clearRetainingCapacity();
    self.nodes_count = nodeCount(value);

    self.out = self.buffer.writer();

    _ = try self.out.write("const std = @import(\"std\");\n\n");

    try self.visit(value);
}

fn beginNamespace(self: *Self) NamespaceScope {
    const parent = self.namespace;
    self.namespace = NamespaceScope.init(self.allocator);
    return parent;
}

fn endNamespace(self: *Self, parent: NamespaceScope) !void {
    if (self.namespace.opaques.keys().len > 0) {
        try self.out.print("\n\n// opaques\n\n", .{});
        for (self.namespace.opaques.keys()) |name| {
            log.warn("defining `{s}` as an opaque type", .{name});
            try self.out.print("const {s} = anyopaque;\n", .{name});

            // todo: replace `[*c]{name}` for ` ?* {name}`
            // todo: replace `[*c]const {name}` to ` ?* const {name}`
        }
    }

    if (self.namespace.unnamed_nodes.count() > 0) {
        try self.out.print("\n\n// unnamed nodes\n\n", .{});
        var unnamed: usize = 0;
        var nodes_it = self.namespace.unnamed_nodes.iterator();
        while (nodes_it.next()) |entry| {
            // todo: sometimes these enums are inside a namespace or a struct, so they should be defined at the end of these but still inside
            const kind = entry.value_ptr.object.get("kind").?.string;
            if (mem.eql(u8, kind, "EnumDecl")) {
                const name = try fmt.allocPrint(self.allocator, "UnnamedEnum{d}", .{unnamed});
                defer self.allocator.free(name);
                _ = try entry.value_ptr.object.put("name", json.Value{ .string = name });
                try self.visitEnumDecl(entry.value_ptr);
            } else {
                log.warn("unused unnamed node `{s}`", .{kind});
                continue;
            }

            unnamed += 1;
        }
    }

    self.namespace.deinit();
    self.namespace = parent;
}

fn visit(self: *Self, value: *const json.Value) anyerror!void {
    // ignore empty nodes
    if (value.object.count() == 0) return;

    if (value.object.getPtr("isImplicit")) |implicit| {
        if (implicit.bool) {
            self.nodes_visited += nodeCount(value);
            return;
        }
    }
    if (self.shouldSkip(value)) {
        self.nodes_visited += nodeCount(value);
        return;
    }

    var kind = value.object.getPtr("kind").?.string;
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
    } else if (mem.eql(u8, kind, "ParenExpr")) {
        try self.visitParenExpr(value);
    } else if (mem.eql(u8, kind, "UnaryOperator")) {
        try self.visitUnaryOperator(value);
    } else if (mem.eql(u8, kind, "CXXThisExpr")) {
        try self.visitCXXThisExpr(value);
    } else if (mem.eql(u8, kind, "ConstantExpr")) {
        try self.visitConstantExpr(value);
    } else if (mem.eql(u8, kind, "VarDecl")) {
        try self.visitVarDecl(value);
    } else if (mem.eql(u8, kind, "IfStmt")) {
        try self.visitIfStmt(value);
    } else if (mem.eql(u8, kind, "ForStmt")) {
        try self.visitForStmt(value);
    } else if (mem.eql(u8, kind, "WhileStmt")) {
        try self.visitWhileStmt(value);
    } else if (mem.eql(u8, kind, "CXXBoolLiteralExpr")) {
        try self.visitCXXBoolLiteralExpr(value);
    } else if (mem.eql(u8, kind, "DeclStmt")) {
        try self.visitDeclStmt(value);
    } else if (mem.eql(u8, kind, "CallExpr")) {
        try self.visitCallExpr(value);
    } else if (mem.eql(u8, kind, "CXXMemberCallExpr")) {
        try self.visitCXXMemberCallExpr(value);
    } else if (mem.eql(u8, kind, "CXXNullPtrLiteralExpr")) {
        try self.visitCXXNullPtrLiteralExpr(value);
    } else if (mem.eql(u8, kind, "FunctionTemplateDecl")) {
        try self.visitFunctionTemplateDecl(value);
    } else if (mem.eql(u8, kind, "CXXPseudoDestructorExpr")) {
        try self.visitCXXPseudoDestructorExpr(value);
    } else if (mem.eql(u8, kind, "CompoundAssignOperator")) {
        try self.visitCompoundAssignOperator(value);
    } else if (mem.eql(u8, kind, "CXXOperatorCallExpr")) {
        try self.visitCXXOperatorCallExpr(value);
    } else if (mem.eql(u8, kind, "UnresolvedMemberExpr")) {
        try self.visitUnresolvedMemberExpr(value);
    } else if (mem.eql(u8, kind, "CXXDependentScopeMemberExpr")) {
        try self.visitCXXDependentScopeMemberExpr(value);
    } else if (mem.eql(u8, kind, "ConditionalOperator")) {
        try self.visitConditionalOperator(value);
    } else if (mem.eql(u8, kind, "BreakStmt")) {
        try self.visitBreakStmt(value);
    } else if (mem.eql(u8, kind, "StringLiteral")) {
        try self.visitStringLiteral(value);
    } else {
        log.err("unhandled `{s}`", .{kind});
    }
}

fn visitLinkageSpecDecl(self: *Self, value: *const json.Value) !void {
    self.nodes_visited += 1;

    if (value.object.get("language")) |v_lang| {
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
    self.nodes_visited += 1;

    if (value.object.get("inner")) |inner| {
        for (inner.array.items) |inner_item| {
            try self.visit(&inner_item);
        }
    }
}

fn visitCXXRecordDecl(self: *Self, value: *const json.Value) !void {
    // c++ class or struct
    if (self.shouldSkip(value)) {
        self.nodes_visited += nodeCount(value);
        return;
    }
    self.nodes_visited += 1;

    const tag = value.object.get("tagUsed").?.string;

    // nested unamed strucs or unions are treated as implicit fields
    var is_field = false;

    var is_generated_name = false;
    var name: []const u8 = undefined;
    if (value.object.get("name")) |v| {
        name = v.string;
    } else if (self.scope.tag == .class) {
        // unamed struct, class or union inside a class definition should be treated as a field
        is_field = true;
        is_generated_name = true;
        name = try fmt.allocPrint(self.allocator, "field{d}", .{self.scope.fields});
        self.scope.fields += 1;
    } else {
        // referenced by someone else
        const id = try std.fmt.parseInt(u64, value.object.get("id").?.string, 0);
        _ = try self.namespace.unnamed_nodes.put(id, value.*);
        return;
    }
    defer if (is_generated_name) self.allocator.free(name);

    var ov_inner = value.object.get("inner");
    if (ov_inner == null) {
        // e.g. `struct ImDrawChannel;`
        try self.namespace.opaques.put(name, undefined);
        return;
    }

    if (!is_generated_name) {
        _ = self.namespace.opaques.swapRemove(name);
    }

    var is_polymorphic = false;
    if (value.object.get("definitionData")) |v_def_data| {
        if (v_def_data.object.get("isPolymorphic")) |v_is_polymorphic| {
            is_polymorphic = v_is_polymorphic.bool;
        }
    }

    const public = self.public;
    defer self.public = public;

    if (mem.eql(u8, tag, "class")) {
        self.public = false;
    }

    if (is_field) {
        try self.out.print("{s}: extern {s} {{\n", .{ name, tag });
    } else {
        try self.out.print("pub const {s} = extern struct {{\n", .{name});
    }

    const v_bases = value.object.get("bases");

    if (is_polymorphic and v_bases != null) {
        if (v_bases.?.array.items.len == 1) {
            const parent_type_name = typeQualifier(&v_bases.?.array.items[0]).?;
            if (self.class_info.get(parent_type_name)) |def_data| {
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

    _ = try self.class_info.put(name, .{ .is_polymorphic = is_polymorphic });

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

    var functions = std.ArrayList(u8).init(self.allocator);
    defer functions.deinit();

    const parent_state = self.scope;
    self.scope = .{ .tag = .class, .name = name };
    defer self.scope = parent_state;

    const parent_namespace = self.beginNamespace();

    for (ov_inner.?.array.items) |inner_item| {
        if (inner_item.object.get("isImplicit")) |implicit| {
            if (implicit.bool) {
                self.nodes_visited += nodeCount(&inner_item);
                continue;
            }
        }

        const kind = inner_item.object.get("kind").?.string;
        if (mem.eql(u8, kind, "FieldDecl")) {
            self.nodes_visited += 1;

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
            self.out = functions.writer();
            try self.visitCXXMethodDecl(&inner_item, name);
            self.out = tmp;
        } else if (mem.eql(u8, kind, "CXXRecordDecl")) {
            // nested stucts, classes and unions
            try self.visitCXXRecordDecl(&inner_item);
        } else if (mem.eql(u8, kind, "VarDecl")) {
            const tmp = self.out;
            self.out = functions.writer();
            try self.visitVarDecl(&inner_item);
            self.out = tmp;
        } else if (mem.eql(u8, kind, "CXXConstructorDecl")) {
            const tmp = self.out;
            self.out = functions.writer();
            try self.visitCXXConstructorDecl(&inner_item, name);
            self.out = tmp;
        } else if (mem.eql(u8, kind, "CXXDestructorDecl")) {
            const dtor = inner_item.object.get("mangledName").?.string;
            var w = functions.writer();
            try w.print("    extern fn {s}(self: *{s}) void;\n", .{ dtor, name });
            try w.print("    pub inline fn deinit(self: *{s}) void {{ self.{s}(); }}\n\n", .{ name, dtor });
        } else if (mem.eql(u8, kind, "AccessSpecDecl")) {
            const access = inner_item.object.get("access").?.string;
            self.public = mem.eql(u8, access, "public");
        } else {
            self.nodes_visited -= 1;
            log.err("unhandled `{s}` in `{s} {s}`", .{ kind, tag, name });
        }
    }

    // delcarations must be after fields
    if (functions.items.len > 0) {
        try self.out.print("\n{s}", .{functions.items});
    }

    try self.endNamespace(parent_namespace);

    if (is_field) {
        try self.out.print("}},\n\n", .{});
    } else {
        try self.out.print("}};\n\n", .{});
    }
}

fn visitVarDecl(self: *Self, value: *const json.Value) !void {
    const name = value.object.getPtr("name").?.string;

    var constant = false;
    var raw_ty = typeQualifier(value).?;
    if (mem.startsWith(u8, raw_ty, "const ")) {
        constant = true;
        raw_ty = raw_ty["const ".len..];
    }

    var ty = try self.transpileType(raw_ty);
    defer self.allocator.free(ty);

    if (self.scope.tag == .local) {
        // variable
        _ = try self.out.write(if (constant) "const" else "var");
        try self.out.print(" {s}: {s}", .{ name, ty });
        if (value.object.getPtr("inner")) |j_inner| {
            // declaration statement like `int a;`
            try self.out.print(" = ", .{});
            try self.visit(&j_inner.array.items[0]);
        }

        self.nodes_visited += 1;
        return;
    }

    self.nodes_visited += nodeCount(value);

    const mangled_name = value.object.getPtr("mangledName").?.string;
    if (constant) {
        try self.out.print("extern const {s}: {s};\n", .{ mangled_name, ty });
        try self.out.print("pub inline fn {s}() {s} {{\n    return {s};\n}}\n\n", .{ name, ty, mangled_name });
    } else {
        try self.out.print("extern var {s}: {s};\n", .{ mangled_name, ty });
        try self.out.print("pub inline fn {s}() *{s} {{\n    return &{s};\n}}\n\n", .{ name, ty, mangled_name });
    }
}

fn visitCXXConstructorDecl(self: *Self, value: *const json.Value, parent: []const u8) !void {
    if (value.object.get("isInvalid")) |invalid| {
        if (invalid.bool) {
            log.err("invalid ctor of `{s}`", .{parent});
            return;
        }
    }

    if (value.object.get("constexpr")) |constexpr| {
        if (constexpr.bool) {
            log.err("unhandled constexpr ctor of `{s}`", .{parent});
            return;
        }
    }

    const sig = parseFnSignature(value).?;

    self.nodes_visited += 1;

    // todo: copy code from visitCXXMethodDecl

    // note: if the function has a `= 0` at the end it will have "pure" = true attribute

    // todo: deal with inlined methods
    // var inlined = false;
    // if (value.object.get("inline")) |v_inline| {
    //     inlined = v_inline.bool;
    //     if (inlined) {
    //         //
    //         log.err("unhandled inlined method `{?s}::{s}`", .{ parent, method_name });
    //         return;
    //     }
    // }

    const method_mangled_name = value.object.get("mangledName").?.string;

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
    if (value.object.get("inner")) |v_inner| {
        for (v_inner.array.items, 0..) |v_item, i| {
            self.nodes_visited += 1;

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
                self.nodes_visited -= 1;
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
    if (self.scope.ctors != 0) try self.out.print("{d}", .{self.scope.ctors}); // avoid name conflict
    try self.out.print("({s}) {s} {{\n", .{ init_args.items, parent });
    // body
    try self.out.print("    var self: {s} = undefined;\n", .{parent});
    try self.out.print("    {s}(&self{s});", .{ method_mangled_name, forward_init_args.items });
    try self.out.print("    return self;\n", .{});
    try self.out.print("}}\n\n", .{});

    self.scope.ctors += 1;
}

fn visitCXXMethodDecl(self: *Self, value: *const json.Value, parent: ?[]const u8) !void {
    const sig = parseFnSignature(value).?;

    var method_name = value.object.get("name").?.string;
    if (mem.startsWith(u8, method_name, "operator")) {
        var op = method_name["operator".len..];
        if (op.len > 0 and std.ascii.isAlphanumeric(op[0])) {
            // just a function starting with operator
        } else {
            // todo: implicit casting
            if (mem.eql(u8, op, "[]")) {
                if (!sig.const_self and mem.endsWith(u8, sig.ret_type, "&")) {
                    // class[i] = value;
                    method_name = "getPtr";
                } else {
                    // value = class[i];
                    method_name = "get";
                }
            } else if (mem.eql(u8, op, "=")) {
                // assign
                method_name = "copyFrom";
            }
            // } else if (mem.eql(u8, op, " new")) {
            // } else if (mem.eql(u8, op, " delete")) {
            else {
                log.err("unhandled operator `{s}` in `{?s}`", .{ op, parent });
                return;
            }
        }
    }

    if (value.object.get("isInvalid")) |invalid| {
        if (invalid.bool) {
            log.err("invalid method `{?s}::{s}`", .{ parent, method_name });
            return;
        }
    }

    if (value.object.get("constexpr")) |constexpr| {
        if (constexpr.bool) {
            log.err("unhandled constexpr method `{?s}::{s}`", .{ parent, method_name });
            return;
        }
    }

    self.nodes_visited += 1;

    // note: if the function has a `= 0` at the end it will have "pure" = true attribute

    const method_tret = try self.transpileType(sig.ret_type);
    defer self.allocator.free(method_tret);

    var is_mangled: bool = undefined;
    var method_mangled_name: []const u8 = undefined;
    // template function doent have the `mangledName` field
    if (value.object.get("mangledName")) |v_mangled_name| {
        method_mangled_name = v_mangled_name.string;
        // functions decorated with `extern "C"` won't be mangled
        is_mangled = !mem.eql(u8, method_mangled_name, method_name);
    } else {
        method_mangled_name = method_name;
        is_mangled = false;
    }

    const v_inner = value.object.get("inner");
    var has_body = false;
    if (v_inner != null and v_inner.?.array.items.len > 0) {
        const item_kind = v_inner.?.array.items[v_inner.?.array.items.len - 1].object.get("kind").?.string;
        has_body = mem.eql(u8, item_kind, "CompoundStmt");
    }

    if (has_body) {
        try self.out.print("pub ", .{});
        if (value.object.get("inline")) |v_inline| {
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

    if (v_inner != null) {
        for (v_inner.?.array.items) |v_item| {
            const arg_kind = v_item.object.get("kind").?.string;
            if (mem.eql(u8, arg_kind, "ParmVarDecl")) {
                self.nodes_visited += 1;

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
                self.nodes_visited += 1;
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
        try self.out.print(" {s}\n\n", .{body.items});
    } else {
        try self.out.print(";\n", .{});
        if (is_mangled) {
            try self.out.print("pub const {s} = {s};\n\n", .{ method_name, method_mangled_name });
        }
    }
}

fn visitFunctionTemplateDecl(self: *Self, node: *const json.Value) !void {
    self.nodes_visited += 1;

    // gather comptime parameters ...
    var cp = std.ArrayList(u8).init(self.allocator);
    defer cp.deinit();

    var comma = false;
    const name = node.object.getPtr("name").?.string;
    for (node.object.getPtr("inner").?.array.items) |*item| {
        const kind = item.object.getPtr("kind").?.string;
        if (mem.eql(u8, kind, "TemplateTypeParmDecl")) {
            if (comma) try self.out.print(", ", .{});
            comma = true;

            const out = self.out;
            self.out = cp.writer();
            try self.visitTemplateTypeParmDecl(item, name);
            self.out = out;
        } else if (mem.eql(u8, kind, "FunctionDecl")) {
            self.nodes_visited += 1;

            const f_inner = item.object.get("inner");
            if (f_inner == null) {
                log.err("`FunctionTemplateDecl` `{s}` with empty inner body", .{name});
                return;
            }

            const f_items = f_inner.?.array.items;

            if (f_items.len > 0) {
                if (!mem.eql(u8, f_items[f_items.len - 1].object.getPtr("kind").?.string, "CompoundStmt")) {
                    log.err("`FunctionTemplateDecl` `{s}` without `CompoundStmt`", .{name});
                    return;
                }
            }

            const sig = parseFnSignature(item).?;
            const method_name = item.object.get("name").?.string;

            const ret = try self.transpileType(sig.ret_type);
            defer self.allocator.free(ret);

            try self.out.print("pub ", .{});
            if (item.object.get("inline")) |v_inline| {
                if (v_inline.bool) try self.out.print("inline ", .{});
            }
            try self.out.print("fn {s}({s}", .{ method_name, cp.items });

            var body = std.ArrayList(u8).init(self.allocator);
            defer body.deinit();

            for (f_items) |*f_item| {
                const arg_kind = f_item.object.get("kind").?.string;
                if (mem.eql(u8, arg_kind, "ParmVarDecl")) {
                    self.nodes_visited += 1;

                    const ty = f_item.object.get("type").?;
                    var qual = ty.object.get("qualType").?.string;

                    // va_list is in practice a `char*`, but we can double check this by verifing the desugared type
                    if (mem.eql(u8, qual, "va_list")) {
                        if (ty.object.get("desugaredQualType")) |v_desurgared| {
                            qual = v_desurgared.string;
                        }
                    }

                    if (comma) {
                        try self.out.print(", ", .{});
                    }
                    comma = true;

                    const arg_name = f_item.object.get("name").?.string;
                    const arg_type = try self.transpileType(qual);
                    defer self.allocator.free(arg_type);

                    try self.out.print("{s}: {s}", .{ arg_name, arg_type });
                } else if (mem.eql(u8, arg_kind, "FormatAttr")) {
                    // varidatic function with the same properties as printf
                    self.nodes_visited += 1;
                } else if (mem.eql(u8, arg_kind, "CompoundStmt")) {
                    const tmp = self.out;
                    self.out = body.writer();
                    try self.visitCompoundStmt(f_item);
                    self.out = tmp;
                    break;
                } else {
                    log.err("unhandled `FunctionDecl` item `{s}` in `FunctionTemplateDecl` `{s}`", .{ arg_kind, method_name });
                }
            }

            if (sig.varidatic) {
                if (comma) {
                    try self.out.print(", ", .{});
                }
                try self.out.print("...) {s}", .{ret});
            } else {
                try self.out.print(") {s}", .{ret});
            }

            try self.out.print(" {s}\n\n", .{body.items});

            return;
        } else {
            log.err("unhandled item `{s}` in `FunctionTemplateDecl` `{s}`", .{ kind, name });
        }
    }

    log.err("`FunctionTemplateDecl` `{s}` without `FunctionDecl`", .{name});
}

fn visitEnumDecl(self: *Self, value: *const json.Value) !void {
    if (self.shouldSkip(value)) {
        self.nodes_visited += nodeCount(value);
        return;
    }

    var name: []const u8 = undefined;
    if (value.object.get("name")) |v| {
        name = v.string;
    } else {
        // todo: handle unamed enumerations that aren't inside a typedef like these `enum { FPNG_ENCODE_SLOWER = 1,  FPNG_FORCE_UNCOMPRESSED = 2, };`
        // referenced by someone else
        const id = try std.fmt.parseInt(u64, value.object.get("id").?.string, 0);
        _ = try self.namespace.unnamed_nodes.put(id, value.*);
        return;
    }

    var inner = value.object.get("inner");
    if (inner == null) {
        // e.g. `enum ImGuiKey : int;`
        try self.namespace.opaques.put(name, undefined);
        return;
    }

    self.nodes_visited += 1;

    // remove opque if any
    _ = self.namespace.opaques.swapRemove(name);

    // todo: use "fixedUnderlyingType" or figure out the type by himself
    try self.out.print("pub const {s} = extern struct {{\n", .{name});
    try self.out.print("    bits: c_int = 0,\n\n", .{});

    var variant_prev: ?[]const u8 = null;
    var variant_counter: usize = 0;

    for (inner.?.array.items) |inner_item| {
        if (inner_item.object.get("isImplicit")) |is_implicit| {
            if (is_implicit.bool) {
                self.nodes_visited += nodeCount(&inner_item);
                continue;
            }
        }

        const variant_tag = inner_item.object.get("kind").?.string;
        if (mem.eql(u8, variant_tag, "EnumConstantDecl")) {
            const variant_name = resolveEnumVariantName(name, inner_item.object.get("name").?.string);
            try self.out.print("    pub const {s}: {s}", .{ variant_name, name });
            // transpile enum value
            try self.out.print(" = .{{ .bits = ", .{});
            if (inner_item.object.get("inner")) |j_value| {
                for (j_value.array.items) |j_value_item| {
                    try self.visit(&j_value_item);
                }
                variant_prev = variant_name;
                variant_counter = 1;
            } else {
                if (variant_prev) |n| {
                    try self.out.print("{s}.{s}.bits + {d}", .{ name, n, variant_counter });
                } else {
                    try self.out.print("{d}", .{variant_counter});
                }
                variant_counter += 1;
            }
            try self.out.print(" }};\n", .{});
        } else {
            log.err("unhandled `{s}` in enum `{s}`", .{ variant_tag, name });
            continue;
        }

        self.nodes_visited += 1;
    }

    try self.out.print("\n    // pub usingnamespace cpp.FlagsMixin({s});\n", .{name});
    try self.out.print("}};\n\n", .{});
}

fn visitTypedefDecl(self: *Self, value: *const json.Value) !void {
    if (self.shouldSkip(value)) {
        self.nodes_visited += nodeCount(value);
        return;
    }
    self.nodes_visited += 1;

    const name = value.object.get("name").?.string;

    if (value.object.get("inner")) |v_inner| {
        if (v_inner.array.items.len != 1) {
            log.err("complex typedef `{s}`", .{name});
            return;
        }

        const v_item = &v_inner.array.items[0];
        const tag = v_item.object.get("kind").?.string;
        if (mem.eql(u8, tag, "BuiltinType") or mem.eql(u8, tag, "TypedefType")) {
            // type alias
            self.nodes_visited += nodeCount(v_item);
        } else if (mem.eql(u8, tag, "ElaboratedType")) {
            // c style simplified struct definition
            if (v_item.object.get("ownedTagDecl")) |v_owned| {
                const id_name = v_owned.object.get("id").?.string;
                const id = try std.fmt.parseInt(u64, id_name, 0);
                if (self.namespace.unnamed_nodes.getPtr(id)) |node| {
                    const n_tag = node.object.getPtr("kind").?.string;
                    if (mem.eql(u8, n_tag, "CXXRecordDecl")) {
                        self.nodes_visited += 1;
                        var object = try node.object.clone();
                        defer object.deinit();
                        // rename the object
                        _ = try object.put("name", json.Value{ .string = name });
                        // todo: impl the union or struct or whatever using `name`
                        try self.visitCXXRecordDecl(&json.Value{ .object = object });
                    } else if (mem.eql(u8, n_tag, "EnumDecl")) {
                        self.nodes_visited += 1;
                        var object = try node.object.clone();
                        defer object.deinit();
                        // rename the object
                        _ = try object.put("name", json.Value{ .string = name });
                        // todo: impl the union or struct or whatever using `name`
                        try self.visitEnumDecl(&json.Value{ .object = object });
                    } else {
                        log.err("unhandled `ElaboratedType` `{s}` in typedef `{s}`", .{ n_tag, name });
                    }
                    // remove used node
                    _ = self.namespace.unnamed_nodes.remove(id);
                } else {
                    // currenly been triggered by: `typedef struct Point { float x, y; } Point;`
                    self.nodes_visited += nodeCount(v_item);
                    log.warn("missing node `{s}` of `ElaboratedType` in typedef `{s}`", .{ id_name, name });
                }
                return;
            } else {
                // other kind of type alias
                // todo: use the inner "RecordType"
                self.nodes_visited += nodeCount(v_item);
            }
        } else if (mem.eql(u8, tag, "PointerType")) {
            // note: sadly the clang will remove type names from function pointers, but is one thing less to deal with
            self.nodes_visited += nodeCount(v_item);
        } else if (mem.eql(u8, tag, "TemplateTypeParmType")) {
            self.nodes_visited += 1;
            try self.out.print("pub const {s} = {s};\n\n", .{ name, typeQualifier(v_item).? });
            return;
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
        self.nodes_visited += nodeCount(value);
        return;
    }
    self.nodes_visited += 1;

    const v_name = value.object.get("name");

    var inner = value.object.get("inner");
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

    const parent_namespace = self.beginNamespace();

    if (v_name) |name| {
        try self.out.print("pub const {s} = struct {{\n", .{name.string});
    }

    for (inner.?.array.items) |inner_item| {
        try self.visit(&inner_item);
    }

    try self.endNamespace(parent_namespace);

    if (v_name) |_| {
        try self.out.print("}};\n\n", .{});
    }
}

inline fn visitFunctionDecl(self: *Self, value: *const json.Value) !void {
    // a function is a method without a parent struct
    return self.visitCXXMethodDecl(value, null);
}

fn visitTemplateTypeParmDecl(self: *Self, node: *const json.Value, parent: []const u8) !void {
    self.nodes_visited += 1;

    var name = node.object.get("name");
    if (name == null) {
        log.err("unnamed template param in `{s}`", .{parent});
        return;
    }

    var tag = node.object.get("tagUsed");
    if (tag == null) {
        self.nodes_visited -= 1;
        log.err("untaged template param in `{s}`", .{parent});
        return;
    }

    if (mem.eql(u8, tag.?.string, "typename")) {
        try self.out.print("comptime {s}: type", .{name.?.string});
    } else {
        try self.out.print("comptime {s}: anytype", .{name.?.string});
    }
}

fn visitClassTemplateDecl(self: *Self, value: *const json.Value) !void {
    if (self.shouldSkip(value)) {
        self.nodes_visited += nodeCount(value);
        return;
    }
    self.nodes_visited += 1;

    var name: []const u8 = undefined;
    if (value.object.get("name")) |v| {
        name = v.string;
    } else {
        self.nodes_visited -= 1;
        log.err("unnamed `ClassTemplateDecl`", .{});
        return;
    }

    var inner = value.object.get("inner");
    if (inner == null) {
        log.warn("generic opaque `{s}`", .{name});
        return;
    }

    // pub fn Generic(comptime T: type, ...) {
    //    return struct {
    //    };
    // };

    try self.out.print("pub fn {s}(", .{name});

    var functions = std.ArrayList(u8).init(self.allocator);
    defer functions.deinit();

    const parent_state = self.scope;
    self.scope = .{ .tag = .class, .name = "Self" };
    defer self.scope = parent_state;

    // template param
    var tp_comma = false;
    for (inner.?.array.items) |*item| {
        const item_kind = item.object.get("kind").?.string;
        if (mem.eql(u8, item_kind, "TemplateTypeParmDecl")) {
            if (tp_comma) {
                try self.out.print(", ", .{});
            }
            tp_comma = true;

            try self.visitTemplateTypeParmDecl(item, name);
        } else if (mem.eql(u8, item_kind, "CXXRecordDecl")) {
            self.nodes_visited += 1;

            // template definition
            try self.out.print(") type {{\n    return extern struct {{\n", .{});
            try self.out.print("        const Self = @This();\n\n", .{});

            var inner_inner = item.object.get("inner");
            if (inner_inner == null) {
                log.warn("blank `{s}` template", .{name});
                return;
            }

            const parent_namespace = self.beginNamespace();

            for (inner_inner.?.array.items) |inner_item| {
                self.nodes_visited += 1;

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
                    self.out = functions.writer();
                    try self.visitCXXMethodDecl(&inner_item, "Self");
                    self.out = tmp;
                } else if (mem.eql(u8, inner_item_kind, "TypedefDecl")) {
                    const out = self.out;
                    self.out = functions.writer();
                    try self.visitTypedefDecl(&inner_item);
                    self.out = out;
                } else {
                    self.nodes_visited -= 1;
                    log.err("unhandled `{s}` in template `{s}`", .{ inner_item_kind, name });
                }
            }

            // delcarations must be after fields
            if (functions.items.len > 0) {
                try self.out.print("\n{s}", .{functions.items});
            }

            try self.endNamespace(parent_namespace);

            try self.out.print("    }};\n}}\n\n", .{});

            return;
        } else {
            log.err("unhandled `{s}` in template `{s}`", .{ item_kind, name });
        }
    }
}

fn visitCompoundStmt(self: *Self, value: *const json.Value) !void {
    self.nodes_visited += 1;

    var inner = value.object.get("inner");
    if (inner == null) {
        return;
    }

    try self.out.print("{{\n", .{});

    const scope = self.scope;
    defer self.scope = scope;
    self.scope = .{
        .tag = .local,
        .name = null,
    };

    self.semicolon = true;

    for (inner.?.array.items) |inner_item| {
        try self.visit(&inner_item);

        if (self.semicolon) {
            _ = try self.out.write(";\n");
        } else {
            // reset
            self.semicolon = true;
        }
    }

    try self.out.print("}}", .{});
}

fn visitIfStmt(self: *Self, value: *const json.Value) !void {
    const j_inner = value.object.getPtr("inner").?;

    try self.out.print(" if (", .{});
    try self.visit(&j_inner.array.items[0]);
    try self.out.print(") ", .{});

    var body = &j_inner.array.items[1];
    try self.visit(body);

    if (if (value.object.getPtr("hasElse")) |j_else| j_else.bool else false) {
        try self.out.print(" else ", .{});
        body = &j_inner.array.items[2];
        try self.visit(body);
    }

    // don't print a semicolon when the if else is guarded with braces `if { ... }`
    self.semicolon = !mem.eql(u8, body.object.getPtr("kind").?.string, "CompoundStmt");

    self.nodes_visited += 1;
}

fn visitForStmt(self: *Self, value: *const json.Value) !void {
    const j_inner = value.object.getPtr("inner").?;

    // var delcarations
    var braces = false;
    var vars = &j_inner.array.items[0];
    if (vars.object.count() != 0) {
        // note: extra braces required for nested loops and to avoid variable shadowing
        braces = true;
        try self.out.print("{{ ", .{});
        try self.visit(vars);
        try self.out.print("; ", .{});
    }

    // todo: handle node at index == `1`

    try self.out.print("while (", .{});
    try self.visit(&j_inner.array.items[2]);
    try self.out.print(")", .{});

    var exp = &j_inner.array.items[3];
    if (exp.object.count() != 0) {
        const exp_kind = exp.object.getPtr("kind").?.string;
        if (mem.eql(u8, exp_kind, "UnaryOperator") or mem.eql(u8, exp_kind, "CompoundAssignOperator") or (mem.eql(u8, exp_kind, "BinaryOperator") and !mem.eql(u8, exp.object.getPtr("opcode").?.string, ","))) {
            // not a ',' operator so it doesnt require a scope
            try self.out.print(" : (", .{});
            try self.visit(exp);
            try self.out.print(")", .{});
        } else {
            // default behaviour
            try self.out.print(" : ({{ ", .{});
            try self.visit(exp);
            try self.out.print("; }})", .{});
        }
    }

    var body = &j_inner.array.items[4];
    try self.visit(body);

    // don't print a semicolon when the if else is guarded with braces `for (...) { ... }`
    self.semicolon = !mem.eql(u8, body.object.getPtr("kind").?.string, "CompoundStmt");

    if (braces) {
        if (self.semicolon) try self.out.print("; ", .{});
        self.semicolon = false;

        try self.out.print("}} ", .{});
    }

    self.nodes_visited += 1;
}

fn visitWhileStmt(self: *Self, node: *const json.Value) !void {
    const j_inner = node.object.getPtr("inner").?;

    try self.out.print("while (", .{});
    var exp = &j_inner.array.items[0];
    try self.visit(exp);
    try self.out.print(")", .{});

    var body = &j_inner.array.items[1];
    try self.visit(body);

    // don't print a semicolon when the if else is guarded with braces `while (...) { ... }`
    self.semicolon = !mem.eql(u8, body.object.getPtr("kind").?.string, "CompoundStmt");
    self.nodes_visited += 1;
}

fn visitReturnStmt(self: *Self, value: *const json.Value) !void {
    self.nodes_visited += 1;

    const v_inner = value.object.get("inner");
    if (v_inner == null) {
        try self.out.print("return", .{});
        return;
    }

    _ = try self.out.write("return ");
    // todo: must check if is returning an aliesed pointer, if so it must add the referece operator '&'
    try self.visit(&v_inner.?.array.items[0]);
}

fn visitBinaryOperator(self: *Self, node: *const json.Value) !void {
    const inner = node.object.getPtr("inner").?;
    const opcode = node.object.getPtr("opcode").?.string;

    // todo: transpile `a = b = c;` into `b = c; a = b;` but can't ignore all casts

    try self.visit(&inner.array.items[0]);

    if (mem.eql(u8, opcode, "||")) {
        try self.out.print(" or ", .{});
    } else if (mem.eql(u8, opcode, "&&")) {
        try self.out.print(" and ", .{});
    } else if (mem.eql(u8, opcode, ",")) {
        // yep this is a thing used inside some loops `for(...;...; i++, j++)`
        //                                                          ^^^^^^^^ binary operator ","
        try self.out.print("; ", .{});
    } else {
        try self.out.print(" {s} ", .{opcode});
    }

    try self.visit(&inner.array.items[1]);

    self.nodes_visited += 1;
}

fn visitCompoundAssignOperator(self: *Self, node: *const json.Value) !void {
    const inner = node.object.getPtr("inner").?;
    const opcode = node.object.getPtr("opcode").?.string;

    // todo: transpile `a = b = c;` into `b = c; a = b;` but can't ignore all casts

    try self.visit(&inner.array.items[0]);
    try self.out.print(" {s} ", .{opcode});
    try self.visit(&inner.array.items[1]);

    self.nodes_visited += 1;
}

fn visitImplicitCastExpr(self: *Self, value: *const json.Value) !void {
    self.nodes_visited += 1;

    const kind = value.object.getPtr("castKind").?.string;
    if (mem.eql(u8, kind, "IntegralToBoolean")) {
        try self.out.print("((", .{});
        try self.visit(&value.object.getPtr("inner").?.array.items[0]);
        try self.out.print(") != 0)", .{});
        return;
    } else if (mem.eql(u8, kind, "LValueToRValue") or mem.eql(u8, kind, "NoOp")) {
        // todo: wut!?
        try self.visit(&value.object.getPtr("inner").?.array.items[0]);
        return;
    } else if (mem.eql(u8, kind, "FunctionToPointerDecay")) {
        // todo: figure out when a conversion is really needed
        try self.visit(&value.object.getPtr("inner").?.array.items[0]);
        return;
    } else if (mem.eql(u8, kind, "ToVoid")) {
        // todo: casting to void is a shitty way of evaluating expressions that might have side effects,
        // https://godbolt.org/z/45xYqaz37 shown that the following snippet should be executed even in release builds
        try self.out.print("_ = (", .{});
        try self.visit(&value.object.getPtr("inner").?.array.items[0]);
        try self.out.print(");\n", .{});
        return;
    }

    const dst = try self.transpileType(typeQualifier(value).?);
    defer self.allocator.free(dst);

    if (mem.eql(u8, kind, "BitCast")) {
        if (mem.startsWith(u8, dst, "*") or mem.startsWith(u8, dst, "[*c]")) {
            try self.out.print("@ptrCast({s}, ", .{dst});
        } else {
            try self.out.print("@bitCast({s}, ", .{dst});
        }
        try self.visit(&value.object.getPtr("inner").?.array.items[0]);
    } else if (mem.eql(u8, kind, "IntegralCast")) {
        try self.out.print("@intCast({s}, ", .{dst});
        try self.visit(&value.object.getPtr("inner").?.array.items[0]);
    } else if (mem.eql(u8, kind, "NullToPointer")) {
        self.nodes_visited += 1;
        try self.out.print("null", .{});
        return;
    } else {
        log.warn("unknown `{s}` cast", .{kind});
        try self.out.print("@as({s}, ", .{dst});
        try self.visit(&value.object.getPtr("inner").?.array.items[0]);
    }

    try self.out.print(")", .{});
}

fn visitMemberExpr(self: *Self, node: *const json.Value) !void {
    self.nodes_visited += 1;

    const target = &node.object.getPtr("inner").?.array.items[0];
    try self.visit(target);

    const name = node.object.getPtr("name").?.string;
    try self.out.print(".{s}", .{name});
}

fn visitCXXDependentScopeMemberExpr(self: *Self, node: *const json.Value) !void {
    self.nodes_visited += 1;

    const target = &node.object.getPtr("inner").?.array.items[0];
    try self.visit(target);

    const member = node.object.getPtr("member").?.string;
    try self.out.print(".{s}", .{member});
}

fn visitIntegerLiteral(self: *Self, value: *const json.Value) !void {
    const literal = value.object.getPtr("value").?.string;
    _ = try self.out.write(literal);
    self.nodes_visited += 1;
}

inline fn visitCStyleCastExpr(self: *Self, value: *const json.Value) !void {
    return self.visitImplicitCastExpr(value);
}

fn visitArraySubscriptExpr(self: *Self, value: *const json.Value) !void {
    self.nodes_visited += 1;
    var v_inner = value.object.get("inner");
    try self.visit(&v_inner.?.array.items[0]);
    try self.out.print("[", .{});
    try self.visit(&v_inner.?.array.items[1]);
    try self.out.print("]", .{});
}

fn visitUnaryExprOrTypeTraitExpr(self: *Self, value: *const json.Value) !void {
    const name = value.object.getPtr("name").?.string;
    if (mem.eql(u8, name, "sizeof")) {
        if (value.object.getPtr("argType")) |j_ty| {
            // simple type name
            const size_of = try self.transpileType(j_ty.object.get("qualType").?.string);
            defer self.allocator.free(size_of);
            try self.out.print("@sizeOf({s})", .{size_of});
        } else {
            // complex expression like a template type parameter
            _ = try self.out.write("@sizeOf");
            try self.visit(&value.object.getPtr("inner").?.array.items[0]);
        }
    } else {
        log.err("unknonw `UnaryExprOrTypeTraitExpr` `{s}`", .{name});
        return;
    }

    self.nodes_visited += 1;
}

fn visitDeclRefExpr(self: *Self, value: *const json.Value) !void {
    const j_ref = value.object.getPtr("referencedDecl").?;
    const kind = j_ref.object.getPtr("kind").?.string;
    if (mem.eql(u8, kind, "ParmVarDecl") or mem.eql(u8, kind, "FunctionDecl") or mem.eql(u8, kind, "VarDecl")) {
        const name = j_ref.object.get("name").?.string;
        _ = try self.out.write(name);
    } else if (mem.eql(u8, kind, "EnumConstantDecl")) {
        const base = typeQualifier(j_ref).?;
        const variant = resolveEnumVariantName(base, j_ref.object.get("name").?.string);
        try self.out.print("{s}.{s}.bits", .{ base, variant });
    } else {
        log.err("unhandled `{s}` in `DeclRefExpr`", .{kind});
        return;
    }

    self.nodes_visited += 1;
}

fn visitParenExpr(self: *Self, value: *const json.Value) !void {
    const rvalue = typeQualifier(value).?;
    if (mem.eql(u8, rvalue, "void")) {
        // inner expression results in nothing
        try self.visit(&value.object.get("inner").?.array.items[0]);
    } else {
        try self.out.print("(", .{});
        try self.visit(&value.object.get("inner").?.array.items[0]);
        try self.out.print(")", .{});
    }

    self.nodes_visited += 1;
}

fn visitUnaryOperator(self: *Self, value: *const json.Value) !void {
    const opcode = value.object.getPtr("opcode").?.string;

    if (mem.eql(u8, opcode, "*")) {
        // deref
        const exp = &value.object.get("inner").?.array.items[0];
        const exp_kind = exp.object.getPtr("kind").?.string;
        // handles the case of `*data++`, is still worng but is easer to see why
        const parentheses = mem.eql(u8, exp_kind, "UnaryOperator");

        if (parentheses) try self.out.print("(", .{});
        try self.visit(exp);
        if (parentheses) try self.out.print(")", .{});
        try self.out.print(".*", .{});
    } else if (mem.eql(u8, opcode, "++")) {
        try self.visit(&value.object.get("inner").?.array.items[0]);
        try self.out.print(" += 1", .{});
    } else if (mem.eql(u8, opcode, "--")) {
        try self.visit(&value.object.get("inner").?.array.items[0]);
        try self.out.print(" -= 1", .{});
    } else {
        // note: any special cases should be handled with ifelse branches
        try self.out.print("{s}", .{opcode});
        try self.visit(&value.object.get("inner").?.array.items[0]);
    }

    self.nodes_visited += 1;
}

fn visitCallExpr(self: *Self, value: *const json.Value) !void {
    self.nodes_visited += 1;
    const inner = value.object.getPtr("inner").?;

    const callee = &inner.array.items[0];
    const kind = callee.object.getPtr("kind").?.string;
    if (mem.eql(u8, kind, "UnresolvedLookupExpr")) {
        self.nodes_visited += 1;

        const loopups = callee.object.getPtr("lookups").?.array.items;
        if (loopups.len > 1) {
            // todo: resolve the callee from the lookup table
            log.warn("unresolved `CallExpr` callee `{s}`", .{callee.object.getPtr("name").?.string});
        }

        // just take the frist one
        const entry = &loopups[0];
        const entry_kind = entry.object.getPtr("kind").?.string;
        if (mem.eql(u8, entry_kind, "FunctionDecl")) {
            _ = try self.out.write(entry.object.getPtr("name").?.string);
        } else if (mem.eql(u8, entry_kind, "FunctionTemplateDecl")) {
            // todo: outpu generic parameters
            _ = try self.out.write(entry.object.getPtr("name").?.string);
        } else {
            log.err("unhandled loopup entry `{s}` in `CallExpr` `{s}`", .{ entry_kind, callee.object.getPtr("name").?.string });
            return;
        }
    } else {
        try self.visit(callee);
    }

    _ = try self.out.write("(");

    // args
    const count = inner.array.items.len;
    for (1..count) |i| {
        try self.visit(&inner.array.items[i]);

        if (i != count - 1) {
            _ = try self.out.write(", ");
        }
    }

    _ = try self.out.write(")");
}

fn visitCXXMemberCallExpr(self: *Self, value: *const json.Value) !void {
    self.nodes_visited += 1;

    const j_inner = value.object.getPtr("inner").?;

    const j_member = &j_inner.array.items[0];
    const kind = j_member.object.getPtr("kind").?.string;
    if (mem.eql(u8, kind, "MemberExpr")) {
        const name = j_member.object.getPtr("name").?.string;
        try self.out.print("self.{s}", .{name});
        self.nodes_visited += nodeCount(j_member);
    } else {
        log.err("unknown `{s}` in  `CXXMemberCallExpr`", .{kind});
        return;
    }

    _ = try self.out.write("(");

    // args
    const count = j_inner.array.items.len;
    for (1..count) |i| {
        try self.visit(&j_inner.array.items[i]);

        if (i != count - 1) {
            _ = try self.out.write(", ");
        }
    }

    _ = try self.out.write(")");
}

fn visitCXXPseudoDestructorExpr(self: *Self, node: *const json.Value) !void {
    self.nodes_visited += 1;

    const items = node.object.getPtr("inner").?.array.items;
    try self.visit(&items[0]);
    _ = try self.out.write(".deinit");
}

fn visitCXXThisExpr(self: *Self, _: *const json.Value) !void {
    self.nodes_visited += 1;
    try self.out.print("self", .{});
}

fn visitConstantExpr(self: *Self, value: *const json.Value) !void {
    self.nodes_visited += 1;

    for (value.object.get("inner").?.array.items) |j_stmt| {
        // note: any special cases should be handled with ifelse branches
        try self.visit(&j_stmt);
    }
}

fn visitCXXBoolLiteralExpr(self: *Self, value: *const json.Value) !void {
    self.nodes_visited += 1;

    try self.out.print("{}", .{value.object.getPtr("value").?.bool});
}

fn visitDeclStmt(self: *Self, node: *const json.Value) !void {
    self.nodes_visited += 1;

    if (node.object.getPtr("inner")) |decls| {
        // declaration statement like `int a, b, c;`
        const last = decls.array.items.len - 1;
        for (decls.array.items, 0..) |*decl, i| {
            try self.visit(decl);
            if (last != i) {
                try self.out.print(";\n", .{});
            }
        }
    }
}

fn visitCXXNullPtrLiteralExpr(self: *Self, _: *const json.Value) !void {
    self.nodes_visited += 1;
    _ = try self.out.write("null");
}

fn visitCXXOperatorCallExpr(self: *Self, node: *const json.Value) !void {
    // A call to an overloaded operator
    self.nodes_visited += 1;

    //var name = node.object.get("name").?.string;
    var inner = node.object.getPtr("inner").?.array.items;

    // ignore implicit casts
    var op = &inner[0];
    var op_kind = op.object.getPtr("kind").?.string;
    while (mem.eql(u8, op_kind, "ImplicitCastExpr")) {
        self.nodes_visited += 1;
        op = &op.object.getPtr("inner").?.array.items[0];
        op_kind = op.object.getPtr("kind").?.string;
    }

    // figure out what operator function to call
    var op_name: []const u8 = "???";
    var deref = false;
    if (mem.eql(u8, op_kind, "DeclRefExpr")) {
        self.nodes_visited += 1;

        const ref = op.object.getPtr("referencedDecl").?;
        const ref_kind = ref.object.getPtr("kind").?.string;
        if (mem.eql(u8, ref_kind, "CXXMethodDecl")) {
            const name = ref.object.getPtr("name").?.string;
            if (mem.eql(u8, name, "operator[]")) {
                const sig = parseFnSignature(ref).?;
                if (!sig.const_self and mem.endsWith(u8, sig.ret_type, "&")) {
                    // class[i] = value;
                    op_name = "getPtr";
                    deref = true;
                } else {
                    // value = class[i];
                    op_name = "get";
                }
            } else if (mem.eql(u8, name, "operator=")) {
                op_name = "copyFrom";
            } else {
                log.err("unhandled operator `{s}` in `CXXOperatorCallExpr`", .{name});
                return;
            }
        } else {
            log.err("unhandlded referece decl `{s}` of `DeclRefExpr` in `CXXOperatorCallExpr`", .{ref_kind});
            return;
        }
    } else {
        log.err("unhandlded `{s}` in `CXXOperatorCallExpr`", .{op_kind});
        return;
    }

    try self.visit(&inner[1]);
    try self.out.print(".{s}(", .{op_name});

    // args
    var comma = false;
    const count = inner.len;
    for (2..count) |i| {
        try self.visit(&inner[i]);

        if (comma) _ = try self.out.write(", ");
        comma = true;
    }

    _ = try self.out.write(")");
    if (deref) _ = try self.out.write(".*");
}

fn visitUnresolvedMemberExpr(self: *Self, _: *const json.Value) !void {
    self.nodes_visited += 1;

    // todo: wut?!
    log.warn("impossible to solve `UnresolvedMemberExpr`", .{});
    _ = try self.out.write("@\"unresolvedMemberExpr!\"");
}

fn visitConditionalOperator(self: *Self, node: *const json.Value) !void {
    // The ?: ternary operator.
    self.nodes_visited += 1;

    const inner = node.object.getPtr("inner").?.array.items;

    _ = try self.out.write(" if (");
    try self.visit(&inner[0]);
    _ = try self.out.write(") ");
    try self.visit(&inner[1]);
    _ = try self.out.write(" else ");
    try self.visit(&inner[2]);
    _ = try self.out.write(" ");

    self.semicolon = true;
}

fn visitBreakStmt(self: *Self, _: *const json.Value) !void {
    self.nodes_visited += 1;
    _ = try self.out.write("break");
}

fn visitStringLiteral(self: *Self, node: *const json.Value) !void {
    self.nodes_visited += 1;
    _ = try self.out.write("\"");
    try self.out.print("{}", .{std.zig.fmtEscapes(node.object.getPtr("value").?.string)});
    _ = try self.out.write("\"");
}

///////////////////////////////////////////////////////////////////////////////

inline fn typeQualifier(value: *const json.Value) ?[]const u8 {
    if (value.object.getPtr("type")) |j_type| {
        if (j_type.object.getPtr("qualType")) |j_qualifier| {
            return j_qualifier.string;
        }
    }
    return null;
}

inline fn resolveEnumVariantName(base: []const u8, variant: []const u8) []const u8 {
    return if (mem.startsWith(u8, variant, base)) variant[base.len..] else variant;
}

fn parseFnSignature(value: *const json.Value) ?FnSig {
    if (typeQualifier(value)) |sig| {
        var meta: FnSig = undefined;

        var lp = mem.lastIndexOf(u8, sig, ")").?;
        meta.const_self = mem.endsWith(u8, sig[lp..], ") const");
        meta.varidatic = mem.endsWith(u8, sig[0 .. lp + 1], "... )");

        var s = mem.split(u8, sig, "(");
        meta.ret_type = s.first();

        return meta;
    }
    return null;
}

inline fn shouldSkip(self: *Self, value: *const json.Value) bool {
    // todo: incorporate this?
    // if (value.object.get("isImplicit")) |implicit| {
    //     if (implicit.bool) {
    //         return true;
    //     }
    // }
    if (!self.transpile_includes) {
        if (value.object.getPtr("loc")) |loc| {
            // c include
            if (loc.object.getPtr("includedFrom") != null) return true;
            // c++ ...
            if (loc.object.getPtr("expansionLoc")) |expansionLoc| {
                if (expansionLoc.object.getPtr("includedFrom") != null) return true;
            }
        }
    }
    return false;
}

fn nodeCount(value: *const json.Value) usize {
    var count: usize = 1;
    if (value.object.getPtr("inner")) |j_inner| {
        for (j_inner.array.items) |*j_item| {
            count += nodeCount(j_item);
        }
    }
    return count;
}

fn transpileType(self: *Self, tname: []const u8) ![]u8 {
    var ttname = mem.trim(u8, tname, " ");

    // remove struct from C style definition
    if (mem.startsWith(u8, ttname, "struct ")) {
        ttname = ttname["struct ".len..];
    }

    const ch = ttname[ttname.len - 1];
    if (ch == '*' or ch == '&') {
        // note: avoid c-style pointers `[*c]` when dealing with references types
        // note: references pointer types can't be null
        const ptr = if (ch == '&') "*" else "[*c]";

        var constness: []const u8 = "const ";
        var raw_name: []const u8 = undefined;

        var buf: [7]u8 = undefined;
        var template = try fmt.bufPrint(&buf, "const {c}", .{ch});
        if (mem.endsWith(u8, ttname, template)) {
            // const pointer of pointers
            raw_name = ttname[0..(ttname.len - template.len)];
        } else if (mem.startsWith(u8, ttname, "const ")) {
            // const pointer
            raw_name = ttname[("const ".len)..(ttname.len - 1)];
        } else {
            // mutable pointer case
            raw_name = ttname[0..(ttname.len - 1)];
            constness = "";
        }

        // special case
        if (mem.eql(u8, mem.trim(u8, raw_name, " "), "void")) {
            return try fmt.allocPrint(self.allocator, "?*{s}anyopaque", .{constness});
        }

        var inner = try self.transpileType(raw_name);
        defer self.allocator.free(inner);
        return try fmt.allocPrint(self.allocator, "{s}{s}{s}", .{ ptr, constness, inner });
    } else if (ch == ']') {
        // fixed sized array
        const len = mem.lastIndexOf(u8, ttname, "[").?;
        var inner_name = try self.transpileType(ttname[0..len]);
        defer self.allocator.free(inner_name);
        return try fmt.allocPrint(self.allocator, "{s}{s}", .{ ttname[len..], inner_name });
    } else if (ch == ')') {
        // todo: handle named function pointers `typedef int (*)(ImGuiInputTextCallbackData* data);`
        // function pointer or invalid type name
        if (mem.indexOf(u8, ttname, "(*)")) |ptr| {
            var index: usize = 0;
            var args = std.ArrayList(u8).init(self.allocator);
            defer args.deinit();
            try self.transpileArgs(mem.trim(u8, ttname[(ptr + "(*)".len) + 1 .. ttname.len - 1], " "), &args, &index);

            const tret = try self.transpileType(ttname[0..ptr]);
            defer self.allocator.free(tret);

            return try fmt.allocPrint(self.allocator, "?*const fn({s}) callconv(.C) {s} ", .{ args.items, tret });
        } else {
            log.err("unknow type `{s}`, falling back to `*anyopaque`", .{ttname});
            ttname = "*anyopaque";
        }
    } else if (ch == '>') {
        // templated type
        var index: usize = 0;
        var args = std.ArrayList(u8).init(self.allocator);
        defer args.deinit();

        const less_than = mem.indexOf(u8, ttname, "<").?;

        const root = try self.transpileType(ttname[0..less_than]);
        defer self.allocator.free(root);

        try self.transpileArgs(ttname[less_than..], &args, &index);

        return try fmt.allocPrint(self.allocator, "{s}{s}", .{ root, args.items });
    } else {
        // common primitives
        if (PrimitivesTypeLUT.get(ttname)) |pname| {
            ttname = pname;
        }
    }

    var buf = try self.allocator.alloc(u8, ttname.len);
    mem.copyForwards(u8, buf, ttname);
    return buf;
}

// generics `Vector<TypeArgs>`
// function arguments without parameters name in fn pointers `const void (x)(TypeArgs)`
fn transpileArgs(self: *Self, args: []const u8, buffer: *std.ArrayList(u8), index: *usize) anyerror!void {
    var start = index.*;
    while (index.* < args.len) {
        const ch = args[index.*];
        if (ch == '<') {
            const arg = args[start..index.*];
            try buffer.appendSlice(arg);
            try buffer.append('(');
            index.* += 1;
            try self.transpileArgs(args, buffer, index);
            start = index.*;
            continue;
        } else if (ch == '>') {
            const arg = args[start..index.*];
            const name = try self.transpileType(arg);
            defer self.allocator.free(name);
            try buffer.appendSlice(name);
            try buffer.append(')');
            index.* += 1;
            return;
        } else if (ch == ',') {
            if (index.* > start) {
                const arg = args[start..index.*];
                const name = try self.transpileType(arg);
                defer self.allocator.free(name);
                try buffer.appendSlice(name);
                try buffer.append(',');
                start = index.* + 1;
            } else {
                start = index.*;
            }
        }
        index.* += 1;
    }

    const rem = mem.trim(u8, args[start..], " ");
    if (rem.len > 0) {
        const name = try self.transpileType(rem);
        defer self.allocator.free(name);
        try buffer.appendSlice(name);
    }

    if (buffer.items.len > 0 and buffer.items[buffer.items.len - 1] == ',') {
        _ = buffer.pop();
    }
}
