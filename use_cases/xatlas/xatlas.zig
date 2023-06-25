const std = @import("std");

pub const ChartType = extern struct {
    bits: c_int = 0,

    pub const Planar: ChartType = .{ .bits = 0 };
    pub const Ortho: ChartType = .{ .bits = 1 };
    pub const LSCM: ChartType = .{ .bits = 2 };
    pub const Piecewise: ChartType = .{ .bits = 3 };
    pub const Invalid: ChartType = .{ .bits = 4 };

    // pub usingnamespace cpp.FlagsMixin(ChartType);
};

pub const Chart = extern struct {
    faceArray: [*c]u32,
    atlasIndex: u32,
    faceCount: u32,
    type: ChartType,
    material: u32,
};

pub const Vertex = extern struct {
    atlasIndex: i32,
    chartIndex: i32,
    uv: [2]f32,
    xref: u32,
};

pub const Mesh = extern struct {
    chartArray: [*c]Chart,
    indexArray: [*c]u32,
    vertexArray: [*c]Vertex,
    chartCount: u32,
    indexCount: u32,
    vertexCount: u32,
};

extern const _ZN6xatlasL20kImageChartIndexMaskE: u32;
pub inline fn kImageChartIndexMask() u32 {
    return _ZN6xatlasL20kImageChartIndexMaskE;
}

extern const _ZN6xatlasL22kImageHasChartIndexBitE: u32;
pub inline fn kImageHasChartIndexBit() u32 {
    return _ZN6xatlasL22kImageHasChartIndexBitE;
}

extern const _ZN6xatlasL19kImageIsBilinearBitE: u32;
pub inline fn kImageIsBilinearBit() u32 {
    return _ZN6xatlasL19kImageIsBilinearBitE;
}

extern const _ZN6xatlasL18kImageIsPaddingBitE: u32;
pub inline fn kImageIsPaddingBit() u32 {
    return _ZN6xatlasL18kImageIsPaddingBitE;
}

pub const Atlas = extern struct {
    image: [*c]u32,
    meshes: [*c]Mesh,
    utilization: [*c]f32,
    width: u32,
    height: u32,
    atlasCount: u32,
    chartCount: u32,
    meshCount: u32,
    texelsPerUnit: f32,
};

extern fn _ZN6xatlas6CreateEv() [*c]Atlas;
pub const Create = _ZN6xatlas6CreateEv;

extern fn _ZN6xatlas7DestroyEPNS_5AtlasE(atlas: [*c]Atlas) void;
pub const Destroy = _ZN6xatlas7DestroyEPNS_5AtlasE;

pub const IndexFormat = extern struct {
    bits: c_int = 0,

    pub const UInt16: IndexFormat = .{ .bits = 0 };
    pub const UInt32: IndexFormat = .{ .bits = 1 };

    // pub usingnamespace cpp.FlagsMixin(IndexFormat);
};

pub const MeshDecl = extern struct {
    vertexPositionData: ?*const anyopaque,
    vertexNormalData: ?*const anyopaque,
    vertexUvData: ?*const anyopaque,
    indexData: ?*const anyopaque,
    faceIgnoreData: [*c]const bool,
    faceMaterialData: [*c]const u32,
    faceVertexCount: [*c]const u8,
    vertexCount: u32,
    vertexPositionStride: u32,
    vertexNormalStride: u32,
    vertexUvStride: u32,
    indexCount: u32,
    indexOffset: i32,
    faceCount: u32,
    indexFormat: IndexFormat,
    epsilon: f32,
};

pub const AddMeshError = extern struct {
    bits: c_int = 0,

    pub const Success: AddMeshError = .{ .bits = 0 };
    pub const Error: AddMeshError = .{ .bits = 1 };
    pub const IndexOutOfRange: AddMeshError = .{ .bits = 2 };
    pub const InvalidFaceVertexCount: AddMeshError = .{ .bits = 3 };
    pub const InvalidIndexCount: AddMeshError = .{ .bits = 4 };

    // pub usingnamespace cpp.FlagsMixin(AddMeshError);
};

extern fn _ZN6xatlas7AddMeshEPNS_5AtlasERKNS_8MeshDeclEj(atlas: [*c]Atlas, meshDecl: *const MeshDecl, meshCountHint: u32) AddMeshError;
pub const AddMesh = _ZN6xatlas7AddMeshEPNS_5AtlasERKNS_8MeshDeclEj;

extern fn _ZN6xatlas11AddMeshJoinEPNS_5AtlasE(atlas: [*c]Atlas) void;
pub const AddMeshJoin = _ZN6xatlas11AddMeshJoinEPNS_5AtlasE;

