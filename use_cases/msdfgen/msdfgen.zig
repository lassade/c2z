const std = @import("std");
const BitmapRef = @import("BitmapRef.zig").BitmapRef;
const Shape = @import("Shape.zig").Shape;

extern fn _ZN7msdfgen11generateSDFERKNS_9BitmapRefIfLi1EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_15GeneratorConfigE(output: *const BitmapRef(f32, 1), shape: *const Shape, projection: *const Projection, range: f64, config: *const GeneratorConfig) void;
pub const generateSDF = _ZN7msdfgen11generateSDFERKNS_9BitmapRefIfLi1EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_15GeneratorConfigE;

extern fn _ZN7msdfgen17generatePseudoSDFERKNS_9BitmapRefIfLi1EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_15GeneratorConfigE(output: *const BitmapRef(f32, 1), shape: *const Shape, projection: *const Projection, range: f64, config: *const GeneratorConfig) void;
pub const generatePseudoSDF = _ZN7msdfgen17generatePseudoSDFERKNS_9BitmapRefIfLi1EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_15GeneratorConfigE;

extern fn _ZN7msdfgen12generateMSDFERKNS_9BitmapRefIfLi3EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_19MSDFGeneratorConfigE(output: *const BitmapRef(f32, 3), shape: *const Shape, projection: *const Projection, range: f64, config: *const MSDFGeneratorConfig) void;
pub const generateMSDF = _ZN7msdfgen12generateMSDFERKNS_9BitmapRefIfLi3EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_19MSDFGeneratorConfigE;

extern fn _ZN7msdfgen13generateMTSDFERKNS_9BitmapRefIfLi4EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_19MSDFGeneratorConfigE(output: *const BitmapRef(f32, 4), shape: *const Shape, projection: *const Projection, range: f64, config: *const MSDFGeneratorConfig) void;
pub const generateMTSDF = _ZN7msdfgen13generateMTSDFERKNS_9BitmapRefIfLi4EEERKNS_5ShapeERKNS_10ProjectionEdRKNS_19MSDFGeneratorConfigE;
