const std = @import("std");

/// Represents a signed distance and alignment, which together can be compared to uniquely determine the closest edge segment.
pub const SignedDistance = extern struct {
    distance: f64,
    dot: f64,

    extern fn _ZN7msdfgen14SignedDistanceC1Ev(self: *SignedDistance) void;
    pub inline fn init() SignedDistance {
        var self: SignedDistance = undefined;
        _ZN7msdfgen14SignedDistanceC1Ev(&self);
        return self;
    }

    extern fn _ZN7msdfgen14SignedDistanceC1Edd(self: *SignedDistance, dist: f64, d: f64) void;
    pub inline fn init1(dist: f64, d: f64) SignedDistance {
        var self: SignedDistance = undefined;
        _ZN7msdfgen14SignedDistanceC1Edd(&self, dist, d);
        return self;
    }

    extern fn _ZN7msdfgenltENS_14SignedDistanceES0_(a: SignedDistance, b: SignedDistance) bool;
    pub const lessThan = _ZN7msdfgenltENS_14SignedDistanceES0_;

    extern fn _ZN7msdfgengtENS_14SignedDistanceES0_(a: SignedDistance, b: SignedDistance) bool;
    pub const greaterThan = _ZN7msdfgengtENS_14SignedDistanceES0_;

    extern fn _ZN7msdfgenleENS_14SignedDistanceES0_(a: SignedDistance, b: SignedDistance) bool;
    pub const lessEqThan = _ZN7msdfgenleENS_14SignedDistanceES0_;

    extern fn _ZN7msdfgengeENS_14SignedDistanceES0_(a: SignedDistance, b: SignedDistance) bool;
    pub const greaterEqThan = _ZN7msdfgengeENS_14SignedDistanceES0_;
};