pub const UvMeshDecl = extern struct {
    vertexUvData: ?*const anyopaque,
    indexData: ?*const anyopaque,
    faceMaterialData: [*c]const u32,
    vertexCount: u32,
    vertexStride: u32,
    indexCount: u32,
    indexOffset: i32,
    indexFormat: IndexFormat,
};

extern fn _ZN6xatlas9AddUvMeshEPNS_5AtlasERKNS_10UvMeshDeclE(atlas: [*c]Atlas, decl: *const UvMeshDecl) AddMeshError;
pub const AddUvMesh = _ZN6xatlas9AddUvMeshEPNS_5AtlasERKNS_10UvMeshDeclE;

pub const ParameterizeFunc = ?*const fn ([*c]const f32, [*c]f32, u32, [*c]const u32, u32) callconv(.C) void;

pub const ChartOptions = extern struct {
    paramFunc: ParameterizeFunc,
    maxChartArea: f32,
    maxBoundaryLength: f32,
    normalDeviationWeight: f32,
    roundnessWeight: f32,
    straightnessWeight: f32,
    normalSeamWeight: f32,
    textureSeamWeight: f32,
    maxCost: f32,
    maxIterations: u32,
    useInputMeshUvs: bool,
    fixWinding: bool,
};

extern fn _ZN6xatlas13ComputeChartsEPNS_5AtlasENS_12ChartOptionsE(atlas: [*c]Atlas, options: ChartOptions) void;
pub const ComputeCharts = _ZN6xatlas13ComputeChartsEPNS_5AtlasENS_12ChartOptionsE;

pub const PackOptions = extern struct {
    maxChartSize: u32,
    padding: u32,
    texelsPerUnit: f32,
    resolution: u32,
    bilinear: bool,
    blockAlign: bool,
    bruteForce: bool,
    createImage: bool,
    rotateChartsToAxis: bool,
    rotateCharts: bool,
};

extern fn _ZN6xatlas10PackChartsEPNS_5AtlasENS_11PackOptionsE(atlas: [*c]Atlas, packOptions: PackOptions) void;
pub const PackCharts = _ZN6xatlas10PackChartsEPNS_5AtlasENS_11PackOptionsE;

extern fn _ZN6xatlas8GenerateEPNS_5AtlasENS_12ChartOptionsENS_11PackOptionsE(atlas: [*c]Atlas, chartOptions: ChartOptions, packOptions: PackOptions) void;
pub const Generate = _ZN6xatlas8GenerateEPNS_5AtlasENS_12ChartOptionsENS_11PackOptionsE;

pub const ProgressCategory = extern struct {
    bits: c_int = 0,

    pub const AddMesh: ProgressCategory = .{ .bits = 0 };
    pub const ComputeCharts: ProgressCategory = .{ .bits = 1 };
    pub const PackCharts: ProgressCategory = .{ .bits = 2 };
    pub const BuildOutputMeshes: ProgressCategory = .{ .bits = 3 };

    // pub usingnamespace cpp.FlagsMixin(ProgressCategory);
};

pub const ProgressFunc = ?*const fn (ProgressCategory, c_int, ?*anyopaque) callconv(.C) bool;

extern fn _ZN6xatlas19SetProgressCallbackEPNS_5AtlasEPFbNS_16ProgressCategoryEiPvES3_(atlas: [*c]Atlas, progressFunc: ProgressFunc, progressUserData: ?*anyopaque) void;
pub const SetProgressCallback = _ZN6xatlas19SetProgressCallbackEPNS_5AtlasEPFbNS_16ProgressCategoryEiPvES3_;

pub const ReallocFunc = ?*const fn (?*anyopaque, usize) callconv(.C) ?*anyopaque;

pub const FreeFunc = ?*const fn (?*anyopaque) callconv(.C) void;

extern fn _ZN6xatlas8SetAllocEPFPvS0_yEPFvS0_E(reallocFunc: ReallocFunc, freeFunc: FreeFunc) void;
pub const SetAlloc = _ZN6xatlas8SetAllocEPFPvS0_yEPFvS0_E;

pub const PrintFunc = ?*const fn ([*c]const u8, ...) callconv(.C) c_int;

extern fn _ZN6xatlas8SetPrintEPFiPKczEb(print: PrintFunc, verbose: bool) void;
pub const SetPrint = _ZN6xatlas8SetPrintEPFiPKczEb;

extern fn _ZN6xatlas13StringForEnumENS_12AddMeshErrorE(mesh_error: AddMeshError) [*c]const u8;
pub const StringForEnum = _ZN6xatlas13StringForEnumENS_12AddMeshErrorE;

extern fn _ZN6xatlas13StringForEnumENS_16ProgressCategoryE(category: ProgressCategory) [*c]const u8;
pub const StringForEnum__Overload2 = _ZN6xatlas13StringForEnumENS_16ProgressCategoryE;
