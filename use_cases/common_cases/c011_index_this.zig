const std = @import("std");

pub const ImVec2 = extern struct {
    x: f32,
    y: f32,

    pub fn getRef(self: *ImVec2, idx: usize) ?*f32 {
        _ = ((idx == @intCast(usize, 0) or idx == @intCast(usize, 1)));
        return (@ptrCast(?*f32, @ptrCast(?*void, @ptrCast(?*u8, self))))[idx];
    }
    pub fn get(self: *const ImVec2, idx: usize) f32 {
        _ = ((idx == @intCast(usize, 0) or idx == @intCast(usize, 1)));
        return (@ptrCast(?*const f32, @ptrCast(?*const void, @ptrCast(?*const u8, self))))[idx];
    }
};
