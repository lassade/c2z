const std = @import("std");

const EdgeColor = @import("EdgeColor.zig").EdgeColor;
const Vector2 = @import("Vector2.zig").Vector2;
const Point2 = Vector2;

pub const EdgeSegment = extern struct {
    vtable: *const anyopaque,

    color: EdgeColor,

    extern fn _ZN7msdfgen11EdgeSegmentC1ENS_9EdgeColorE(self: *EdgeSegment, edgeColor: EdgeColor) void;
    pub inline fn init(edgeColor: EdgeColor) EdgeSegment {
        var self: EdgeSegment = undefined;
        _ZN7msdfgen11EdgeSegmentC1ENS_9EdgeColorE(&self, edgeColor);
        return self;
    }

    extern fn _ZN7msdfgen11EdgeSegmentD1Ev(self: *EdgeSegment) void;
    pub inline fn deinit(self: *EdgeSegment) void {
        self._ZN7msdfgen11EdgeSegmentD1Ev();
    }

    extern fn _ZNK7msdfgen11EdgeSegment5cloneEv(self: *const EdgeSegment) [*c]EdgeSegment;
    pub const clone = _ZNK7msdfgen11EdgeSegment5cloneEv;

    extern fn _ZNK7msdfgen11EdgeSegment5pointEd(self: *const EdgeSegment, param: f64) Point2;
    pub const point = _ZNK7msdfgen11EdgeSegment5pointEd;

    extern fn _ZNK7msdfgen11EdgeSegment9directionEd(self: *const EdgeSegment, param: f64) Vector2;
    pub const direction = _ZNK7msdfgen11EdgeSegment9directionEd;

    extern fn _ZNK7msdfgen11EdgeSegment15directionChangeEd(self: *const EdgeSegment, param: f64) Vector2;
    pub const directionChange = _ZNK7msdfgen11EdgeSegment15directionChangeEd;

    extern fn _ZNK7msdfgen11EdgeSegment14signedDistanceENS_7Vector2ERd(self: *const EdgeSegment, origin: Point2, param: *f64) SignedDistance;
    pub const signedDistance = _ZNK7msdfgen11EdgeSegment14signedDistanceENS_7Vector2ERd;

    extern fn _ZNK7msdfgen11EdgeSegment24distanceToPseudoDistanceERNS_14SignedDistanceENS_7Vector2Ed(self: *const EdgeSegment, distance: *SignedDistance, origin: Point2, param: f64) void;
    pub const distanceToPseudoDistance = _ZNK7msdfgen11EdgeSegment24distanceToPseudoDistanceERNS_14SignedDistanceENS_7Vector2Ed;

    extern fn _ZNK7msdfgen11EdgeSegment21scanlineIntersectionsEPdPid(self: *const EdgeSegment, x: [*c]f64, dy: [*c]c_int, y: f64) c_int;
    pub const scanlineIntersections = _ZNK7msdfgen11EdgeSegment21scanlineIntersectionsEPdPid;

    extern fn _ZNK7msdfgen11EdgeSegment5boundERdS1_S1_S1_(self: *const EdgeSegment, l: *f64, b: *f64, r: *f64, t: *f64) void;
    pub const bound = _ZNK7msdfgen11EdgeSegment5boundERdS1_S1_S1_;

    extern fn _ZN7msdfgen11EdgeSegment7reverseEv(self: *EdgeSegment) void;
    pub const reverse = _ZN7msdfgen11EdgeSegment7reverseEv;

    extern fn _ZN7msdfgen11EdgeSegment14moveStartPointENS_7Vector2E(self: *EdgeSegment, to: Point2) void;
    pub const moveStartPoint = _ZN7msdfgen11EdgeSegment14moveStartPointENS_7Vector2E;

    extern fn _ZN7msdfgen11EdgeSegment12moveEndPointENS_7Vector2E(self: *EdgeSegment, to: Point2) void;
    pub const moveEndPoint = _ZN7msdfgen11EdgeSegment12moveEndPointENS_7Vector2E;

    extern fn _ZNK7msdfgen11EdgeSegment13splitInThirdsERPS0_S2_S2_(self: *const EdgeSegment, part1: *[*c]EdgeSegment, part2: *[*c]EdgeSegment, part3: *[*c]EdgeSegment) void;
    pub const splitInThirds = _ZNK7msdfgen11EdgeSegment13splitInThirdsERPS0_S2_S2_;
};

