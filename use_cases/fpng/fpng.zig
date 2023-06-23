// auto-generated then modified to be the most idiomatic as possible

const std = @import("std");
const cpp = @import("cpp");

extern fn _ZN4fpng9fpng_initEv() void;
pub const fpng_init = _ZN4fpng9fpng_initEv;

extern fn _ZN4fpng23fpng_cpu_supports_sse41Ev() bool;
pub const fpng_cpu_supports_sse41 = _ZN4fpng23fpng_cpu_supports_sse41Ev;

extern fn _ZN4fpng10fpng_crc32EPKvyj(pData: ?*const anyopaque, size: usize, prev_crc32: u32) u32;
pub inline fn fpng_crc32(
    pData: ?*const anyopaque,
    size: usize,
    opt: struct { prev_crc32: u32 = 0 },
) u32 {
    return _ZN4fpng10fpng_crc32EPKvyj(pData, size, opt.prev_crc32);
}

extern fn _ZN4fpng12fpng_adler32EPKvyj(pData: ?*const anyopaque, size: usize, adler: u32) u32;
pub inline fn fpng_adler32(
    pData: ?*const anyopaque,
    size: usize,
    opt: struct { adler: u32 = 1 },
) u32 {
    return _ZN4fpng12fpng_adler32EPKvyj(pData, size, opt.adler);
}

pub const EncodeFlag = enum(u32) {
    ENCODE_SLOWER = 1,
    FORCE_UNCOMPRESSED = 2,
};

extern fn _ZN4fpng27fpng_encode_image_to_memoryEPKvjjjRNSt3__16vectorIhNS2_9allocatorIhEEEEj(pImage: ?*const anyopaque, w: u32, h: u32, num_chans: u32, out_buf: *cpp.Vector(u8), flags: EncodeFlag) bool;
pub const fpng_encode_image_to_memory = _ZN4fpng27fpng_encode_image_to_memoryEPKvjjjRNSt3__16vectorIhNS2_9allocatorIhEEEEj;

extern fn _ZN4fpng25fpng_encode_image_to_fileEPKcPKvjjjj(pFilename: [*c]const u8, pImage: ?*const anyopaque, w: u32, h: u32, num_chans: u32, flags: EncodeFlag) bool;
pub const fpng_encode_image_to_file = _ZN4fpng25fpng_encode_image_to_fileEPKcPKvjjjj;

pub const DecodeResult = enum(c_int) {
    SUCCESS = 0,
    NOT_FPNG = 1,
    INVALID_ARG = 2,
    FAILED_NOT_PNG = 3,
    FAILED_HEADER_CRC32 = 4,
    FAILED_INVALID_DIMENSIONS = 5,
    FAILED_DIMENSIONS_TOO_LARGE = 6,
    FAILED_CHUNK_PARSING = 7,
    FAILED_INVALID_IDAT = 8,
    FILE_OPEN_FAILED = 9,
    FILE_TOO_LARGE = 10,
    FILE_READ_FAILED = 11,
    FILE_SEEK_FAILED = 12,
};

extern fn _ZN4fpng13fpng_get_infoEPKvjRjS2_S2_(pImage: ?*const anyopaque, image_size: u32, width: *u32, height: *u32, channels_in_file: *u32) DecodeResult;
pub const fpng_get_info = _ZN4fpng13fpng_get_infoEPKvjRjS2_S2_;

extern fn _ZN4fpng18fpng_decode_memoryEPKvjRNSt3__16vectorIhNS2_9allocatorIhEEEERjS8_S8_j(pImage: ?*const anyopaque, image_size: u32, out: *cpp.Vector(u8), width: *u32, height: *u32, channels_in_file: *u32, desired_channels: u32) DecodeResult;
pub const fpng_decode_memory = _ZN4fpng18fpng_decode_memoryEPKvjRNSt3__16vectorIhNS2_9allocatorIhEEEERjS8_S8_j;

extern fn _ZN4fpng16fpng_decode_fileEPKcRNSt3__16vectorIhNS2_9allocatorIhEEEERjS8_S8_j(pFilename: [*c]const u8, out: *cpp.Vector(u8), width: *u32, height: *u32, channels_in_file: *u32, desired_channels: u32) DecodeResult;
pub const fpng_decode_file = _ZN4fpng16fpng_decode_fileEPKcRNSt3__16vectorIhNS2_9allocatorIhEEEERjS8_S8_j;
