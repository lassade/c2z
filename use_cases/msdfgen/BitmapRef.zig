const std = @import("std");

pub const byte = u8;

pub fn BitmapRef(comptime T: type, comptime N: c_int) type {
    return extern struct {
        const Self = @This();

        pixels: [*c]T,
        width: c_int,
        height: c_int,

        pub inline fn call(self: *const Self, x: c_int, y: c_int) [*c]T {
            return self.pixels + N * (self.width * y + x);
        }
    };
}

pub fn BitmapConstRef(comptime T: type, comptime N: c_int) type {
    return extern struct {
        const Self = @This();

        pixels: [*c]const T,
        width: c_int,
        height: c_int,

        pub inline fn call(self: *const Self, x: c_int, y: c_int) [*c]const T {
            return self.pixels + N * (self.width * y + x);
        }
    };
}