pub const LinearSegment = extern struct {
    base: EdgeSegment,

    p: [2]Point2,

    extern fn _ZN7msdfgen13LinearSegmentC1ENS_7Vector2ES1_NS_9EdgeColorE(self: *LinearSegment, p0: Point2, p1: Point2, edgeColor: EdgeColor) void;
    pub inline fn init(p0: Point2, p1: Point2, edgeColor: EdgeColor) LinearSegment {
        var self: LinearSegment = undefined;
        _ZN7msdfgen13LinearSegmentC1ENS_7Vector2ES1_NS_9EdgeColorE(&self, p0, p1, edgeColor);
        return self;
    }

    extern fn _ZNK7msdfgen13LinearSegment5cloneEv(self: *const LinearSegment) [*c]LinearSegment;
    pub const clone = _ZNK7msdfgen13LinearSegment5cloneEv;

    extern fn _ZNK7msdfgen13LinearSegment5pointEd(self: *const LinearSegment, param: f64) Point2;
    pub const point = _ZNK7msdfgen13LinearSegment5pointEd;

    extern fn _ZNK7msdfgen13LinearSegment9directionEd(self: *const LinearSegment, param: f64) Vector2;
    pub const direction = _ZNK7msdfgen13LinearSegment9directionEd;

    extern fn _ZNK7msdfgen13LinearSegment15directionChangeEd(self: *const LinearSegment, param: f64) Vector2;
    pub const directionChange = _ZNK7msdfgen13LinearSegment15directionChangeEd;

    extern fn _ZNK7msdfgen13LinearSegment6lengthEv(self: *const LinearSegment) f64;
    pub const length = _ZNK7msdfgen13LinearSegment6lengthEv;

    extern fn _ZNK7msdfgen13LinearSegment14signedDistanceENS_7Vector2ERd(self: *const LinearSegment, origin: Point2, param: *f64) SignedDistance;
    pub const signedDistance = _ZNK7msdfgen13LinearSegment14signedDistanceENS_7Vector2ERd;

    extern fn _ZNK7msdfgen13LinearSegment21scanlineIntersectionsEPdPid(self: *const LinearSegment, x: [*c]f64, dy: [*c]c_int, y: f64) c_int;
    pub const scanlineIntersections = _ZNK7msdfgen13LinearSegment21scanlineIntersectionsEPdPid;

    extern fn _ZNK7msdfgen13LinearSegment5boundERdS1_S1_S1_(self: *const LinearSegment, l: *f64, b: *f64, r: *f64, t: *f64) void;
    pub const bound = _ZNK7msdfgen13LinearSegment5boundERdS1_S1_S1_;

    extern fn _ZN7msdfgen13LinearSegment7reverseEv(self: *LinearSegment) void;
    pub const reverse = _ZN7msdfgen13LinearSegment7reverseEv;

    extern fn _ZN7msdfgen13LinearSegment14moveStartPointENS_7Vector2E(self: *LinearSegment, to: Point2) void;
    pub const moveStartPoint = _ZN7msdfgen13LinearSegment14moveStartPointENS_7Vector2E;

    extern fn _ZN7msdfgen13LinearSegment12moveEndPointENS_7Vector2E(self: *LinearSegment, to: Point2) void;
    pub const moveEndPoint = _ZN7msdfgen13LinearSegment12moveEndPointENS_7Vector2E;

    extern fn _ZNK7msdfgen13LinearSegment13splitInThirdsERPNS_11EdgeSegmentES3_S3_(self: *const LinearSegment, part1: *[*c]EdgeSegment, part2: *[*c]EdgeSegment, part3: *[*c]EdgeSegment) void;
    pub const splitInThirds = _ZNK7msdfgen13LinearSegment13splitInThirdsERPNS_11EdgeSegmentES3_S3_;
};

