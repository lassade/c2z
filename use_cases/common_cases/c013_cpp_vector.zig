const std = @import("std");
const cpp = @import("cpp");

extern fn _Z9enumerateRNSt3__16vectorIhNS_9allocatorIhEEEEy(out_buf: *cpp.Vector(u8), count: usize) bool;
pub const enumerate = _Z9enumerateRNSt3__16vectorIhNS_9allocatorIhEEEEy;
