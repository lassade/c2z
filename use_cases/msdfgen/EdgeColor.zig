const std = @import("std");

pub const EdgeColor = extern struct {
    bits: c_int = 0,

    pub const BLACK: EdgeColor = .{ .bits = @intCast(c_uint, 0) };
    pub const RED: EdgeColor = .{ .bits = @intCast(c_uint, 1) };
    pub const GREEN: EdgeColor = .{ .bits = @intCast(c_uint, 2) };
    pub const YELLOW: EdgeColor = .{ .bits = @intCast(c_uint, 3) };
    pub const BLUE: EdgeColor = .{ .bits = @intCast(c_uint, 4) };
    pub const MAGENTA: EdgeColor = .{ .bits = @intCast(c_uint, 5) };
    pub const CYAN: EdgeColor = .{ .bits = @intCast(c_uint, 6) };
    pub const WHITE: EdgeColor = .{ .bits = @intCast(c_uint, 7) };

    // pub usingnamespace cpp.FlagsMixin(EdgeColor);
};