pub const QuadraticSegment = extern struct {
    base: EdgeSegment,

    p: [3]Point2,

    extern fn _ZN7msdfgen16QuadraticSegmentC1ENS_7Vector2ES1_S1_NS_9EdgeColorE(self: *QuadraticSegment, p0: Point2, p1: Point2, p2: Point2, edgeColor: EdgeColor) void;
    pub inline fn init(p0: Point2, p1: Point2, p2: Point2, edgeColor: EdgeColor) QuadraticSegment {
        var self: QuadraticSegment = undefined;
        _ZN7msdfgen16QuadraticSegmentC1ENS_7Vector2ES1_S1_NS_9EdgeColorE(&self, p0, p1, p2, edgeColor);
        return self;
    }

    extern fn _ZNK7msdfgen16QuadraticSegment5cloneEv(self: *const QuadraticSegment) [*c]QuadraticSegment;
    pub const clone = _ZNK7msdfgen16QuadraticSegment5cloneEv;

    extern fn _ZNK7msdfgen16QuadraticSegment5pointEd(self: *const QuadraticSegment, param: f64) Point2;
    pub const point = _ZNK7msdfgen16QuadraticSegment5pointEd;

    extern fn _ZNK7msdfgen16QuadraticSegment9directionEd(self: *const QuadraticSegment, param: f64) Vector2;
    pub const direction = _ZNK7msdfgen16QuadraticSegment9directionEd;

    extern fn _ZNK7msdfgen16QuadraticSegment15directionChangeEd(self: *const QuadraticSegment, param: f64) Vector2;
    pub const directionChange = _ZNK7msdfgen16QuadraticSegment15directionChangeEd;

    extern fn _ZNK7msdfgen16QuadraticSegment6lengthEv(self: *const QuadraticSegment) f64;
    pub const length = _ZNK7msdfgen16QuadraticSegment6lengthEv;

    extern fn _ZNK7msdfgen16QuadraticSegment14signedDistanceENS_7Vector2ERd(self: *const QuadraticSegment, origin: Point2, param: *f64) SignedDistance;
    pub const signedDistance = _ZNK7msdfgen16QuadraticSegment14signedDistanceENS_7Vector2ERd;

    extern fn _ZNK7msdfgen16QuadraticSegment21scanlineIntersectionsEPdPid(self: *const QuadraticSegment, x: [*c]f64, dy: [*c]c_int, y: f64) c_int;
    pub const scanlineIntersections = _ZNK7msdfgen16QuadraticSegment21scanlineIntersectionsEPdPid;

    extern fn _ZNK7msdfgen16QuadraticSegment5boundERdS1_S1_S1_(self: *const QuadraticSegment, l: *f64, b: *f64, r: *f64, t: *f64) void;
    pub const bound = _ZNK7msdfgen16QuadraticSegment5boundERdS1_S1_S1_;

    extern fn _ZN7msdfgen16QuadraticSegment7reverseEv(self: *QuadraticSegment) void;
    pub const reverse = _ZN7msdfgen16QuadraticSegment7reverseEv;

    extern fn _ZN7msdfgen16QuadraticSegment14moveStartPointENS_7Vector2E(self: *QuadraticSegment, to: Point2) void;
    pub const moveStartPoint = _ZN7msdfgen16QuadraticSegment14moveStartPointENS_7Vector2E;

    extern fn _ZN7msdfgen16QuadraticSegment12moveEndPointENS_7Vector2E(self: *QuadraticSegment, to: Point2) void;
    pub const moveEndPoint = _ZN7msdfgen16QuadraticSegment12moveEndPointENS_7Vector2E;

    extern fn _ZNK7msdfgen16QuadraticSegment13splitInThirdsERPNS_11EdgeSegmentES3_S3_(self: *const QuadraticSegment, part1: *[*c]EdgeSegment, part2: *[*c]EdgeSegment, part3: *[*c]EdgeSegment) void;
    pub const splitInThirds = _ZNK7msdfgen16QuadraticSegment13splitInThirdsERPNS_11EdgeSegmentES3_S3_;

    extern fn _ZNK7msdfgen16QuadraticSegment14convertToCubicEv(self: *const QuadraticSegment) [*c]EdgeSegment;
    pub const convertToCubic = _ZNK7msdfgen16QuadraticSegment14convertToCubicEv;
};

