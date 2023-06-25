const std = @import("std");

const Vector2 = @import("Vector2.zig").Vector2;
const Point2 = Vector2;

/// A transformation from shape coordinates to pixel coordinates.
pub const Projection = extern struct {
    scale: Vector2,
    translate: Vector2,

    extern fn _ZN7msdfgen10ProjectionC1Ev(self: *Projection) void;
    pub inline fn init() Projection {
        var self: Projection = undefined;
        _ZN7msdfgen10ProjectionC1Ev(&self);
        return self;
    }

    extern fn _ZN7msdfgen10ProjectionC1ERKNS_7Vector2ES3_(self: *Projection, scale: *const Vector2, translate: *const Vector2) void;
    pub inline fn init1(scale: *const Vector2, translate: *const Vector2) Projection {
        var self: Projection = undefined;
        _ZN7msdfgen10ProjectionC1ERKNS_7Vector2ES3_(&self, scale, translate);
        return self;
    }

    extern fn _ZNK7msdfgen10Projection7projectERKNS_7Vector2E(self: *const Projection, coord: *const Point2) Point2;
    /// Converts the shape coordinate to pixel coordinate.
    pub const project = _ZNK7msdfgen10Projection7projectERKNS_7Vector2E;

    extern fn _ZNK7msdfgen10Projection9unprojectERKNS_7Vector2E(self: *const Projection, coord: *const Point2) Point2;
    /// Converts the pixel coordinate to shape coordinate.
    pub const unproject = _ZNK7msdfgen10Projection9unprojectERKNS_7Vector2E;

    extern fn _ZNK7msdfgen10Projection13projectVectorERKNS_7Vector2E(self: *const Projection, vector: *const Vector2) Vector2;
    /// Converts the vector to pixel coordinate space.
    pub const projectVector = _ZNK7msdfgen10Projection13projectVectorERKNS_7Vector2E;

    extern fn _ZNK7msdfgen10Projection15unprojectVectorERKNS_7Vector2E(self: *const Projection, vector: *const Vector2) Vector2;
    /// Converts the vector from pixel coordinate space.
    pub const unprojectVector = _ZNK7msdfgen10Projection15unprojectVectorERKNS_7Vector2E;

    extern fn _ZNK7msdfgen10Projection8projectXEd(self: *const Projection, x: f64) f64;
    /// Converts the X-coordinate from shape to pixel coordinate space.
    pub const projectX = _ZNK7msdfgen10Projection8projectXEd;

    extern fn _ZNK7msdfgen10Projection8projectYEd(self: *const Projection, y: f64) f64;
    /// Converts the Y-coordinate from shape to pixel coordinate space.
    pub const projectY = _ZNK7msdfgen10Projection8projectYEd;

    extern fn _ZNK7msdfgen10Projection10unprojectXEd(self: *const Projection, x: f64) f64;
    /// Converts the X-coordinate from pixel to shape coordinate space.
    pub const unprojectX = _ZNK7msdfgen10Projection10unprojectXEd;

    extern fn _ZNK7msdfgen10Projection10unprojectYEd(self: *const Projection, y: f64) f64;
    /// Converts the Y-coordinate from pixel to shape coordinate space.
    pub const unprojectY = _ZNK7msdfgen10Projection10unprojectYEd;
};
