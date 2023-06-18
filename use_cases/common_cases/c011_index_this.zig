const std = @import("std");

extern fn _Z8ImAssertb(_: bool) void;
pub const ImAssert = _Z8ImAssertb;

pub const ImVec2 = extern struct {
    x: f32,
    y: f32,

    pub fn getRef(self: *ImVec2, idx: usize) *f32 {
        return &@ptrCast([*]f32, self)[idx];
    }
    pub fn get(self: *const ImVec2, idx: usize) f32 {
        return @ptrCast([*]const f32, self)[idx];
    }
};