pub const CubicSegment = extern struct {
    base: EdgeSegment,

    p: [4]Point2,

    extern fn _ZN7msdfgen12CubicSegmentC1ENS_7Vector2ES1_S1_S1_NS_9EdgeColorE(self: *CubicSegment, p0: Point2, p1: Point2, p2: Point2, p3: Point2, edgeColor: EdgeColor) void;
    pub inline fn init(p0: Point2, p1: Point2, p2: Point2, p3: Point2, edgeColor: EdgeColor) CubicSegment {
        var self: CubicSegment = undefined;
        _ZN7msdfgen12CubicSegmentC1ENS_7Vector2ES1_S1_S1_NS_9EdgeColorE(&self, p0, p1, p2, p3, edgeColor);
        return self;
    }

    extern fn _ZNK7msdfgen12CubicSegment5cloneEv(self: *const CubicSegment) [*c]CubicSegment;
    pub const clone = _ZNK7msdfgen12CubicSegment5cloneEv;

    extern fn _ZNK7msdfgen12CubicSegment5pointEd(self: *const CubicSegment, param: f64) Point2;
    pub const point = _ZNK7msdfgen12CubicSegment5pointEd;

    extern fn _ZNK7msdfgen12CubicSegment9directionEd(self: *const CubicSegment, param: f64) Vector2;
    pub const direction = _ZNK7msdfgen12CubicSegment9directionEd;

    extern fn _ZNK7msdfgen12CubicSegment15directionChangeEd(self: *const CubicSegment, param: f64) Vector2;
    pub const directionChange = _ZNK7msdfgen12CubicSegment15directionChangeEd;

    extern fn _ZNK7msdfgen12CubicSegment14signedDistanceENS_7Vector2ERd(self: *const CubicSegment, origin: Point2, param: *f64) SignedDistance;
    pub const signedDistance = _ZNK7msdfgen12CubicSegment14signedDistanceENS_7Vector2ERd;

    extern fn _ZNK7msdfgen12CubicSegment21scanlineIntersectionsEPdPid(self: *const CubicSegment, x: [*c]f64, dy: [*c]c_int, y: f64) c_int;
    pub const scanlineIntersections = _ZNK7msdfgen12CubicSegment21scanlineIntersectionsEPdPid;

    extern fn _ZNK7msdfgen12CubicSegment5boundERdS1_S1_S1_(self: *const CubicSegment, l: *f64, b: *f64, r: *f64, t: *f64) void;
    pub const bound = _ZNK7msdfgen12CubicSegment5boundERdS1_S1_S1_;

    extern fn _ZN7msdfgen12CubicSegment7reverseEv(self: *CubicSegment) void;
    pub const reverse = _ZN7msdfgen12CubicSegment7reverseEv;

    extern fn _ZN7msdfgen12CubicSegment14moveStartPointENS_7Vector2E(self: *CubicSegment, to: Point2) void;
    pub const moveStartPoint = _ZN7msdfgen12CubicSegment14moveStartPointENS_7Vector2E;

    extern fn _ZN7msdfgen12CubicSegment12moveEndPointENS_7Vector2E(self: *CubicSegment, to: Point2) void;
    pub const moveEndPoint = _ZN7msdfgen12CubicSegment12moveEndPointENS_7Vector2E;

    extern fn _ZNK7msdfgen12CubicSegment13splitInThirdsERPNS_11EdgeSegmentES3_S3_(self: *const CubicSegment, part1: *[*c]EdgeSegment, part2: *[*c]EdgeSegment, part3: *[*c]EdgeSegment) void;
    pub const splitInThirds = _ZNK7msdfgen12CubicSegment13splitInThirdsERPNS_11EdgeSegmentES3_S3_;

    extern fn _ZN7msdfgen12CubicSegment10deconvergeEid(self: *CubicSegment, param: c_int, amount: f64) void;
    pub const deconverge = _ZN7msdfgen12CubicSegment10deconvergeEid;
};
