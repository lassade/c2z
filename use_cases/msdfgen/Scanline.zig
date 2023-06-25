const std = @import("std");
const cpp = @import("cpp");

pub const FillRule = extern struct {
    bits: c_int = 0,

    pub const FILL_NONZERO: FillRule = .{ .bits = 0 };
    pub const FILL_ODD: FillRule = .{ .bits = 1 };
    pub const FILL_POSITIVE: FillRule = .{ .bits = 2 };
    pub const FILL_NEGATIVE: FillRule = .{ .bits = 3 };

    // pub usingnamespace cpp.FlagsMixin(FillRule);
};

extern fn _ZN7msdfgen17interpretFillRuleEiNS_8FillRuleE(intersections: c_int, fillRule: FillRule) bool;
pub const interpretFillRule = _ZN7msdfgen17interpretFillRuleEiNS_8FillRuleE;

pub const Scanline = extern struct {
    pub const Intersection = extern struct {
        x: f64,
        direction: c_int,
    };

    intersections: cpp.Vector(Intersection),
    lastIndex: c_int,

    extern fn _ZN7msdfgen8Scanline7overlapERKS0_S2_ddNS_8FillRuleE(self: *Scanline, a: *const Scanline, b: *const Scanline, xFrom: f64, xTo: f64, fillRule: FillRule) f64;
    pub const overlap = _ZN7msdfgen8Scanline7overlapERKS0_S2_ddNS_8FillRuleE;

    extern fn _ZN7msdfgen8ScanlineC1Ev(self: *Scanline) void;
    pub inline fn init() Scanline {
        var self: Scanline = undefined;
        _ZN7msdfgen8ScanlineC1Ev(&self);
        return self;
    }

    extern fn _ZN7msdfgen8Scanline16setIntersectionsERKNSt3__16vectorINS0_12IntersectionENS1_9allocatorIS3_EEEE(self: *Scanline, intersections: *const cpp.Vector(Intersection)) void;
    pub const setIntersections = _ZN7msdfgen8Scanline16setIntersectionsERKNSt3__16vectorINS0_12IntersectionENS1_9allocatorIS3_EEEE;

    extern fn _ZNK7msdfgen8Scanline18countIntersectionsEd(self: *const Scanline, x: f64) c_int;
    pub const countIntersections = _ZNK7msdfgen8Scanline18countIntersectionsEd;

    extern fn _ZNK7msdfgen8Scanline16sumIntersectionsEd(self: *const Scanline, x: f64) c_int;
    pub const sumIntersections = _ZNK7msdfgen8Scanline16sumIntersectionsEd;

    extern fn _ZNK7msdfgen8Scanline6filledEdNS_8FillRuleE(self: *const Scanline, x: f64, fillRule: FillRule) bool;
    pub const filled = _ZNK7msdfgen8Scanline6filledEdNS_8FillRuleE;

    extern fn _ZN7msdfgen8Scanline10preprocessEv(self: *Scanline) void;
    pub const preprocess = _ZN7msdfgen8Scanline10preprocessEv;

    extern fn _ZNK7msdfgen8Scanline6moveToEd(self: *const Scanline, x: f64) c_int;
    pub const moveTo = _ZNK7msdfgen8Scanline6moveToEd;
};
