const std = @import("std");
const cpp = @import("../../src/cpp.zig");

pub const fpng = struct {
    extern fn _ZN4fpng9fpng_initEv() void;
    pub const fpng_init = _ZN4fpng9fpng_initEv;

    extern fn _ZN4fpng23fpng_cpu_supports_sse41Ev() bool;
    pub const fpng_cpu_supports_sse41 = _ZN4fpng23fpng_cpu_supports_sse41Ev;

    extern fn _ZN4fpng10fpng_crc32EPKvyj(pData: ?*const anyopaque, size: usize, prev_crc32: u32) u32;
    pub const fpng_crc32 = _ZN4fpng10fpng_crc32EPKvyj;

    extern fn _ZN4fpng12fpng_adler32EPKvyj(pData: ?*const anyopaque, size: usize, adler: u32) u32;
    pub const fpng_adler32 = _ZN4fpng12fpng_adler32EPKvyj;

    extern fn _ZN4fpng27fpng_encode_image_to_memoryEPKvjjjRNSt3__16vectorIhNS2_9allocatorIhEEEEj(pImage: ?*const anyopaque, w: u32, h: u32, num_chans: u32, out_buf: *cpp.Vector(u8), flags: u32) bool;
    pub const fpng_encode_image_to_memory = _ZN4fpng27fpng_encode_image_to_memoryEPKvjjjRNSt3__16vectorIhNS2_9allocatorIhEEEEj;

    extern fn _ZN4fpng25fpng_encode_image_to_fileEPKcPKvjjjj(pFilename: [*c]const u8, pImage: ?*const anyopaque, w: u32, h: u32, num_chans: u32, flags: u32) bool;
    pub const fpng_encode_image_to_file = _ZN4fpng25fpng_encode_image_to_fileEPKcPKvjjjj;

    extern fn _ZN4fpng13fpng_get_infoEPKvjRjS2_S2_(pImage: ?*const anyopaque, image_size: u32, width: *u32, height: *u32, channels_in_file: *u32) c_int;
    pub const fpng_get_info = _ZN4fpng13fpng_get_infoEPKvjRjS2_S2_;

    extern fn _ZN4fpng18fpng_decode_memoryEPKvjRNSt3__16vectorIhNS2_9allocatorIhEEEERjS8_S8_j(pImage: ?*const anyopaque, image_size: u32, out: *cpp.Vector(u8), width: *u32, height: *u32, channels_in_file: *u32, desired_channels: u32) c_int;
    pub const fpng_decode_memory = _ZN4fpng18fpng_decode_memoryEPKvjRNSt3__16vectorIhNS2_9allocatorIhEEEERjS8_S8_j;

    extern fn _ZN4fpng16fpng_decode_fileEPKcRNSt3__16vectorIhNS2_9allocatorIhEEEERjS8_S8_j(pFilename: [*c]const u8, out: *cpp.Vector(u8), width: *u32, height: *u32, channels_in_file: *u32, desired_channels: u32) c_int;
    pub const fpng_decode_file = _ZN4fpng16fpng_decode_fileEPKcRNSt3__16vectorIhNS2_9allocatorIhEEEERjS8_S8_j;

    // unnamed nodes

    pub const UnnamedEnum0 = extern struct {
        bits: c_int = 0,

        pub const FPNG_DECODE_SUCCESS: UnnamedEnum0 = .{ .bits = @intCast(c_uint, 0) };
        pub const FPNG_DECODE_NOT_FPNG: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 1 };
        pub const FPNG_DECODE_INVALID_ARG: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 2 };
        pub const FPNG_DECODE_FAILED_NOT_PNG: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 3 };
        pub const FPNG_DECODE_FAILED_HEADER_CRC32: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 4 };
        pub const FPNG_DECODE_FAILED_INVALID_DIMENSIONS: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 5 };
        pub const FPNG_DECODE_FAILED_DIMENSIONS_TOO_LARGE: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 6 };
        pub const FPNG_DECODE_FAILED_CHUNK_PARSING: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 7 };
        pub const FPNG_DECODE_FAILED_INVALID_IDAT: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 8 };
        pub const FPNG_DECODE_FILE_OPEN_FAILED: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 9 };
        pub const FPNG_DECODE_FILE_TOO_LARGE: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 10 };
        pub const FPNG_DECODE_FILE_READ_FAILED: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 11 };
        pub const FPNG_DECODE_FILE_SEEK_FAILED: UnnamedEnum0 = .{ .bits = UnnamedEnum0.FPNG_DECODE_SUCCESS.bits + 12 };
    };

    pub const UnnamedEnum1 = extern struct {
        bits: c_int = 0,

        pub const FPNG_ENCODE_SLOWER: UnnamedEnum1 = .{ .bits = @intCast(c_uint, 1) };
        pub const FPNG_FORCE_UNCOMPRESSED: UnnamedEnum1 = .{ .bits = @intCast(c_uint, 2) };
    };
};
