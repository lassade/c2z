const std = @import("std");

pub fn Vector(comptime T: type) type {
    return extern struct {
        const Self = @This();

        Data: ?[*]T,
        Size: c_int,
        Capacity: c_int,

        pub inline fn empty(self: *const Self) bool {
            return (@as(c_int, self.Size) == 0);
        }
        pub inline fn size(self: *const Self) c_int {
            return @as(c_int, self.Size);
        }
        pub inline fn size_in_bytes(self: *const Self) c_int {
            return (@as(c_int, self.Size) * @as(c_int, @sizeOf(T)));
        }
        pub inline fn getPointer(self: *Self, i: c_int) *T {
            return &self.Data.?[i];
        }
        pub inline fn getValue(self: *const Self, i: c_int) *const T {
            return &self.Data.?[i];
        }
    };
}

test "size" {
    var arr = [1]u32{0xAF};
    var v = Vector(u32){ .Data = @ptrCast([*c]u32, &arr), .Size = 1, .Capacity = 1 };
    try std.testing.expectEqual(v.size(), 1);
    try std.testing.expectEqual(v.size_in_bytes(), @sizeOf(u32));
    try std.testing.expectEqual(v.getValue(0).*, 0xAF);
    try std.testing.expectEqual(v.getPointer(0).*, 0xAF);
}
