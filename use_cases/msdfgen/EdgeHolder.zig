const std = @import("std");

const EdgeSegment = @import("edge-segments.zig").EdgeSegment;
const EdgeColor = @import("EdgeColor.zig").EdgeColor;
const Vector2 = @import("Vector2.zig").Vector2;
const Point2 = Vector2;

pub const EdgeHolder = extern struct {
    edgeSegment: [*c]EdgeSegment,

    extern fn _ZN7msdfgen10EdgeHolder4swapERS0_S1_(self: *EdgeHolder, a: *EdgeHolder, b: *EdgeHolder) void;
    pub const swap = _ZN7msdfgen10EdgeHolder4swapERS0_S1_;

    extern fn _ZN7msdfgen10EdgeHolderC1Ev(self: *EdgeHolder) void;
    pub inline fn init() EdgeHolder {
        var self: EdgeHolder = undefined;
        _ZN7msdfgen10EdgeHolderC1Ev(&self);
        return self;
    }

    extern fn _ZN7msdfgen10EdgeHolderC1EPNS_11EdgeSegmentE(self: *EdgeHolder, segment: [*c]EdgeSegment) void;
    pub inline fn init1(segment: [*c]EdgeSegment) EdgeHolder {
        var self: EdgeHolder = undefined;
        _ZN7msdfgen10EdgeHolderC1EPNS_11EdgeSegmentE(&self, segment);
        return self;
    }

    extern fn _ZN7msdfgen10EdgeHolderC1ENS_7Vector2ES1_NS_9EdgeColorE(self: *EdgeHolder, p0: Point2, p1: Point2, edgeColor: EdgeColor) void;
    pub inline fn init2(p0: Point2, p1: Point2, edgeColor: EdgeColor) EdgeHolder {
        var self: EdgeHolder = undefined;
        _ZN7msdfgen10EdgeHolderC1ENS_7Vector2ES1_NS_9EdgeColorE(&self, p0, p1, edgeColor);
        return self;
    }

    extern fn _ZN7msdfgen10EdgeHolderC1ENS_7Vector2ES1_S1_NS_9EdgeColorE(self: *EdgeHolder, p0: Point2, p1: Point2, p2: Point2, edgeColor: EdgeColor) void;
    pub inline fn init3(p0: Point2, p1: Point2, p2: Point2, edgeColor: EdgeColor) EdgeHolder {
        var self: EdgeHolder = undefined;
        _ZN7msdfgen10EdgeHolderC1ENS_7Vector2ES1_S1_NS_9EdgeColorE(&self, p0, p1, p2, edgeColor);
        return self;
    }

    extern fn _ZN7msdfgen10EdgeHolderC1ENS_7Vector2ES1_S1_S1_NS_9EdgeColorE(self: *EdgeHolder, p0: Point2, p1: Point2, p2: Point2, p3: Point2, edgeColor: EdgeColor) void;
    pub inline fn init4(p0: Point2, p1: Point2, p2: Point2, p3: Point2, edgeColor: EdgeColor) EdgeHolder {
        var self: EdgeHolder = undefined;
        _ZN7msdfgen10EdgeHolderC1ENS_7Vector2ES1_S1_S1_NS_9EdgeColorE(&self, p0, p1, p2, p3, edgeColor);
        return self;
    }

    extern fn _ZN7msdfgen10EdgeHolderC1ERKS0_(self: *EdgeHolder, orig: *const EdgeHolder) void;
    pub inline fn init5(orig: *const EdgeHolder) EdgeHolder {
        var self: EdgeHolder = undefined;
        _ZN7msdfgen10EdgeHolderC1ERKS0_(&self, orig);
        return self;
    }

    extern fn _ZN7msdfgen10EdgeHolderD1Ev(self: *EdgeHolder) void;
    pub inline fn deinit(self: *EdgeHolder) void {
        self._ZN7msdfgen10EdgeHolderD1Ev();
    }

    extern fn _ZN7msdfgen10EdgeHolderaSERKS0_(self: *EdgeHolder, orig: *const EdgeHolder) *EdgeHolder;
    pub const copyFrom = _ZN7msdfgen10EdgeHolderaSERKS0_;
};
