pub const Color32 = extern union {
    mU32: c_uint,
    field0: extern struct {
        r: u8,
        g: u8,
        b: u8,
        a: u8,
    },
};

pub const ColorClass = extern struct {
    field0: extern union {
        mU32: c_uint,
        field0: extern struct {
            r: u8,
            g: u8,
            b: u8,
            a: u8,
        },
    },

    extern const _ZN10ColorClass6sBlackE: ColorClass;
    pub inline fn sBlack() ColorClass {
        return _ZN10ColorClass6sBlackE;
    }

    extern const _ZN10ColorClass6sWhiteE: ColorClass;
    pub inline fn sWhite() ColorClass {
        return _ZN10ColorClass6sWhiteE;
    }
};
