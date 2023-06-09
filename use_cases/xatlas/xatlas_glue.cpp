// auto generated by c2z
#include "xatlas.h"

extern "C" const uint32_t *_1_xatlas_kImageChartIndexMask_() { return &::xatlas::kImageChartIndexMask; }
extern "C" const uint32_t *_1_xatlas_kImageHasChartIndexBit_() { return &::xatlas::kImageHasChartIndexBit; }
extern "C" const uint32_t *_1_xatlas_kImageIsBilinearBit_() { return &::xatlas::kImageIsBilinearBit; }
extern "C" const uint32_t *_1_xatlas_kImageIsPaddingBit_() { return &::xatlas::kImageIsPaddingBit; }
extern "C" Atlas * _1_xatlas_Create_() { return ::xatlas::Create(); }
extern "C" void _1_xatlas_Destroy_(Atlas * atlas) { ::xatlas::Destroy(atlas); }
extern "C" AddMeshError _1_xatlas_AddMesh_(Atlas * atlas, const MeshDecl & meshDecl, uint32_t meshCountHint) { return ::xatlas::AddMesh(atlas, meshDecl, meshCountHint); }
extern "C" void _1_xatlas_AddMeshJoin_(Atlas * atlas) { ::xatlas::AddMeshJoin(atlas); }
extern "C" AddMeshError _1_xatlas_AddUvMesh_(Atlas * atlas, const UvMeshDecl & decl) { return ::xatlas::AddUvMesh(atlas, decl); }
extern "C" void _1_xatlas_ComputeCharts_(Atlas * atlas, ChartOptions options) { ::xatlas::ComputeCharts(atlas, options); }
extern "C" void _1_xatlas_PackCharts_(Atlas * atlas, PackOptions packOptions) { ::xatlas::PackCharts(atlas, packOptions); }
extern "C" void _1_xatlas_Generate_(Atlas * atlas, ChartOptions chartOptions, PackOptions packOptions) { ::xatlas::Generate(atlas, chartOptions, packOptions); }
extern "C" void _1_xatlas_SetProgressCallback_(Atlas * atlas, ProgressFunc progressFunc, void * progressUserData) { ::xatlas::SetProgressCallback(atlas, progressFunc, progressUserData); }
extern "C" void _1_xatlas_SetAlloc_(ReallocFunc reallocFunc, FreeFunc freeFunc) { ::xatlas::SetAlloc(reallocFunc, freeFunc); }
extern "C" void _1_xatlas_SetPrint_(PrintFunc print, bool verbose) { ::xatlas::SetPrint(print, verbose); }
extern "C" const char * _1_xatlas_StringForEnum_(AddMeshError error) { return ::xatlas::StringForEnum(error); }
extern "C" const char * _2_xatlas_StringForEnum_(ProgressCategory category) { return ::xatlas::StringForEnum(category); }
