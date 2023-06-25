const std = @import("std");
const cpp = @import("cpp");

const EdgeHolder = @import("EdgeHolder.zig").EdgeHolder;

pub const Contour = extern struct {
    edges: cpp.Vector(EdgeHolder),

    extern fn _ZN7msdfgen7Contour7addEdgeERKNS_10EdgeHolderE(self: *Contour, edge: *const EdgeHolder) void;
    pub const addEdge = _ZN7msdfgen7Contour7addEdgeERKNS_10EdgeHolderE;

    extern fn _ZN7msdfgen7Contour7addEdgeEv(self: *Contour) *EdgeHolder;
    pub const addEdge__Overload2 = _ZN7msdfgen7Contour7addEdgeEv;

    extern fn _ZNK7msdfgen7Contour5boundERdS1_S1_S1_(self: *const Contour, l: *f64, b: *f64, r: *f64, t: *f64) void;
    pub const bound = _ZNK7msdfgen7Contour5boundERdS1_S1_S1_;

    extern fn _ZNK7msdfgen7Contour11boundMitersERdS1_S1_S1_ddi(self: *const Contour, l: *f64, b: *f64, r: *f64, t: *f64, border: f64, miterLimit: f64, polarity: c_int) void;
    pub const boundMiters = _ZNK7msdfgen7Contour11boundMitersERdS1_S1_S1_ddi;

    extern fn _ZNK7msdfgen7Contour7windingEv(self: *const Contour) c_int;
    pub const winding = _ZNK7msdfgen7Contour7windingEv;

    extern fn _ZN7msdfgen7Contour7reverseEv(self: *Contour) void;
    pub const reverse = _ZN7msdfgen7Contour7reverseEv;
};
