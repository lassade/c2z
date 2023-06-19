const std = @import("std");
const expect = std.testing.expect;

const c005_inheritance = @import("c005_inheritance.zig");

test "c005_inheritance" {
    var circle: c005_inheritance.circle_t = c005_inheritance.circle_t.init();
    try expect(circle.radius == 0);
    circle = c005_inheritance.circle_t.initRadius(10);
    try expect(circle.radius == 10);
    try expect(circle.area() == 3.14 * 10 * 10);
    try expect(c005_inheritance.circle_t.area(&circle) == 3.14 * 10 * 10);
    circle.deinit();
}

test "c009_enum_flags" {
    const cpp = @import("c009_enum_flags.zig");

    var wflags: cpp.ImGuiWindowFlags_ = .{};
    wflags.bits |= cpp.ImGuiWindowFlags_.NoTitleBar.bits;

    var cflags: cpp.ConfigFlags = .{};
    cflags.bits |= cpp.ConfigFlags.FLAG_VSYNC_HINT.bits;
}

const c011_index_this = @import("c011_index_this.zig");

test "c011_index_this" {
    var p: c011_index_this.ImVec2 = .{ .x = 1, .y = 2 };
    try expect(p.get(0) == 1);
    try expect(p.get(1) == 2);
    p.getRef(0).* = 2;
    try expect(p.get(0) == 2);
}
