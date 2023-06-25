const std = @import("std");
const BitmapRef = @import("BitmapRef.zig").BitmapRef;
const Shape = @import("Shape.zig").Shape;
const Projection = @import("Projection.zig").Projection;
const GeneratorConfig = @import("generator-config.zig").GeneratorConfig;
const MSDFGeneratorConfig = @import("generator-config.zig").MSDFGeneratorConfig;

extern fn _ZN7msdfgen11generateSDFERKNS_9BitmapRefIfLi1EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_15GeneratorConfigE(output: *const BitmapRef(f32, 1), shape: *const Shape, projection: *const Projection, range: f64, config: *const GeneratorConfig) void;
/// Generates a conventional single-channel signed distance field.
pub const generateSDF = _ZN7msdfgen11generateSDFERKNS_9BitmapRefIfLi1EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_15GeneratorConfigE;

extern fn _ZN7msdfgen17generatePseudoSDFERKNS_9BitmapRefIfLi1EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_15GeneratorConfigE(output: *const BitmapRef(f32, 1), shape: *const Shape, projection: *const Projection, range: f64, config: *const GeneratorConfig) void;
/// Generates a single-channel signed pseudo-distance field.
pub const generatePseudoSDF = _ZN7msdfgen17generatePseudoSDFERKNS_9BitmapRefIfLi1EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_15GeneratorConfigE;

extern fn _ZN7msdfgen12generateMSDFERKNS_9BitmapRefIfLi3EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_19MSDFGeneratorConfigE(output: *const BitmapRef(f32, 3), shape: *const Shape, projection: *const Projection, range: f64, config: *const MSDFGeneratorConfig) void;
/// Generates a multi-channel signed distance field. Edge colors must be assigned first! (See edgeColoringSimple)
pub const generateMSDF = _ZN7msdfgen12generateMSDFERKNS_9BitmapRefIfLi3EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_19MSDFGeneratorConfigE;

extern fn _ZN7msdfgen13generateMTSDFERKNS_9BitmapRefIfLi4EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_19MSDFGeneratorConfigE(output: *const BitmapRef(f32, 4), shape: *const Shape, projection: *const Projection, range: f64, config: *const MSDFGeneratorConfig) void;
/// Generates a multi-channel signed distance field with true distance in the alpha channel. Edge colors must be assigned first.
pub const generateMTSDF = _ZN7msdfgen13generateMTSDFERKNS_9BitmapRefIfLi4EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_19MSDFGeneratorConfigE;
