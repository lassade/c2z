const std = @import("std");

extern fn _Z27fpng_encode_image_to_memoryPKvjjjRNSt3__16vectorIhNS1_9allocatorIhEEEEj(pImage: ?*const anyopaque, w: u32, h: u32, num_chans: u32, out_buf: *cpp.Vector(u8), flags: u32) bool;
pub const fpng_encode_image_to_memory = _Z27fpng_encode_image_to_memoryPKvjjjRNSt3__16vectorIhNS1_9allocatorIhEEEEj;
