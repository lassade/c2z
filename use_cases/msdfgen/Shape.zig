const std = @import("std");
const cpp = @import("cpp");

const Contour = @import("Contour.zig").Contour;
const Scanline = @import("Scanline.zig").Scanline;

pub const Shape = extern struct {
    pub const Bounds = extern struct {
        l: f64,
        b: f64,
        r: f64,
        t: f64,
    };

    contours: cpp.Vector(Contour),
    inverseYAxis: bool,

    extern fn _ZN7msdfgen5ShapeC1Ev(self: *Shape) void;
    pub inline fn init() Shape {
        var self: Shape = undefined;
        _ZN7msdfgen5ShapeC1Ev(&self);
        return self;
    }

    extern fn _ZN7msdfgen5Shape10addContourERKNS_7ContourE(self: *Shape, contour: *const Contour) void;
    pub const addContour = _ZN7msdfgen5Shape10addContourERKNS_7ContourE;

    extern fn _ZN7msdfgen5Shape10addContourEv(self: *Shape) *Contour;
    pub const addContour__Overload2 = _ZN7msdfgen5Shape10addContourEv;

    extern fn _ZN7msdfgen5Shape9normalizeEv(self: *Shape) void;
    pub const normalize = _ZN7msdfgen5Shape9normalizeEv;

    extern fn _ZNK7msdfgen5Shape8validateEv(self: *const Shape) bool;
    pub const validate = _ZNK7msdfgen5Shape8validateEv;

    extern fn _ZNK7msdfgen5Shape5boundERdS1_S1_S1_(self: *const Shape, l: *f64, b: *f64, r: *f64, t: *f64) void;
    pub const bound = _ZNK7msdfgen5Shape5boundERdS1_S1_S1_;

    extern fn _ZNK7msdfgen5Shape11boundMitersERdS1_S1_S1_ddi(self: *const Shape, l: *f64, b: *f64, r: *f64, t: *f64, border: f64, miterLimit: f64, polarity: c_int) void;
    pub const boundMiters = _ZNK7msdfgen5Shape11boundMitersERdS1_S1_S1_ddi;

    extern fn _ZNK7msdfgen5Shape9getBoundsEddi(self: *const Shape, border: f64, miterLimit: f64, polarity: c_int) Bounds;
    pub const getBounds = _ZNK7msdfgen5Shape9getBoundsEddi;

    extern fn _ZNK7msdfgen5Shape8scanlineERNS_8ScanlineEd(self: *const Shape, line: *Scanline, y: f64) void;
    pub const scanline = _ZNK7msdfgen5Shape8scanlineERNS_8ScanlineEd;

    extern fn _ZNK7msdfgen5Shape9edgeCountEv(self: *const Shape) c_int;
    pub const edgeCount = _ZNK7msdfgen5Shape9edgeCountEv;

    extern fn _ZN7msdfgen5Shape14orientContoursEv(self: *Shape) void;
    pub const orientContours = _ZN7msdfgen5Shape14orientContoursEv;
};
