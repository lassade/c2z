// auto generated by c2z
const std = @import("std");
//const cpp = @import("cpp");

pub const Bitfields = extern struct {
    bitfield_1: packed struct(u64) {
        bitfield1: u10, // 10 bits
        bitfield2: u10, // 20 bits
        bitfield3: u5, // 25 bits
        bitfield4: i5, // 30 bits
        bitfield5: u2, // 32 bits
        bitfield6: u2, // 34 bits
        /// Padding added by c2z
        _dummy_padding: u30,
    },
    bitfield_2: packed struct(u32) {
        bitfield7: i31, // 63 bits
        /// Padding added by c2z
        _dummy_padding: u1,
    },
    bitfield_3: packed struct(u64) {
        bitfield8: i30, // 30 bits
        /// Padding added by c2z
        _dummy_padding: u34,
    },
};