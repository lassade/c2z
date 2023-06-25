const std = @import("std");

/// The configuration of the MSDF error correction pass.
pub const ErrorCorrectionConfig = extern struct {
    /// Mode of operation.
    pub const Mode = extern struct {
        bits: c_int = 0,

        /// Skips error correction pass.
        pub const DISABLED: Mode = .{ .bits = 0 };
        /// Corrects all discontinuities of the distance field regardless if edges are adversely affected.
        pub const INDISCRIMINATE: Mode = .{ .bits = 1 };
        /// Corrects artifacts at edges and other discontinuous distances only if it does not affect edges or corners.
        pub const EDGE_PRIORITY: Mode = .{ .bits = 2 };
        /// Only corrects artifacts at edges.
        pub const EDGE_ONLY: Mode = .{ .bits = 3 };

        // pub usingnamespace cpp.FlagsMixin(Mode);
    };

    /// Configuration of whether to use an algorithm that computes the exact shape distance at the positions of suspected artifacts. This algorithm can be much slower.
    pub const DistanceCheckMode = extern struct {
        bits: c_int = 0,

        /// Never computes exact shape distance.
        pub const DO_NOT_CHECK_DISTANCE: DistanceCheckMode = .{ .bits = 0 };
        /// Only computes exact shape distance at edges. Provides a good balance between speed and precision.
        pub const CHECK_DISTANCE_AT_EDGE: DistanceCheckMode = .{ .bits = 1 };
        /// Computes and compares the exact shape distance for each suspected artifact.
        pub const ALWAYS_CHECK_DISTANCE: DistanceCheckMode = .{ .bits = 2 };

        // pub usingnamespace cpp.FlagsMixin(DistanceCheckMode);
    };

    mode: Mode,
    distanceCheckMode: DistanceCheckMode,
    /// The minimum ratio between the actual and maximum expected distance delta to be considered an error.
    minDeviationRatio: f64,
    /// The minimum ratio between the pre-correction distance error and the post-correction distance error. Has no effect for DO_NOT_CHECK_DISTANCE.
    minImproveRatio: f64,
    /// An optional buffer to avoid dynamic allocation. Must have at least as many bytes as the MSDF has pixels.
    buffer: [*c]u8,

    extern const _ZN7msdfgen21ErrorCorrectionConfig24defaultMinDeviationRatioE: f64;
    pub inline fn defaultMinDeviationRatio() f64 {
        return _ZN7msdfgen21ErrorCorrectionConfig24defaultMinDeviationRatioE;
    }

    extern const _ZN7msdfgen21ErrorCorrectionConfig22defaultMinImproveRatioE: f64;
    pub inline fn defaultMinImproveRatio() f64 {
        return _ZN7msdfgen21ErrorCorrectionConfig22defaultMinImproveRatioE;
    }

    extern fn _ZN7msdfgen21ErrorCorrectionConfigC1ENS0_4ModeENS0_17DistanceCheckModeEddPh(self: *ErrorCorrectionConfig, mode: Mode, distanceCheckMode: DistanceCheckMode, minDeviationRatio: f64, minImproveRatio: f64, buffer: [*c]u8) void;
    pub inline fn init(mode: Mode, distanceCheckMode: DistanceCheckMode, minDeviationRatio: f64, minImproveRatio: f64, buffer: [*c]u8) ErrorCorrectionConfig {
        var self: ErrorCorrectionConfig = undefined;
        _ZN7msdfgen21ErrorCorrectionConfigC1ENS0_4ModeENS0_17DistanceCheckModeEddPh(&self, mode, distanceCheckMode, minDeviationRatio, minImproveRatio, buffer);
        return self;
    }
};

/// The configuration of the distance field generator algorithm.
pub const GeneratorConfig = extern struct {
    /// Specifies whether to use the version of the algorithm that supports overlapping contours with the same winding. May be set to false to improve performance when no such contours are present.
    overlapSupport: bool,

    extern fn _ZN7msdfgen15GeneratorConfigC1Eb(self: *GeneratorConfig, overlapSupport: bool) void;
    pub inline fn init(overlapSupport: bool) GeneratorConfig {
        var self: GeneratorConfig = undefined;
        _ZN7msdfgen15GeneratorConfigC1Eb(&self, overlapSupport);
        return self;
    }
};

/// The configuration of the multi-channel distance field generator algorithm.
pub const MSDFGeneratorConfig = extern struct {
    base: GeneratorConfig,

    /// Configuration of the error correction pass.
    errorCorrection: ErrorCorrectionConfig,

    extern fn _ZN7msdfgen19MSDFGeneratorConfigC1Ev(self: *MSDFGeneratorConfig) void;
    pub inline fn init() MSDFGeneratorConfig {
        var self: MSDFGeneratorConfig = undefined;
        _ZN7msdfgen19MSDFGeneratorConfigC1Ev(&self);
        return self;
    }

    extern fn _ZN7msdfgen19MSDFGeneratorConfigC1EbRKNS_21ErrorCorrectionConfigE(self: *MSDFGeneratorConfig, overlapSupport: bool, errorCorrection: *const ErrorCorrectionConfig) void;
    pub inline fn init1(overlapSupport: bool, errorCorrection: *const ErrorCorrectionConfig) MSDFGeneratorConfig {
        var self: MSDFGeneratorConfig = undefined;
        _ZN7msdfgen19MSDFGeneratorConfigC1EbRKNS_21ErrorCorrectionConfigE(&self, overlapSupport, errorCorrection);
        return self;
    }
};
