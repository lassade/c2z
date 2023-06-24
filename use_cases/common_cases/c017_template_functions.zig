const std = @import("std");

extern fn _Z4freePv(_: ?*anyopaque) void;
pub const free = _Z4freePv;

pub fn IM_DELETE(comptime T: type, p: [*c]T) void {
    if (p) {
        p.deinit();
        free(p);
    }
}
