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
