const std = @import("std");

pub const Vector2 = extern struct {
    x: f64 = 0.0,
    y: f64 = 0.0,

    extern fn _ZN7msdfgen7Vector2C1Ed(self: *Vector2, val: f64) void;
    pub inline fn init(val: f64) Vector2 {
        var self: Vector2 = undefined;
        _ZN7msdfgen7Vector2C1Ed(&self, val);
        return self;
    }

    extern fn _ZN7msdfgen7Vector2C1Edd(self: *Vector2, x: f64, y: f64) void;
    pub inline fn initXY(x: f64, y: f64) Vector2 {
        var self: Vector2 = undefined;
        _ZN7msdfgen7Vector2C1Edd(&self, x, y);
        return self;
    }

    extern fn _ZN7msdfgen7Vector25resetEv(self: *Vector2) void;
    pub const reset = _ZN7msdfgen7Vector25resetEv;

    extern fn _ZN7msdfgen7Vector23setEdd(self: *Vector2, x: f64, y: f64) void;
    pub const set = _ZN7msdfgen7Vector23setEdd;

    extern fn _ZNK7msdfgen7Vector26lengthEv(self: *const Vector2) f64;
    pub const length = _ZNK7msdfgen7Vector26lengthEv;

    extern fn _ZNK7msdfgen7Vector29directionEv(self: *const Vector2) f64;
    pub const direction = _ZNK7msdfgen7Vector29directionEv;

    extern fn _ZNK7msdfgen7Vector29normalizeEb(self: *const Vector2, allowZero: bool) Vector2;
    pub const normalize = _ZNK7msdfgen7Vector29normalizeEb;

    extern fn _ZNK7msdfgen7Vector213getOrthogonalEb(self: *const Vector2, polarity: bool) Vector2;
    pub const getOrthogonal = _ZNK7msdfgen7Vector213getOrthogonalEb;

    extern fn _ZNK7msdfgen7Vector214getOrthonormalEbb(self: *const Vector2, polarity: bool, allowZero: bool) Vector2;
    pub const getOrthonormal = _ZNK7msdfgen7Vector214getOrthonormalEbb;

    extern fn _ZNK7msdfgen7Vector27projectERKS0_b(self: *const Vector2, vector: *const Vector2, positive: bool) Vector2;
    pub const project = _ZNK7msdfgen7Vector27projectERKS0_b;

    extern fn _ZNK7msdfgen7Vector2ntEv(self: *const Vector2) bool;
    pub const not = _ZNK7msdfgen7Vector2ntEv;

    extern fn _ZNK7msdfgen7Vector2eqERKS0_(self: *const Vector2, other: *const Vector2) bool;
    pub const eql = _ZNK7msdfgen7Vector2eqERKS0_;

    extern fn _ZNK7msdfgen7Vector2neERKS0_(self: *const Vector2, other: *const Vector2) bool;
    pub const notEql = _ZNK7msdfgen7Vector2neERKS0_;

    // extern fn _ZNK7msdfgen7Vector2psEv(self: *const Vector2) Vector2;
    // pub const add = _ZNK7msdfgen7Vector2psEv;

    // extern fn _ZNK7msdfgen7Vector2ngEv(self: *const Vector2) Vector2;
    // pub const sub = _ZNK7msdfgen7Vector2ngEv;

    extern fn _ZNK7msdfgen7Vector2plERKS0_(self: *const Vector2, other: *const Vector2) Vector2;
    pub const add = _ZNK7msdfgen7Vector2plERKS0_;

    extern fn _ZNK7msdfgen7Vector2miERKS0_(self: *const Vector2, other: *const Vector2) Vector2;
    pub const sub = _ZNK7msdfgen7Vector2miERKS0_;

    extern fn _ZNK7msdfgen7Vector2mlERKS0_(self: *const Vector2, other: *const Vector2) Vector2;
    pub const mul = _ZNK7msdfgen7Vector2mlERKS0_;

    extern fn _ZNK7msdfgen7Vector2dvERKS0_(self: *const Vector2, other: *const Vector2) Vector2;
    pub const div = _ZNK7msdfgen7Vector2dvERKS0_;

    extern fn _ZNK7msdfgen7Vector2mlEd(self: *const Vector2, value: f64) Vector2;
    pub const mulScalar = _ZNK7msdfgen7Vector2mlEd;

    extern fn _ZNK7msdfgen7Vector2dvEd(self: *const Vector2, value: f64) Vector2;
    pub const divScalar = _ZNK7msdfgen7Vector2dvEd;

    extern fn _ZN7msdfgen7Vector2pLERKS0_(self: *Vector2, other: *const Vector2) *Vector2;
    pub const addInto = _ZN7msdfgen7Vector2pLERKS0_;

    extern fn _ZN7msdfgen7Vector2mIERKS0_(self: *Vector2, other: *const Vector2) *Vector2;
    pub const subInto = _ZN7msdfgen7Vector2mIERKS0_;

    extern fn _ZN7msdfgen7Vector2mLERKS0_(self: *Vector2, other: *const Vector2) *Vector2;
    pub const mulInto = _ZN7msdfgen7Vector2mLERKS0_;

    extern fn _ZN7msdfgen7Vector2dVERKS0_(self: *Vector2, other: *const Vector2) *Vector2;
    pub const divInto = _ZN7msdfgen7Vector2dVERKS0_;

    extern fn _ZN7msdfgen7Vector2mLEd(self: *Vector2, value: f64) *Vector2;
    pub const mulScalarInto = _ZN7msdfgen7Vector2mLEd;

    extern fn _ZN7msdfgen7Vector2dVEd(self: *Vector2, value: f64) *Vector2;
    pub const divScalarInto_ = _ZN7msdfgen7Vector2dVEd;
};
