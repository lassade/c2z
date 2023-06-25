const std = @import("std");

pub extern fn ImAssert(_: bool) void;
pub const ImGuiCol = c_int;

pub const ImGuiCond = c_int;

pub const ImGuiDataType = c_int;

pub const ImGuiDir = c_int;

pub const ImGuiMouseButton = c_int;

pub const ImGuiMouseCursor = c_int;

pub const ImGuiSortDirection = c_int;

pub const ImGuiStyleVar = c_int;

pub const ImGuiTableBgTarget = c_int;

pub const ImDrawFlags = c_int;

pub const ImDrawListFlags = c_int;

pub const ImFontAtlasFlags = c_int;

pub const ImGuiBackendFlags = c_int;

pub const ImGuiButtonFlags = c_int;

pub const ImGuiColorEditFlags = c_int;

pub const ImGuiConfigFlags = c_int;

pub const ImGuiComboFlags = c_int;

pub const ImGuiDockNodeFlags = c_int;

pub const ImGuiDragDropFlags = c_int;

pub const ImGuiFocusedFlags = c_int;

pub const ImGuiHoveredFlags = c_int;

pub const ImGuiInputTextFlags = c_int;

pub const ImGuiKeyChord = c_int;

pub const ImGuiPopupFlags = c_int;

pub const ImGuiSelectableFlags = c_int;

pub const ImGuiSliderFlags = c_int;

pub const ImGuiTabBarFlags = c_int;

pub const ImGuiTabItemFlags = c_int;

pub const ImGuiTableFlags = c_int;

pub const ImGuiTableColumnFlags = c_int;

pub const ImGuiTableRowFlags = c_int;

pub const ImGuiTreeNodeFlags = c_int;

pub const ImGuiViewportFlags = c_int;

pub const ImGuiWindowFlags = c_int;

pub const ImTextureID = ?*anyopaque;

pub const ImDrawIdx = c_ushort;

pub const ImGuiID = c_uint;

pub const ImS8 = i8;

pub const ImU8 = u8;

pub const ImS16 = c_short;

pub const ImU16 = c_ushort;

pub const ImS32 = c_int;

pub const ImU32 = c_uint;

pub const ImS64 = c_longlong;

pub const ImU64 = c_ulonglong;

pub const ImWchar16 = c_ushort;

pub const ImWchar32 = c_uint;

pub const ImWchar = ImWchar16;

pub const ImGuiInputTextCallback = ?*const fn ([*c]ImGuiInputTextCallbackData) callconv(.C) c_int;

pub const ImGuiSizeCallback = ?*const fn ([*c]ImGuiSizeCallbackData) callconv(.C) void;

pub const ImGuiMemAllocFunc = ?*const fn (usize, ?*anyopaque) callconv(.C) ?*anyopaque;

pub const ImGuiMemFreeFunc = ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void;

pub const ImVec2 = extern struct {
    x: f32,
    y: f32,

    pub fn getPtr(self: *ImVec2, idx: usize) *f32 {
        ImAssert(idx == @intCast(usize, 0) or idx == @intCast(usize, 1));
        return (@ptrCast([*c]f32, @bitCast(?*anyopaque, @ptrCast([*c]u8, self))))[idx];
    }
    pub fn get(self: *const ImVec2, idx: usize) f32 {
        ImAssert(idx == @intCast(usize, 0) or idx == @intCast(usize, 1));
        return (@ptrCast([*c]const f32, @bitCast(?*const anyopaque, @ptrCast([*c]const u8, self))))[idx];
    }
};

pub const ImVec4 = extern struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,
};

extern fn _ZN5ImGui13CreateContextEP11ImFontAtlas(shared_font_atlas: [*c]ImFontAtlas) ?*ImGuiContext;
pub const CreateContext = _ZN5ImGui13CreateContextEP11ImFontAtlas;

extern fn _ZN5ImGui14DestroyContextEP12ImGuiContext(ctx: ?*ImGuiContext) void;
pub const DestroyContext = _ZN5ImGui14DestroyContextEP12ImGuiContext;

extern fn _ZN5ImGui17GetCurrentContextEv() ?*ImGuiContext;
pub const GetCurrentContext = _ZN5ImGui17GetCurrentContextEv;

extern fn _ZN5ImGui17SetCurrentContextEP12ImGuiContext(ctx: ?*ImGuiContext) void;
pub const SetCurrentContext = _ZN5ImGui17SetCurrentContextEP12ImGuiContext;

extern fn _ZN5ImGui5GetIOEv() *ImGuiIO;
pub const GetIO = _ZN5ImGui5GetIOEv;

extern fn _ZN5ImGui8GetStyleEv() *ImGuiStyle;
pub const GetStyle = _ZN5ImGui8GetStyleEv;

extern fn _ZN5ImGui8NewFrameEv() void;
pub const NewFrame = _ZN5ImGui8NewFrameEv;

extern fn _ZN5ImGui8EndFrameEv() void;
pub const EndFrame = _ZN5ImGui8EndFrameEv;

extern fn _ZN5ImGui6RenderEv() void;
pub const Render = _ZN5ImGui6RenderEv;

extern fn _ZN5ImGui11GetDrawDataEv() [*c]ImDrawData;
pub const GetDrawData = _ZN5ImGui11GetDrawDataEv;

extern fn _ZN5ImGui14ShowDemoWindowEPb(p_open: [*c]bool) void;
pub const ShowDemoWindow = _ZN5ImGui14ShowDemoWindowEPb;

extern fn _ZN5ImGui17ShowMetricsWindowEPb(p_open: [*c]bool) void;
pub const ShowMetricsWindow = _ZN5ImGui17ShowMetricsWindowEPb;

extern fn _ZN5ImGui18ShowDebugLogWindowEPb(p_open: [*c]bool) void;
pub const ShowDebugLogWindow = _ZN5ImGui18ShowDebugLogWindowEPb;

extern fn _ZN5ImGui19ShowStackToolWindowEPb(p_open: [*c]bool) void;
pub const ShowStackToolWindow = _ZN5ImGui19ShowStackToolWindowEPb;

extern fn _ZN5ImGui15ShowAboutWindowEPb(p_open: [*c]bool) void;
pub const ShowAboutWindow = _ZN5ImGui15ShowAboutWindowEPb;

extern fn _ZN5ImGui15ShowStyleEditorEP10ImGuiStyle(ref: [*c]ImGuiStyle) void;
pub const ShowStyleEditor = _ZN5ImGui15ShowStyleEditorEP10ImGuiStyle;

extern fn _ZN5ImGui17ShowStyleSelectorEPKc(label: [*c]const u8) bool;
pub const ShowStyleSelector = _ZN5ImGui17ShowStyleSelectorEPKc;

extern fn _ZN5ImGui16ShowFontSelectorEPKc(label: [*c]const u8) void;
pub const ShowFontSelector = _ZN5ImGui16ShowFontSelectorEPKc;

extern fn _ZN5ImGui13ShowUserGuideEv() void;
pub const ShowUserGuide = _ZN5ImGui13ShowUserGuideEv;

extern fn _ZN5ImGui10GetVersionEv() [*c]const u8;
pub const GetVersion = _ZN5ImGui10GetVersionEv;

extern fn _ZN5ImGui15StyleColorsDarkEP10ImGuiStyle(dst: [*c]ImGuiStyle) void;
pub const StyleColorsDark = _ZN5ImGui15StyleColorsDarkEP10ImGuiStyle;

extern fn _ZN5ImGui16StyleColorsLightEP10ImGuiStyle(dst: [*c]ImGuiStyle) void;
pub const StyleColorsLight = _ZN5ImGui16StyleColorsLightEP10ImGuiStyle;

extern fn _ZN5ImGui18StyleColorsClassicEP10ImGuiStyle(dst: [*c]ImGuiStyle) void;
pub const StyleColorsClassic = _ZN5ImGui18StyleColorsClassicEP10ImGuiStyle;

extern fn _ZN5ImGui5BeginEPKcPbi(name: [*c]const u8, p_open: [*c]bool, flags: ImGuiWindowFlags) bool;
pub const Begin = _ZN5ImGui5BeginEPKcPbi;

extern fn _ZN5ImGui3EndEv() void;
pub const End = _ZN5ImGui3EndEv;

extern fn _ZN5ImGui10BeginChildEPKcRK6ImVec2bi(str_id: [*c]const u8, size: *const ImVec2, border: bool, flags: ImGuiWindowFlags) bool;
pub const BeginChild = _ZN5ImGui10BeginChildEPKcRK6ImVec2bi;

extern fn _ZN5ImGui10BeginChildEjRK6ImVec2bi(id: ImGuiID, size: *const ImVec2, border: bool, flags: ImGuiWindowFlags) bool;
pub const BeginChild__Overload2 = _ZN5ImGui10BeginChildEjRK6ImVec2bi;

extern fn _ZN5ImGui8EndChildEv() void;
pub const EndChild = _ZN5ImGui8EndChildEv;

extern fn _ZN5ImGui17IsWindowAppearingEv() bool;
pub const IsWindowAppearing = _ZN5ImGui17IsWindowAppearingEv;

extern fn _ZN5ImGui17IsWindowCollapsedEv() bool;
pub const IsWindowCollapsed = _ZN5ImGui17IsWindowCollapsedEv;

extern fn _ZN5ImGui15IsWindowFocusedEi(flags: ImGuiFocusedFlags) bool;
pub const IsWindowFocused = _ZN5ImGui15IsWindowFocusedEi;

extern fn _ZN5ImGui15IsWindowHoveredEi(flags: ImGuiHoveredFlags) bool;
pub const IsWindowHovered = _ZN5ImGui15IsWindowHoveredEi;

extern fn _ZN5ImGui17GetWindowDrawListEv() [*c]ImDrawList;
pub const GetWindowDrawList = _ZN5ImGui17GetWindowDrawListEv;

extern fn _ZN5ImGui17GetWindowDpiScaleEv() f32;
pub const GetWindowDpiScale = _ZN5ImGui17GetWindowDpiScaleEv;

extern fn _ZN5ImGui12GetWindowPosEv() ImVec2;
pub const GetWindowPos = _ZN5ImGui12GetWindowPosEv;

extern fn _ZN5ImGui13GetWindowSizeEv() ImVec2;
pub const GetWindowSize = _ZN5ImGui13GetWindowSizeEv;

extern fn _ZN5ImGui14GetWindowWidthEv() f32;
pub const GetWindowWidth = _ZN5ImGui14GetWindowWidthEv;

extern fn _ZN5ImGui15GetWindowHeightEv() f32;
pub const GetWindowHeight = _ZN5ImGui15GetWindowHeightEv;

extern fn _ZN5ImGui17GetWindowViewportEv() [*c]ImGuiViewport;
pub const GetWindowViewport = _ZN5ImGui17GetWindowViewportEv;

extern fn _ZN5ImGui16SetNextWindowPosERK6ImVec2iS2_(pos: *const ImVec2, cond: ImGuiCond, pivot: *const ImVec2) void;
pub const SetNextWindowPos = _ZN5ImGui16SetNextWindowPosERK6ImVec2iS2_;

extern fn _ZN5ImGui17SetNextWindowSizeERK6ImVec2i(size: *const ImVec2, cond: ImGuiCond) void;
pub const SetNextWindowSize = _ZN5ImGui17SetNextWindowSizeERK6ImVec2i;

extern fn _ZN5ImGui28SetNextWindowSizeConstraintsERK6ImVec2S2_PFvP21ImGuiSizeCallbackDataEPv(size_min: *const ImVec2, size_max: *const ImVec2, custom_callback: ImGuiSizeCallback, custom_callback_data: ?*anyopaque) void;
pub const SetNextWindowSizeConstraints = _ZN5ImGui28SetNextWindowSizeConstraintsERK6ImVec2S2_PFvP21ImGuiSizeCallbackDataEPv;

extern fn _ZN5ImGui24SetNextWindowContentSizeERK6ImVec2(size: *const ImVec2) void;
pub const SetNextWindowContentSize = _ZN5ImGui24SetNextWindowContentSizeERK6ImVec2;

extern fn _ZN5ImGui22SetNextWindowCollapsedEbi(collapsed: bool, cond: ImGuiCond) void;
pub const SetNextWindowCollapsed = _ZN5ImGui22SetNextWindowCollapsedEbi;

extern fn _ZN5ImGui18SetNextWindowFocusEv() void;
pub const SetNextWindowFocus = _ZN5ImGui18SetNextWindowFocusEv;

extern fn _ZN5ImGui19SetNextWindowScrollERK6ImVec2(scroll: *const ImVec2) void;
pub const SetNextWindowScroll = _ZN5ImGui19SetNextWindowScrollERK6ImVec2;

extern fn _ZN5ImGui20SetNextWindowBgAlphaEf(alpha: f32) void;
pub const SetNextWindowBgAlpha = _ZN5ImGui20SetNextWindowBgAlphaEf;

extern fn _ZN5ImGui21SetNextWindowViewportEj(viewport_id: ImGuiID) void;
pub const SetNextWindowViewport = _ZN5ImGui21SetNextWindowViewportEj;

extern fn _ZN5ImGui12SetWindowPosERK6ImVec2i(pos: *const ImVec2, cond: ImGuiCond) void;
pub const SetWindowPos = _ZN5ImGui12SetWindowPosERK6ImVec2i;

extern fn _ZN5ImGui13SetWindowSizeERK6ImVec2i(size: *const ImVec2, cond: ImGuiCond) void;
pub const SetWindowSize = _ZN5ImGui13SetWindowSizeERK6ImVec2i;

extern fn _ZN5ImGui18SetWindowCollapsedEbi(collapsed: bool, cond: ImGuiCond) void;
pub const SetWindowCollapsed = _ZN5ImGui18SetWindowCollapsedEbi;

extern fn _ZN5ImGui14SetWindowFocusEv() void;
pub const SetWindowFocus = _ZN5ImGui14SetWindowFocusEv;

extern fn _ZN5ImGui18SetWindowFontScaleEf(scale: f32) void;
pub const SetWindowFontScale = _ZN5ImGui18SetWindowFontScaleEf;

extern fn _ZN5ImGui12SetWindowPosEPKcRK6ImVec2i(name: [*c]const u8, pos: *const ImVec2, cond: ImGuiCond) void;
pub const SetWindowPos__Overload2 = _ZN5ImGui12SetWindowPosEPKcRK6ImVec2i;

extern fn _ZN5ImGui13SetWindowSizeEPKcRK6ImVec2i(name: [*c]const u8, size: *const ImVec2, cond: ImGuiCond) void;
pub const SetWindowSize__Overload2 = _ZN5ImGui13SetWindowSizeEPKcRK6ImVec2i;

extern fn _ZN5ImGui18SetWindowCollapsedEPKcbi(name: [*c]const u8, collapsed: bool, cond: ImGuiCond) void;
pub const SetWindowCollapsed__Overload2 = _ZN5ImGui18SetWindowCollapsedEPKcbi;

extern fn _ZN5ImGui14SetWindowFocusEPKc(name: [*c]const u8) void;
pub const SetWindowFocus__Overload2 = _ZN5ImGui14SetWindowFocusEPKc;

extern fn _ZN5ImGui21GetContentRegionAvailEv() ImVec2;
pub const GetContentRegionAvail = _ZN5ImGui21GetContentRegionAvailEv;

extern fn _ZN5ImGui19GetContentRegionMaxEv() ImVec2;
pub const GetContentRegionMax = _ZN5ImGui19GetContentRegionMaxEv;

extern fn _ZN5ImGui25GetWindowContentRegionMinEv() ImVec2;
pub const GetWindowContentRegionMin = _ZN5ImGui25GetWindowContentRegionMinEv;

extern fn _ZN5ImGui25GetWindowContentRegionMaxEv() ImVec2;
pub const GetWindowContentRegionMax = _ZN5ImGui25GetWindowContentRegionMaxEv;

extern fn _ZN5ImGui10GetScrollXEv() f32;
pub const GetScrollX = _ZN5ImGui10GetScrollXEv;

extern fn _ZN5ImGui10GetScrollYEv() f32;
pub const GetScrollY = _ZN5ImGui10GetScrollYEv;

extern fn _ZN5ImGui10SetScrollXEf(scroll_x: f32) void;
pub const SetScrollX = _ZN5ImGui10SetScrollXEf;

extern fn _ZN5ImGui10SetScrollYEf(scroll_y: f32) void;
pub const SetScrollY = _ZN5ImGui10SetScrollYEf;

extern fn _ZN5ImGui13GetScrollMaxXEv() f32;
pub const GetScrollMaxX = _ZN5ImGui13GetScrollMaxXEv;

extern fn _ZN5ImGui13GetScrollMaxYEv() f32;
pub const GetScrollMaxY = _ZN5ImGui13GetScrollMaxYEv;

extern fn _ZN5ImGui14SetScrollHereXEf(center_x_ratio: f32) void;
pub const SetScrollHereX = _ZN5ImGui14SetScrollHereXEf;

extern fn _ZN5ImGui14SetScrollHereYEf(center_y_ratio: f32) void;
pub const SetScrollHereY = _ZN5ImGui14SetScrollHereYEf;

extern fn _ZN5ImGui17SetScrollFromPosXEff(local_x: f32, center_x_ratio: f32) void;
pub const SetScrollFromPosX = _ZN5ImGui17SetScrollFromPosXEff;

extern fn _ZN5ImGui17SetScrollFromPosYEff(local_y: f32, center_y_ratio: f32) void;
pub const SetScrollFromPosY = _ZN5ImGui17SetScrollFromPosYEff;

extern fn _ZN5ImGui8PushFontEP6ImFont(font: [*c]ImFont) void;
pub const PushFont = _ZN5ImGui8PushFontEP6ImFont;

extern fn _ZN5ImGui7PopFontEv() void;
pub const PopFont = _ZN5ImGui7PopFontEv;

extern fn _ZN5ImGui14PushStyleColorEij(idx: ImGuiCol, col: ImU32) void;
pub const PushStyleColor = _ZN5ImGui14PushStyleColorEij;

extern fn _ZN5ImGui14PushStyleColorEiRK6ImVec4(idx: ImGuiCol, col: *const ImVec4) void;
pub const PushStyleColor__Overload2 = _ZN5ImGui14PushStyleColorEiRK6ImVec4;

extern fn _ZN5ImGui13PopStyleColorEi(count: c_int) void;
pub const PopStyleColor = _ZN5ImGui13PopStyleColorEi;

extern fn _ZN5ImGui12PushStyleVarEif(idx: ImGuiStyleVar, val: f32) void;
pub const PushStyleVar = _ZN5ImGui12PushStyleVarEif;

extern fn _ZN5ImGui12PushStyleVarEiRK6ImVec2(idx: ImGuiStyleVar, val: *const ImVec2) void;
pub const PushStyleVar__Overload2 = _ZN5ImGui12PushStyleVarEiRK6ImVec2;

extern fn _ZN5ImGui11PopStyleVarEi(count: c_int) void;
pub const PopStyleVar = _ZN5ImGui11PopStyleVarEi;

extern fn _ZN5ImGui11PushTabStopEb(tab_stop: bool) void;
pub const PushTabStop = _ZN5ImGui11PushTabStopEb;

extern fn _ZN5ImGui10PopTabStopEv() void;
pub const PopTabStop = _ZN5ImGui10PopTabStopEv;

extern fn _ZN5ImGui16PushButtonRepeatEb(repeat: bool) void;
pub const PushButtonRepeat = _ZN5ImGui16PushButtonRepeatEb;

extern fn _ZN5ImGui15PopButtonRepeatEv() void;
pub const PopButtonRepeat = _ZN5ImGui15PopButtonRepeatEv;

extern fn _ZN5ImGui13PushItemWidthEf(item_width: f32) void;
pub const PushItemWidth = _ZN5ImGui13PushItemWidthEf;

extern fn _ZN5ImGui12PopItemWidthEv() void;
pub const PopItemWidth = _ZN5ImGui12PopItemWidthEv;

extern fn _ZN5ImGui16SetNextItemWidthEf(item_width: f32) void;
pub const SetNextItemWidth = _ZN5ImGui16SetNextItemWidthEf;

extern fn _ZN5ImGui13CalcItemWidthEv() f32;
pub const CalcItemWidth = _ZN5ImGui13CalcItemWidthEv;

extern fn _ZN5ImGui15PushTextWrapPosEf(wrap_local_pos_x: f32) void;
pub const PushTextWrapPos = _ZN5ImGui15PushTextWrapPosEf;

extern fn _ZN5ImGui14PopTextWrapPosEv() void;
pub const PopTextWrapPos = _ZN5ImGui14PopTextWrapPosEv;

extern fn _ZN5ImGui7GetFontEv() [*c]ImFont;
pub const GetFont = _ZN5ImGui7GetFontEv;

extern fn _ZN5ImGui11GetFontSizeEv() f32;
pub const GetFontSize = _ZN5ImGui11GetFontSizeEv;

extern fn _ZN5ImGui22GetFontTexUvWhitePixelEv() ImVec2;
pub const GetFontTexUvWhitePixel = _ZN5ImGui22GetFontTexUvWhitePixelEv;

extern fn _ZN5ImGui11GetColorU32Eif(idx: ImGuiCol, alpha_mul: f32) ImU32;
pub const GetColorU32 = _ZN5ImGui11GetColorU32Eif;

extern fn _ZN5ImGui11GetColorU32ERK6ImVec4(col: *const ImVec4) ImU32;
pub const GetColorU32__Overload2 = _ZN5ImGui11GetColorU32ERK6ImVec4;

extern fn _ZN5ImGui11GetColorU32Ej(col: ImU32) ImU32;
pub const GetColorU32__Overload3 = _ZN5ImGui11GetColorU32Ej;

extern fn _ZN5ImGui17GetStyleColorVec4Ei(idx: ImGuiCol) *const ImVec4;
pub const GetStyleColorVec4 = _ZN5ImGui17GetStyleColorVec4Ei;

extern fn _ZN5ImGui9SeparatorEv() void;
pub const Separator = _ZN5ImGui9SeparatorEv;

extern fn _ZN5ImGui8SameLineEff(offset_from_start_x: f32, spacing: f32) void;
pub const SameLine = _ZN5ImGui8SameLineEff;

extern fn _ZN5ImGui7NewLineEv() void;
pub const NewLine = _ZN5ImGui7NewLineEv;

extern fn _ZN5ImGui7SpacingEv() void;
pub const Spacing = _ZN5ImGui7SpacingEv;

extern fn _ZN5ImGui5DummyERK6ImVec2(size: *const ImVec2) void;
pub const Dummy = _ZN5ImGui5DummyERK6ImVec2;

extern fn _ZN5ImGui6IndentEf(indent_w: f32) void;
pub const Indent = _ZN5ImGui6IndentEf;

extern fn _ZN5ImGui8UnindentEf(indent_w: f32) void;
pub const Unindent = _ZN5ImGui8UnindentEf;

extern fn _ZN5ImGui10BeginGroupEv() void;
pub const BeginGroup = _ZN5ImGui10BeginGroupEv;

extern fn _ZN5ImGui8EndGroupEv() void;
pub const EndGroup = _ZN5ImGui8EndGroupEv;

extern fn _ZN5ImGui12GetCursorPosEv() ImVec2;
pub const GetCursorPos = _ZN5ImGui12GetCursorPosEv;

extern fn _ZN5ImGui13GetCursorPosXEv() f32;
pub const GetCursorPosX = _ZN5ImGui13GetCursorPosXEv;

extern fn _ZN5ImGui13GetCursorPosYEv() f32;
pub const GetCursorPosY = _ZN5ImGui13GetCursorPosYEv;

extern fn _ZN5ImGui12SetCursorPosERK6ImVec2(local_pos: *const ImVec2) void;
pub const SetCursorPos = _ZN5ImGui12SetCursorPosERK6ImVec2;

extern fn _ZN5ImGui13SetCursorPosXEf(local_x: f32) void;
pub const SetCursorPosX = _ZN5ImGui13SetCursorPosXEf;

extern fn _ZN5ImGui13SetCursorPosYEf(local_y: f32) void;
pub const SetCursorPosY = _ZN5ImGui13SetCursorPosYEf;

extern fn _ZN5ImGui17GetCursorStartPosEv() ImVec2;
pub const GetCursorStartPos = _ZN5ImGui17GetCursorStartPosEv;

extern fn _ZN5ImGui18GetCursorScreenPosEv() ImVec2;
pub const GetCursorScreenPos = _ZN5ImGui18GetCursorScreenPosEv;

extern fn _ZN5ImGui18SetCursorScreenPosERK6ImVec2(pos: *const ImVec2) void;
pub const SetCursorScreenPos = _ZN5ImGui18SetCursorScreenPosERK6ImVec2;

extern fn _ZN5ImGui23AlignTextToFramePaddingEv() void;
pub const AlignTextToFramePadding = _ZN5ImGui23AlignTextToFramePaddingEv;

extern fn _ZN5ImGui17GetTextLineHeightEv() f32;
pub const GetTextLineHeight = _ZN5ImGui17GetTextLineHeightEv;

extern fn _ZN5ImGui28GetTextLineHeightWithSpacingEv() f32;
pub const GetTextLineHeightWithSpacing = _ZN5ImGui28GetTextLineHeightWithSpacingEv;

extern fn _ZN5ImGui14GetFrameHeightEv() f32;
pub const GetFrameHeight = _ZN5ImGui14GetFrameHeightEv;

extern fn _ZN5ImGui25GetFrameHeightWithSpacingEv() f32;
pub const GetFrameHeightWithSpacing = _ZN5ImGui25GetFrameHeightWithSpacingEv;

extern fn _ZN5ImGui6PushIDEPKc(str_id: [*c]const u8) void;
pub const PushID = _ZN5ImGui6PushIDEPKc;

extern fn _ZN5ImGui6PushIDEPKcS1_(str_id_begin: [*c]const u8, str_id_end: [*c]const u8) void;
pub const PushID__Overload2 = _ZN5ImGui6PushIDEPKcS1_;

extern fn _ZN5ImGui6PushIDEPKv(ptr_id: ?*const anyopaque) void;
pub const PushID__Overload3 = _ZN5ImGui6PushIDEPKv;

extern fn _ZN5ImGui6PushIDEi(int_id: c_int) void;
pub const PushID__Overload4 = _ZN5ImGui6PushIDEi;

extern fn _ZN5ImGui5PopIDEv() void;
pub const PopID = _ZN5ImGui5PopIDEv;

extern fn _ZN5ImGui5GetIDEPKc(str_id: [*c]const u8) ImGuiID;
pub const GetID = _ZN5ImGui5GetIDEPKc;

extern fn _ZN5ImGui5GetIDEPKcS1_(str_id_begin: [*c]const u8, str_id_end: [*c]const u8) ImGuiID;
pub const GetID__Overload2 = _ZN5ImGui5GetIDEPKcS1_;

extern fn _ZN5ImGui5GetIDEPKv(ptr_id: ?*const anyopaque) ImGuiID;
pub const GetID__Overload3 = _ZN5ImGui5GetIDEPKv;

extern fn _ZN5ImGui15TextUnformattedEPKcS1_(text: [*c]const u8, text_end: [*c]const u8) void;
pub const TextUnformatted = _ZN5ImGui15TextUnformattedEPKcS1_;

extern fn _ZN5ImGui4TextEPKcz(fmt: [*c]const u8) void;
pub const Text = _ZN5ImGui4TextEPKcz;

extern fn _ZN5ImGui5TextVEPKcPc(fmt: [*c]const u8, args: [*c]u8) void;
pub const TextV = _ZN5ImGui5TextVEPKcPc;

extern fn _ZN5ImGui11TextColoredERK6ImVec4PKcz(col: *const ImVec4, fmt: [*c]const u8) void;
pub const TextColored = _ZN5ImGui11TextColoredERK6ImVec4PKcz;

extern fn _ZN5ImGui12TextColoredVERK6ImVec4PKcPc(col: *const ImVec4, fmt: [*c]const u8, args: [*c]u8) void;
pub const TextColoredV = _ZN5ImGui12TextColoredVERK6ImVec4PKcPc;

extern fn _ZN5ImGui12TextDisabledEPKcz(fmt: [*c]const u8) void;
pub const TextDisabled = _ZN5ImGui12TextDisabledEPKcz;

extern fn _ZN5ImGui13TextDisabledVEPKcPc(fmt: [*c]const u8, args: [*c]u8) void;
pub const TextDisabledV = _ZN5ImGui13TextDisabledVEPKcPc;

extern fn _ZN5ImGui11TextWrappedEPKcz(fmt: [*c]const u8) void;
pub const TextWrapped = _ZN5ImGui11TextWrappedEPKcz;

extern fn _ZN5ImGui12TextWrappedVEPKcPc(fmt: [*c]const u8, args: [*c]u8) void;
pub const TextWrappedV = _ZN5ImGui12TextWrappedVEPKcPc;

extern fn _ZN5ImGui9LabelTextEPKcS1_z(label: [*c]const u8, fmt: [*c]const u8) void;
pub const LabelText = _ZN5ImGui9LabelTextEPKcS1_z;

extern fn _ZN5ImGui10LabelTextVEPKcS1_Pc(label: [*c]const u8, fmt: [*c]const u8, args: [*c]u8) void;
pub const LabelTextV = _ZN5ImGui10LabelTextVEPKcS1_Pc;

extern fn _ZN5ImGui10BulletTextEPKcz(fmt: [*c]const u8) void;
pub const BulletText = _ZN5ImGui10BulletTextEPKcz;

extern fn _ZN5ImGui11BulletTextVEPKcPc(fmt: [*c]const u8, args: [*c]u8) void;
pub const BulletTextV = _ZN5ImGui11BulletTextVEPKcPc;

extern fn _ZN5ImGui13SeparatorTextEPKc(label: [*c]const u8) void;
pub const SeparatorText = _ZN5ImGui13SeparatorTextEPKc;

extern fn _ZN5ImGui6ButtonEPKcRK6ImVec2(label: [*c]const u8, size: *const ImVec2) bool;
pub const Button = _ZN5ImGui6ButtonEPKcRK6ImVec2;

extern fn _ZN5ImGui11SmallButtonEPKc(label: [*c]const u8) bool;
pub const SmallButton = _ZN5ImGui11SmallButtonEPKc;

extern fn _ZN5ImGui15InvisibleButtonEPKcRK6ImVec2i(str_id: [*c]const u8, size: *const ImVec2, flags: ImGuiButtonFlags) bool;
pub const InvisibleButton = _ZN5ImGui15InvisibleButtonEPKcRK6ImVec2i;

extern fn _ZN5ImGui11ArrowButtonEPKci(str_id: [*c]const u8, dir: ImGuiDir) bool;
pub const ArrowButton = _ZN5ImGui11ArrowButtonEPKci;

extern fn _ZN5ImGui8CheckboxEPKcPb(label: [*c]const u8, v: [*c]bool) bool;
pub const Checkbox = _ZN5ImGui8CheckboxEPKcPb;

extern fn _ZN5ImGui13CheckboxFlagsEPKcPii(label: [*c]const u8, flags: [*c]c_int, flags_value: c_int) bool;
pub const CheckboxFlags = _ZN5ImGui13CheckboxFlagsEPKcPii;

extern fn _ZN5ImGui13CheckboxFlagsEPKcPjj(label: [*c]const u8, flags: [*c]c_uint, flags_value: c_uint) bool;
pub const CheckboxFlags__Overload2 = _ZN5ImGui13CheckboxFlagsEPKcPjj;

extern fn _ZN5ImGui11RadioButtonEPKcb(label: [*c]const u8, active: bool) bool;
pub const RadioButton = _ZN5ImGui11RadioButtonEPKcb;

extern fn _ZN5ImGui11RadioButtonEPKcPii(label: [*c]const u8, v: [*c]c_int, v_button: c_int) bool;
pub const RadioButton__Overload2 = _ZN5ImGui11RadioButtonEPKcPii;

extern fn _ZN5ImGui11ProgressBarEfRK6ImVec2PKc(fraction: f32, size_arg: *const ImVec2, overlay: [*c]const u8) void;
pub const ProgressBar = _ZN5ImGui11ProgressBarEfRK6ImVec2PKc;

extern fn _ZN5ImGui6BulletEv() void;
pub const Bullet = _ZN5ImGui6BulletEv;

extern fn _ZN5ImGui5ImageEPvRK6ImVec2S3_S3_RK6ImVec4S6_(user_texture_id: ImTextureID, size: *const ImVec2, uv0: *const ImVec2, uv1: *const ImVec2, tint_col: *const ImVec4, border_col: *const ImVec4) void;
pub const Image = _ZN5ImGui5ImageEPvRK6ImVec2S3_S3_RK6ImVec4S6_;

extern fn _ZN5ImGui11ImageButtonEPKcPvRK6ImVec2S5_S5_RK6ImVec4S8_(str_id: [*c]const u8, user_texture_id: ImTextureID, size: *const ImVec2, uv0: *const ImVec2, uv1: *const ImVec2, bg_col: *const ImVec4, tint_col: *const ImVec4) bool;
pub const ImageButton = _ZN5ImGui11ImageButtonEPKcPvRK6ImVec2S5_S5_RK6ImVec4S8_;

extern fn _ZN5ImGui10BeginComboEPKcS1_i(label: [*c]const u8, preview_value: [*c]const u8, flags: ImGuiComboFlags) bool;
pub const BeginCombo = _ZN5ImGui10BeginComboEPKcS1_i;

extern fn _ZN5ImGui8EndComboEv() void;
pub const EndCombo = _ZN5ImGui8EndComboEv;

extern fn _ZN5ImGui5ComboEPKcPiPKS1_ii(label: [*c]const u8, current_item: [*c]c_int, items: [*c]const [*c]const u8, items_count: c_int, popup_max_height_in_items: c_int) bool;
pub const Combo = _ZN5ImGui5ComboEPKcPiPKS1_ii;

extern fn _ZN5ImGui5ComboEPKcPiS1_i(label: [*c]const u8, current_item: [*c]c_int, items_separated_by_zeros: [*c]const u8, popup_max_height_in_items: c_int) bool;
pub const Combo__Overload2 = _ZN5ImGui5ComboEPKcPiS1_i;

extern fn _ZN5ImGui5ComboEPKcPiPFbPviPS1_ES3_ii(label: [*c]const u8, current_item: [*c]c_int, items_getter: ?*const fn (?*anyopaque, c_int, [*c]const [*c]u8) callconv(.C) bool, data: ?*anyopaque, items_count: c_int, popup_max_height_in_items: c_int) bool;
pub const Combo__Overload3 = _ZN5ImGui5ComboEPKcPiPFbPviPS1_ES3_ii;

extern fn _ZN5ImGui9DragFloatEPKcPffffS1_i(label: [*c]const u8, v: [*c]f32, v_speed: f32, v_min: f32, v_max: f32, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragFloat = _ZN5ImGui9DragFloatEPKcPffffS1_i;

extern fn _ZN5ImGui10DragFloat2EPKcPffffS1_i(label: [*c]const u8, v: [*c]f32, v_speed: f32, v_min: f32, v_max: f32, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragFloat2 = _ZN5ImGui10DragFloat2EPKcPffffS1_i;

extern fn _ZN5ImGui10DragFloat3EPKcPffffS1_i(label: [*c]const u8, v: [*c]f32, v_speed: f32, v_min: f32, v_max: f32, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragFloat3 = _ZN5ImGui10DragFloat3EPKcPffffS1_i;

extern fn _ZN5ImGui10DragFloat4EPKcPffffS1_i(label: [*c]const u8, v: [*c]f32, v_speed: f32, v_min: f32, v_max: f32, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragFloat4 = _ZN5ImGui10DragFloat4EPKcPffffS1_i;

extern fn _ZN5ImGui15DragFloatRange2EPKcPfS2_fffS1_S1_i(label: [*c]const u8, v_current_min: [*c]f32, v_current_max: [*c]f32, v_speed: f32, v_min: f32, v_max: f32, format: [*c]const u8, format_max: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragFloatRange2 = _ZN5ImGui15DragFloatRange2EPKcPfS2_fffS1_S1_i;

extern fn _ZN5ImGui7DragIntEPKcPifiiS1_i(label: [*c]const u8, v: [*c]c_int, v_speed: f32, v_min: c_int, v_max: c_int, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragInt = _ZN5ImGui7DragIntEPKcPifiiS1_i;

extern fn _ZN5ImGui8DragInt2EPKcPifiiS1_i(label: [*c]const u8, v: [*c]c_int, v_speed: f32, v_min: c_int, v_max: c_int, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragInt2 = _ZN5ImGui8DragInt2EPKcPifiiS1_i;

extern fn _ZN5ImGui8DragInt3EPKcPifiiS1_i(label: [*c]const u8, v: [*c]c_int, v_speed: f32, v_min: c_int, v_max: c_int, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragInt3 = _ZN5ImGui8DragInt3EPKcPifiiS1_i;

extern fn _ZN5ImGui8DragInt4EPKcPifiiS1_i(label: [*c]const u8, v: [*c]c_int, v_speed: f32, v_min: c_int, v_max: c_int, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragInt4 = _ZN5ImGui8DragInt4EPKcPifiiS1_i;

extern fn _ZN5ImGui13DragIntRange2EPKcPiS2_fiiS1_S1_i(label: [*c]const u8, v_current_min: [*c]c_int, v_current_max: [*c]c_int, v_speed: f32, v_min: c_int, v_max: c_int, format: [*c]const u8, format_max: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragIntRange2 = _ZN5ImGui13DragIntRange2EPKcPiS2_fiiS1_S1_i;

extern fn _ZN5ImGui10DragScalarEPKciPvfPKvS4_S1_i(label: [*c]const u8, data_type: ImGuiDataType, p_data: ?*anyopaque, v_speed: f32, p_min: ?*const anyopaque, p_max: ?*const anyopaque, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragScalar = _ZN5ImGui10DragScalarEPKciPvfPKvS4_S1_i;

extern fn _ZN5ImGui11DragScalarNEPKciPvifPKvS4_S1_i(label: [*c]const u8, data_type: ImGuiDataType, p_data: ?*anyopaque, components: c_int, v_speed: f32, p_min: ?*const anyopaque, p_max: ?*const anyopaque, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const DragScalarN = _ZN5ImGui11DragScalarNEPKciPvifPKvS4_S1_i;

extern fn _ZN5ImGui11SliderFloatEPKcPfffS1_i(label: [*c]const u8, v: [*c]f32, v_min: f32, v_max: f32, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderFloat = _ZN5ImGui11SliderFloatEPKcPfffS1_i;

extern fn _ZN5ImGui12SliderFloat2EPKcPfffS1_i(label: [*c]const u8, v: [*c]f32, v_min: f32, v_max: f32, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderFloat2 = _ZN5ImGui12SliderFloat2EPKcPfffS1_i;

extern fn _ZN5ImGui12SliderFloat3EPKcPfffS1_i(label: [*c]const u8, v: [*c]f32, v_min: f32, v_max: f32, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderFloat3 = _ZN5ImGui12SliderFloat3EPKcPfffS1_i;

extern fn _ZN5ImGui12SliderFloat4EPKcPfffS1_i(label: [*c]const u8, v: [*c]f32, v_min: f32, v_max: f32, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderFloat4 = _ZN5ImGui12SliderFloat4EPKcPfffS1_i;

extern fn _ZN5ImGui11SliderAngleEPKcPfffS1_i(label: [*c]const u8, v_rad: [*c]f32, v_degrees_min: f32, v_degrees_max: f32, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderAngle = _ZN5ImGui11SliderAngleEPKcPfffS1_i;

extern fn _ZN5ImGui9SliderIntEPKcPiiiS1_i(label: [*c]const u8, v: [*c]c_int, v_min: c_int, v_max: c_int, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderInt = _ZN5ImGui9SliderIntEPKcPiiiS1_i;

extern fn _ZN5ImGui10SliderInt2EPKcPiiiS1_i(label: [*c]const u8, v: [*c]c_int, v_min: c_int, v_max: c_int, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderInt2 = _ZN5ImGui10SliderInt2EPKcPiiiS1_i;

extern fn _ZN5ImGui10SliderInt3EPKcPiiiS1_i(label: [*c]const u8, v: [*c]c_int, v_min: c_int, v_max: c_int, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderInt3 = _ZN5ImGui10SliderInt3EPKcPiiiS1_i;

extern fn _ZN5ImGui10SliderInt4EPKcPiiiS1_i(label: [*c]const u8, v: [*c]c_int, v_min: c_int, v_max: c_int, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderInt4 = _ZN5ImGui10SliderInt4EPKcPiiiS1_i;

extern fn _ZN5ImGui12SliderScalarEPKciPvPKvS4_S1_i(label: [*c]const u8, data_type: ImGuiDataType, p_data: ?*anyopaque, p_min: ?*const anyopaque, p_max: ?*const anyopaque, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderScalar = _ZN5ImGui12SliderScalarEPKciPvPKvS4_S1_i;

extern fn _ZN5ImGui13SliderScalarNEPKciPviPKvS4_S1_i(label: [*c]const u8, data_type: ImGuiDataType, p_data: ?*anyopaque, components: c_int, p_min: ?*const anyopaque, p_max: ?*const anyopaque, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const SliderScalarN = _ZN5ImGui13SliderScalarNEPKciPviPKvS4_S1_i;

extern fn _ZN5ImGui12VSliderFloatEPKcRK6ImVec2PfffS1_i(label: [*c]const u8, size: *const ImVec2, v: [*c]f32, v_min: f32, v_max: f32, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const VSliderFloat = _ZN5ImGui12VSliderFloatEPKcRK6ImVec2PfffS1_i;

extern fn _ZN5ImGui10VSliderIntEPKcRK6ImVec2PiiiS1_i(label: [*c]const u8, size: *const ImVec2, v: [*c]c_int, v_min: c_int, v_max: c_int, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const VSliderInt = _ZN5ImGui10VSliderIntEPKcRK6ImVec2PiiiS1_i;

extern fn _ZN5ImGui13VSliderScalarEPKcRK6ImVec2iPvPKvS7_S1_i(label: [*c]const u8, size: *const ImVec2, data_type: ImGuiDataType, p_data: ?*anyopaque, p_min: ?*const anyopaque, p_max: ?*const anyopaque, format: [*c]const u8, flags: ImGuiSliderFlags) bool;
pub const VSliderScalar = _ZN5ImGui13VSliderScalarEPKcRK6ImVec2iPvPKvS7_S1_i;

extern fn _ZN5ImGui9InputTextEPKcPcyiPFiP26ImGuiInputTextCallbackDataEPv(label: [*c]const u8, buf: [*c]u8, buf_size: usize, flags: ImGuiInputTextFlags, callback: ImGuiInputTextCallback, user_data: ?*anyopaque) bool;
pub const InputText = _ZN5ImGui9InputTextEPKcPcyiPFiP26ImGuiInputTextCallbackDataEPv;

extern fn _ZN5ImGui18InputTextMultilineEPKcPcyRK6ImVec2iPFiP26ImGuiInputTextCallbackDataEPv(label: [*c]const u8, buf: [*c]u8, buf_size: usize, size: *const ImVec2, flags: ImGuiInputTextFlags, callback: ImGuiInputTextCallback, user_data: ?*anyopaque) bool;
pub const InputTextMultiline = _ZN5ImGui18InputTextMultilineEPKcPcyRK6ImVec2iPFiP26ImGuiInputTextCallbackDataEPv;

extern fn _ZN5ImGui17InputTextWithHintEPKcS1_PcyiPFiP26ImGuiInputTextCallbackDataEPv(label: [*c]const u8, hint: [*c]const u8, buf: [*c]u8, buf_size: usize, flags: ImGuiInputTextFlags, callback: ImGuiInputTextCallback, user_data: ?*anyopaque) bool;
pub const InputTextWithHint = _ZN5ImGui17InputTextWithHintEPKcS1_PcyiPFiP26ImGuiInputTextCallbackDataEPv;

extern fn _ZN5ImGui10InputFloatEPKcPfffS1_i(label: [*c]const u8, v: [*c]f32, step: f32, step_fast: f32, format: [*c]const u8, flags: ImGuiInputTextFlags) bool;
pub const InputFloat = _ZN5ImGui10InputFloatEPKcPfffS1_i;

extern fn _ZN5ImGui11InputFloat2EPKcPfS1_i(label: [*c]const u8, v: [*c]f32, format: [*c]const u8, flags: ImGuiInputTextFlags) bool;
pub const InputFloat2 = _ZN5ImGui11InputFloat2EPKcPfS1_i;

extern fn _ZN5ImGui11InputFloat3EPKcPfS1_i(label: [*c]const u8, v: [*c]f32, format: [*c]const u8, flags: ImGuiInputTextFlags) bool;
pub const InputFloat3 = _ZN5ImGui11InputFloat3EPKcPfS1_i;

extern fn _ZN5ImGui11InputFloat4EPKcPfS1_i(label: [*c]const u8, v: [*c]f32, format: [*c]const u8, flags: ImGuiInputTextFlags) bool;
pub const InputFloat4 = _ZN5ImGui11InputFloat4EPKcPfS1_i;

extern fn _ZN5ImGui8InputIntEPKcPiiii(label: [*c]const u8, v: [*c]c_int, step: c_int, step_fast: c_int, flags: ImGuiInputTextFlags) bool;
pub const InputInt = _ZN5ImGui8InputIntEPKcPiiii;

extern fn _ZN5ImGui9InputInt2EPKcPii(label: [*c]const u8, v: [*c]c_int, flags: ImGuiInputTextFlags) bool;
pub const InputInt2 = _ZN5ImGui9InputInt2EPKcPii;

extern fn _ZN5ImGui9InputInt3EPKcPii(label: [*c]const u8, v: [*c]c_int, flags: ImGuiInputTextFlags) bool;
pub const InputInt3 = _ZN5ImGui9InputInt3EPKcPii;

extern fn _ZN5ImGui9InputInt4EPKcPii(label: [*c]const u8, v: [*c]c_int, flags: ImGuiInputTextFlags) bool;
pub const InputInt4 = _ZN5ImGui9InputInt4EPKcPii;

extern fn _ZN5ImGui11InputDoubleEPKcPdddS1_i(label: [*c]const u8, v: [*c]f64, step: f64, step_fast: f64, format: [*c]const u8, flags: ImGuiInputTextFlags) bool;
pub const InputDouble = _ZN5ImGui11InputDoubleEPKcPdddS1_i;

extern fn _ZN5ImGui11InputScalarEPKciPvPKvS4_S1_i(label: [*c]const u8, data_type: ImGuiDataType, p_data: ?*anyopaque, p_step: ?*const anyopaque, p_step_fast: ?*const anyopaque, format: [*c]const u8, flags: ImGuiInputTextFlags) bool;
pub const InputScalar = _ZN5ImGui11InputScalarEPKciPvPKvS4_S1_i;

extern fn _ZN5ImGui12InputScalarNEPKciPviPKvS4_S1_i(label: [*c]const u8, data_type: ImGuiDataType, p_data: ?*anyopaque, components: c_int, p_step: ?*const anyopaque, p_step_fast: ?*const anyopaque, format: [*c]const u8, flags: ImGuiInputTextFlags) bool;
pub const InputScalarN = _ZN5ImGui12InputScalarNEPKciPviPKvS4_S1_i;

extern fn _ZN5ImGui10ColorEdit3EPKcPfi(label: [*c]const u8, col: [*c]f32, flags: ImGuiColorEditFlags) bool;
pub const ColorEdit3 = _ZN5ImGui10ColorEdit3EPKcPfi;

extern fn _ZN5ImGui10ColorEdit4EPKcPfi(label: [*c]const u8, col: [*c]f32, flags: ImGuiColorEditFlags) bool;
pub const ColorEdit4 = _ZN5ImGui10ColorEdit4EPKcPfi;

extern fn _ZN5ImGui12ColorPicker3EPKcPfi(label: [*c]const u8, col: [*c]f32, flags: ImGuiColorEditFlags) bool;
pub const ColorPicker3 = _ZN5ImGui12ColorPicker3EPKcPfi;

extern fn _ZN5ImGui12ColorPicker4EPKcPfiPKf(label: [*c]const u8, col: [*c]f32, flags: ImGuiColorEditFlags, ref_col: [*c]const f32) bool;
pub const ColorPicker4 = _ZN5ImGui12ColorPicker4EPKcPfiPKf;

extern fn _ZN5ImGui11ColorButtonEPKcRK6ImVec4iRK6ImVec2(desc_id: [*c]const u8, col: *const ImVec4, flags: ImGuiColorEditFlags, size: *const ImVec2) bool;
pub const ColorButton = _ZN5ImGui11ColorButtonEPKcRK6ImVec4iRK6ImVec2;

extern fn _ZN5ImGui19SetColorEditOptionsEi(flags: ImGuiColorEditFlags) void;
pub const SetColorEditOptions = _ZN5ImGui19SetColorEditOptionsEi;

extern fn _ZN5ImGui8TreeNodeEPKc(label: [*c]const u8) bool;
pub const TreeNode = _ZN5ImGui8TreeNodeEPKc;

extern fn _ZN5ImGui8TreeNodeEPKcS1_z(str_id: [*c]const u8, fmt: [*c]const u8) bool;
pub const TreeNode__Overload2 = _ZN5ImGui8TreeNodeEPKcS1_z;

extern fn _ZN5ImGui8TreeNodeEPKvPKcz(ptr_id: ?*const anyopaque, fmt: [*c]const u8) bool;
pub const TreeNode__Overload3 = _ZN5ImGui8TreeNodeEPKvPKcz;

extern fn _ZN5ImGui9TreeNodeVEPKcS1_Pc(str_id: [*c]const u8, fmt: [*c]const u8, args: [*c]u8) bool;
pub const TreeNodeV = _ZN5ImGui9TreeNodeVEPKcS1_Pc;

extern fn _ZN5ImGui9TreeNodeVEPKvPKcPc(ptr_id: ?*const anyopaque, fmt: [*c]const u8, args: [*c]u8) bool;
pub const TreeNodeV__Overload2 = _ZN5ImGui9TreeNodeVEPKvPKcPc;

extern fn _ZN5ImGui10TreeNodeExEPKci(label: [*c]const u8, flags: ImGuiTreeNodeFlags) bool;
pub const TreeNodeEx = _ZN5ImGui10TreeNodeExEPKci;

extern fn _ZN5ImGui10TreeNodeExEPKciS1_z(str_id: [*c]const u8, flags: ImGuiTreeNodeFlags, fmt: [*c]const u8) bool;
pub const TreeNodeEx__Overload2 = _ZN5ImGui10TreeNodeExEPKciS1_z;

extern fn _ZN5ImGui10TreeNodeExEPKviPKcz(ptr_id: ?*const anyopaque, flags: ImGuiTreeNodeFlags, fmt: [*c]const u8) bool;
pub const TreeNodeEx__Overload3 = _ZN5ImGui10TreeNodeExEPKviPKcz;

extern fn _ZN5ImGui11TreeNodeExVEPKciS1_Pc(str_id: [*c]const u8, flags: ImGuiTreeNodeFlags, fmt: [*c]const u8, args: [*c]u8) bool;
pub const TreeNodeExV = _ZN5ImGui11TreeNodeExVEPKciS1_Pc;

extern fn _ZN5ImGui11TreeNodeExVEPKviPKcPc(ptr_id: ?*const anyopaque, flags: ImGuiTreeNodeFlags, fmt: [*c]const u8, args: [*c]u8) bool;
pub const TreeNodeExV__Overload2 = _ZN5ImGui11TreeNodeExVEPKviPKcPc;

extern fn _ZN5ImGui8TreePushEPKc(str_id: [*c]const u8) void;
pub const TreePush = _ZN5ImGui8TreePushEPKc;

extern fn _ZN5ImGui8TreePushEPKv(ptr_id: ?*const anyopaque) void;
pub const TreePush__Overload2 = _ZN5ImGui8TreePushEPKv;

extern fn _ZN5ImGui7TreePopEv() void;
pub const TreePop = _ZN5ImGui7TreePopEv;

extern fn _ZN5ImGui25GetTreeNodeToLabelSpacingEv() f32;
pub const GetTreeNodeToLabelSpacing = _ZN5ImGui25GetTreeNodeToLabelSpacingEv;

extern fn _ZN5ImGui16CollapsingHeaderEPKci(label: [*c]const u8, flags: ImGuiTreeNodeFlags) bool;
pub const CollapsingHeader = _ZN5ImGui16CollapsingHeaderEPKci;

extern fn _ZN5ImGui16CollapsingHeaderEPKcPbi(label: [*c]const u8, p_visible: [*c]bool, flags: ImGuiTreeNodeFlags) bool;
pub const CollapsingHeader__Overload2 = _ZN5ImGui16CollapsingHeaderEPKcPbi;

extern fn _ZN5ImGui15SetNextItemOpenEbi(is_open: bool, cond: ImGuiCond) void;
pub const SetNextItemOpen = _ZN5ImGui15SetNextItemOpenEbi;

extern fn _ZN5ImGui10SelectableEPKcbiRK6ImVec2(label: [*c]const u8, selected: bool, flags: ImGuiSelectableFlags, size: *const ImVec2) bool;
pub const Selectable = _ZN5ImGui10SelectableEPKcbiRK6ImVec2;

extern fn _ZN5ImGui10SelectableEPKcPbiRK6ImVec2(label: [*c]const u8, p_selected: [*c]bool, flags: ImGuiSelectableFlags, size: *const ImVec2) bool;
pub const Selectable__Overload2 = _ZN5ImGui10SelectableEPKcPbiRK6ImVec2;

extern fn _ZN5ImGui12BeginListBoxEPKcRK6ImVec2(label: [*c]const u8, size: *const ImVec2) bool;
pub const BeginListBox = _ZN5ImGui12BeginListBoxEPKcRK6ImVec2;

extern fn _ZN5ImGui10EndListBoxEv() void;
pub const EndListBox = _ZN5ImGui10EndListBoxEv;

extern fn _ZN5ImGui7ListBoxEPKcPiPKS1_ii(label: [*c]const u8, current_item: [*c]c_int, items: [*c]const [*c]const u8, items_count: c_int, height_in_items: c_int) bool;
pub const ListBox = _ZN5ImGui7ListBoxEPKcPiPKS1_ii;

extern fn _ZN5ImGui7ListBoxEPKcPiPFbPviPS1_ES3_ii(label: [*c]const u8, current_item: [*c]c_int, items_getter: ?*const fn (?*anyopaque, c_int, [*c]const [*c]u8) callconv(.C) bool, data: ?*anyopaque, items_count: c_int, height_in_items: c_int) bool;
pub const ListBox__Overload2 = _ZN5ImGui7ListBoxEPKcPiPFbPviPS1_ES3_ii;

extern fn _ZN5ImGui9PlotLinesEPKcPKfiiS1_ff6ImVec2i(label: [*c]const u8, values: [*c]const f32, values_count: c_int, values_offset: c_int, overlay_text: [*c]const u8, scale_min: f32, scale_max: f32, graph_size: ImVec2, stride: c_int) void;
pub const PlotLines = _ZN5ImGui9PlotLinesEPKcPKfiiS1_ff6ImVec2i;

extern fn _ZN5ImGui9PlotLinesEPKcPFfPviES2_iiS1_ff6ImVec2(label: [*c]const u8, values_getter: ?*const fn (?*anyopaque, c_int) callconv(.C) f32, data: ?*anyopaque, values_count: c_int, values_offset: c_int, overlay_text: [*c]const u8, scale_min: f32, scale_max: f32, graph_size: ImVec2) void;
pub const PlotLines__Overload2 = _ZN5ImGui9PlotLinesEPKcPFfPviES2_iiS1_ff6ImVec2;

extern fn _ZN5ImGui13PlotHistogramEPKcPKfiiS1_ff6ImVec2i(label: [*c]const u8, values: [*c]const f32, values_count: c_int, values_offset: c_int, overlay_text: [*c]const u8, scale_min: f32, scale_max: f32, graph_size: ImVec2, stride: c_int) void;
pub const PlotHistogram = _ZN5ImGui13PlotHistogramEPKcPKfiiS1_ff6ImVec2i;

extern fn _ZN5ImGui13PlotHistogramEPKcPFfPviES2_iiS1_ff6ImVec2(label: [*c]const u8, values_getter: ?*const fn (?*anyopaque, c_int) callconv(.C) f32, data: ?*anyopaque, values_count: c_int, values_offset: c_int, overlay_text: [*c]const u8, scale_min: f32, scale_max: f32, graph_size: ImVec2) void;
pub const PlotHistogram__Overload2 = _ZN5ImGui13PlotHistogramEPKcPFfPviES2_iiS1_ff6ImVec2;

extern fn _ZN5ImGui5ValueEPKcb(prefix: [*c]const u8, b: bool) void;
pub const Value = _ZN5ImGui5ValueEPKcb;

extern fn _ZN5ImGui5ValueEPKci(prefix: [*c]const u8, v: c_int) void;
pub const Value__Overload2 = _ZN5ImGui5ValueEPKci;

extern fn _ZN5ImGui5ValueEPKcj(prefix: [*c]const u8, v: c_uint) void;
pub const Value__Overload3 = _ZN5ImGui5ValueEPKcj;

extern fn _ZN5ImGui5ValueEPKcfS1_(prefix: [*c]const u8, v: f32, float_format: [*c]const u8) void;
pub const Value__Overload4 = _ZN5ImGui5ValueEPKcfS1_;

extern fn _ZN5ImGui12BeginMenuBarEv() bool;
pub const BeginMenuBar = _ZN5ImGui12BeginMenuBarEv;

extern fn _ZN5ImGui10EndMenuBarEv() void;
pub const EndMenuBar = _ZN5ImGui10EndMenuBarEv;

extern fn _ZN5ImGui16BeginMainMenuBarEv() bool;
pub const BeginMainMenuBar = _ZN5ImGui16BeginMainMenuBarEv;

extern fn _ZN5ImGui14EndMainMenuBarEv() void;
pub const EndMainMenuBar = _ZN5ImGui14EndMainMenuBarEv;

extern fn _ZN5ImGui9BeginMenuEPKcb(label: [*c]const u8, enabled: bool) bool;
pub const BeginMenu = _ZN5ImGui9BeginMenuEPKcb;

extern fn _ZN5ImGui7EndMenuEv() void;
pub const EndMenu = _ZN5ImGui7EndMenuEv;

extern fn _ZN5ImGui8MenuItemEPKcS1_bb(label: [*c]const u8, shortcut: [*c]const u8, selected: bool, enabled: bool) bool;
pub const MenuItem = _ZN5ImGui8MenuItemEPKcS1_bb;

extern fn _ZN5ImGui8MenuItemEPKcS1_Pbb(label: [*c]const u8, shortcut: [*c]const u8, p_selected: [*c]bool, enabled: bool) bool;
pub const MenuItem__Overload2 = _ZN5ImGui8MenuItemEPKcS1_Pbb;

extern fn _ZN5ImGui12BeginTooltipEv() bool;
pub const BeginTooltip = _ZN5ImGui12BeginTooltipEv;

extern fn _ZN5ImGui10EndTooltipEv() void;
pub const EndTooltip = _ZN5ImGui10EndTooltipEv;

extern fn _ZN5ImGui10SetTooltipEPKcz(fmt: [*c]const u8) void;
pub const SetTooltip = _ZN5ImGui10SetTooltipEPKcz;

extern fn _ZN5ImGui11SetTooltipVEPKcPc(fmt: [*c]const u8, args: [*c]u8) void;
pub const SetTooltipV = _ZN5ImGui11SetTooltipVEPKcPc;

extern fn _ZN5ImGui10BeginPopupEPKci(str_id: [*c]const u8, flags: ImGuiWindowFlags) bool;
pub const BeginPopup = _ZN5ImGui10BeginPopupEPKci;

extern fn _ZN5ImGui15BeginPopupModalEPKcPbi(name: [*c]const u8, p_open: [*c]bool, flags: ImGuiWindowFlags) bool;
pub const BeginPopupModal = _ZN5ImGui15BeginPopupModalEPKcPbi;

extern fn _ZN5ImGui8EndPopupEv() void;
pub const EndPopup = _ZN5ImGui8EndPopupEv;

extern fn _ZN5ImGui9OpenPopupEPKci(str_id: [*c]const u8, popup_flags: ImGuiPopupFlags) void;
pub const OpenPopup = _ZN5ImGui9OpenPopupEPKci;

extern fn _ZN5ImGui9OpenPopupEji(id: ImGuiID, popup_flags: ImGuiPopupFlags) void;
pub const OpenPopup__Overload2 = _ZN5ImGui9OpenPopupEji;

extern fn _ZN5ImGui20OpenPopupOnItemClickEPKci(str_id: [*c]const u8, popup_flags: ImGuiPopupFlags) void;
pub const OpenPopupOnItemClick = _ZN5ImGui20OpenPopupOnItemClickEPKci;

extern fn _ZN5ImGui17CloseCurrentPopupEv() void;
pub const CloseCurrentPopup = _ZN5ImGui17CloseCurrentPopupEv;

extern fn _ZN5ImGui21BeginPopupContextItemEPKci(str_id: [*c]const u8, popup_flags: ImGuiPopupFlags) bool;
pub const BeginPopupContextItem = _ZN5ImGui21BeginPopupContextItemEPKci;

extern fn _ZN5ImGui23BeginPopupContextWindowEPKci(str_id: [*c]const u8, popup_flags: ImGuiPopupFlags) bool;
pub const BeginPopupContextWindow = _ZN5ImGui23BeginPopupContextWindowEPKci;

extern fn _ZN5ImGui21BeginPopupContextVoidEPKci(str_id: [*c]const u8, popup_flags: ImGuiPopupFlags) bool;
pub const BeginPopupContextVoid = _ZN5ImGui21BeginPopupContextVoidEPKci;

extern fn _ZN5ImGui11IsPopupOpenEPKci(str_id: [*c]const u8, flags: ImGuiPopupFlags) bool;
pub const IsPopupOpen = _ZN5ImGui11IsPopupOpenEPKci;

extern fn _ZN5ImGui10BeginTableEPKciiRK6ImVec2f(str_id: [*c]const u8, column: c_int, flags: ImGuiTableFlags, outer_size: *const ImVec2, inner_width: f32) bool;
pub const BeginTable = _ZN5ImGui10BeginTableEPKciiRK6ImVec2f;

extern fn _ZN5ImGui8EndTableEv() void;
pub const EndTable = _ZN5ImGui8EndTableEv;

extern fn _ZN5ImGui12TableNextRowEif(row_flags: ImGuiTableRowFlags, min_row_height: f32) void;
pub const TableNextRow = _ZN5ImGui12TableNextRowEif;

extern fn _ZN5ImGui15TableNextColumnEv() bool;
pub const TableNextColumn = _ZN5ImGui15TableNextColumnEv;

extern fn _ZN5ImGui19TableSetColumnIndexEi(column_n: c_int) bool;
pub const TableSetColumnIndex = _ZN5ImGui19TableSetColumnIndexEi;

extern fn _ZN5ImGui16TableSetupColumnEPKcifj(label: [*c]const u8, flags: ImGuiTableColumnFlags, init_width_or_weight: f32, user_id: ImGuiID) void;
pub const TableSetupColumn = _ZN5ImGui16TableSetupColumnEPKcifj;

extern fn _ZN5ImGui22TableSetupScrollFreezeEii(cols: c_int, rows: c_int) void;
pub const TableSetupScrollFreeze = _ZN5ImGui22TableSetupScrollFreezeEii;

extern fn _ZN5ImGui15TableHeadersRowEv() void;
pub const TableHeadersRow = _ZN5ImGui15TableHeadersRowEv;

extern fn _ZN5ImGui11TableHeaderEPKc(label: [*c]const u8) void;
pub const TableHeader = _ZN5ImGui11TableHeaderEPKc;

extern fn _ZN5ImGui17TableGetSortSpecsEv() [*c]ImGuiTableSortSpecs;
pub const TableGetSortSpecs = _ZN5ImGui17TableGetSortSpecsEv;

extern fn _ZN5ImGui19TableGetColumnCountEv() c_int;
pub const TableGetColumnCount = _ZN5ImGui19TableGetColumnCountEv;

extern fn _ZN5ImGui19TableGetColumnIndexEv() c_int;
pub const TableGetColumnIndex = _ZN5ImGui19TableGetColumnIndexEv;

extern fn _ZN5ImGui16TableGetRowIndexEv() c_int;
pub const TableGetRowIndex = _ZN5ImGui16TableGetRowIndexEv;

extern fn _ZN5ImGui18TableGetColumnNameEi(column_n: c_int) [*c]const u8;
pub const TableGetColumnName = _ZN5ImGui18TableGetColumnNameEi;

extern fn _ZN5ImGui19TableGetColumnFlagsEi(column_n: c_int) ImGuiTableColumnFlags;
pub const TableGetColumnFlags = _ZN5ImGui19TableGetColumnFlagsEi;

extern fn _ZN5ImGui21TableSetColumnEnabledEib(column_n: c_int, v: bool) void;
pub const TableSetColumnEnabled = _ZN5ImGui21TableSetColumnEnabledEib;

extern fn _ZN5ImGui15TableSetBgColorEiji(target: ImGuiTableBgTarget, color: ImU32, column_n: c_int) void;
pub const TableSetBgColor = _ZN5ImGui15TableSetBgColorEiji;

extern fn _ZN5ImGui7ColumnsEiPKcb(count: c_int, id: [*c]const u8, border: bool) void;
pub const Columns = _ZN5ImGui7ColumnsEiPKcb;

extern fn _ZN5ImGui10NextColumnEv() void;
pub const NextColumn = _ZN5ImGui10NextColumnEv;

extern fn _ZN5ImGui14GetColumnIndexEv() c_int;
pub const GetColumnIndex = _ZN5ImGui14GetColumnIndexEv;

extern fn _ZN5ImGui14GetColumnWidthEi(column_index: c_int) f32;
pub const GetColumnWidth = _ZN5ImGui14GetColumnWidthEi;

extern fn _ZN5ImGui14SetColumnWidthEif(column_index: c_int, width: f32) void;
pub const SetColumnWidth = _ZN5ImGui14SetColumnWidthEif;

extern fn _ZN5ImGui15GetColumnOffsetEi(column_index: c_int) f32;
pub const GetColumnOffset = _ZN5ImGui15GetColumnOffsetEi;

extern fn _ZN5ImGui15SetColumnOffsetEif(column_index: c_int, offset_x: f32) void;
pub const SetColumnOffset = _ZN5ImGui15SetColumnOffsetEif;

extern fn _ZN5ImGui15GetColumnsCountEv() c_int;
pub const GetColumnsCount = _ZN5ImGui15GetColumnsCountEv;

extern fn _ZN5ImGui11BeginTabBarEPKci(str_id: [*c]const u8, flags: ImGuiTabBarFlags) bool;
pub const BeginTabBar = _ZN5ImGui11BeginTabBarEPKci;

extern fn _ZN5ImGui9EndTabBarEv() void;
pub const EndTabBar = _ZN5ImGui9EndTabBarEv;

extern fn _ZN5ImGui12BeginTabItemEPKcPbi(label: [*c]const u8, p_open: [*c]bool, flags: ImGuiTabItemFlags) bool;
pub const BeginTabItem = _ZN5ImGui12BeginTabItemEPKcPbi;

extern fn _ZN5ImGui10EndTabItemEv() void;
pub const EndTabItem = _ZN5ImGui10EndTabItemEv;

extern fn _ZN5ImGui13TabItemButtonEPKci(label: [*c]const u8, flags: ImGuiTabItemFlags) bool;
pub const TabItemButton = _ZN5ImGui13TabItemButtonEPKci;

extern fn _ZN5ImGui16SetTabItemClosedEPKc(tab_or_docked_window_label: [*c]const u8) void;
pub const SetTabItemClosed = _ZN5ImGui16SetTabItemClosedEPKc;

extern fn _ZN5ImGui9DockSpaceEjRK6ImVec2iPK16ImGuiWindowClass(id: ImGuiID, size: *const ImVec2, flags: ImGuiDockNodeFlags, window_class: [*c]const ImGuiWindowClass) ImGuiID;
pub const DockSpace = _ZN5ImGui9DockSpaceEjRK6ImVec2iPK16ImGuiWindowClass;

extern fn _ZN5ImGui21DockSpaceOverViewportEPK13ImGuiViewportiPK16ImGuiWindowClass(viewport: [*c]const ImGuiViewport, flags: ImGuiDockNodeFlags, window_class: [*c]const ImGuiWindowClass) ImGuiID;
pub const DockSpaceOverViewport = _ZN5ImGui21DockSpaceOverViewportEPK13ImGuiViewportiPK16ImGuiWindowClass;

extern fn _ZN5ImGui19SetNextWindowDockIDEji(dock_id: ImGuiID, cond: ImGuiCond) void;
pub const SetNextWindowDockID = _ZN5ImGui19SetNextWindowDockIDEji;

extern fn _ZN5ImGui18SetNextWindowClassEPK16ImGuiWindowClass(window_class: [*c]const ImGuiWindowClass) void;
pub const SetNextWindowClass = _ZN5ImGui18SetNextWindowClassEPK16ImGuiWindowClass;

extern fn _ZN5ImGui15GetWindowDockIDEv() ImGuiID;
pub const GetWindowDockID = _ZN5ImGui15GetWindowDockIDEv;

extern fn _ZN5ImGui14IsWindowDockedEv() bool;
pub const IsWindowDocked = _ZN5ImGui14IsWindowDockedEv;

extern fn _ZN5ImGui8LogToTTYEi(auto_open_depth: c_int) void;
pub const LogToTTY = _ZN5ImGui8LogToTTYEi;

extern fn _ZN5ImGui9LogToFileEiPKc(auto_open_depth: c_int, filename: [*c]const u8) void;
pub const LogToFile = _ZN5ImGui9LogToFileEiPKc;

extern fn _ZN5ImGui14LogToClipboardEi(auto_open_depth: c_int) void;
pub const LogToClipboard = _ZN5ImGui14LogToClipboardEi;

extern fn _ZN5ImGui9LogFinishEv() void;
pub const LogFinish = _ZN5ImGui9LogFinishEv;

extern fn _ZN5ImGui10LogButtonsEv() void;
pub const LogButtons = _ZN5ImGui10LogButtonsEv;

extern fn _ZN5ImGui7LogTextEPKcz(fmt: [*c]const u8) void;
pub const LogText = _ZN5ImGui7LogTextEPKcz;

extern fn _ZN5ImGui8LogTextVEPKcPc(fmt: [*c]const u8, args: [*c]u8) void;
pub const LogTextV = _ZN5ImGui8LogTextVEPKcPc;

extern fn _ZN5ImGui19BeginDragDropSourceEi(flags: ImGuiDragDropFlags) bool;
pub const BeginDragDropSource = _ZN5ImGui19BeginDragDropSourceEi;

extern fn _ZN5ImGui18SetDragDropPayloadEPKcPKvyi(type: [*c]const u8, data: ?*const anyopaque, sz: usize, cond: ImGuiCond) bool;
pub const SetDragDropPayload = _ZN5ImGui18SetDragDropPayloadEPKcPKvyi;

extern fn _ZN5ImGui17EndDragDropSourceEv() void;
pub const EndDragDropSource = _ZN5ImGui17EndDragDropSourceEv;

extern fn _ZN5ImGui19BeginDragDropTargetEv() bool;
pub const BeginDragDropTarget = _ZN5ImGui19BeginDragDropTargetEv;

extern fn _ZN5ImGui21AcceptDragDropPayloadEPKci(type: [*c]const u8, flags: ImGuiDragDropFlags) [*c]const ImGuiPayload;
pub const AcceptDragDropPayload = _ZN5ImGui21AcceptDragDropPayloadEPKci;

extern fn _ZN5ImGui17EndDragDropTargetEv() void;
pub const EndDragDropTarget = _ZN5ImGui17EndDragDropTargetEv;

extern fn _ZN5ImGui18GetDragDropPayloadEv() [*c]const ImGuiPayload;
pub const GetDragDropPayload = _ZN5ImGui18GetDragDropPayloadEv;

extern fn _ZN5ImGui13BeginDisabledEb(disabled: bool) void;
pub const BeginDisabled = _ZN5ImGui13BeginDisabledEb;

extern fn _ZN5ImGui11EndDisabledEv() void;
pub const EndDisabled = _ZN5ImGui11EndDisabledEv;

extern fn _ZN5ImGui12PushClipRectERK6ImVec2S2_b(clip_rect_min: *const ImVec2, clip_rect_max: *const ImVec2, intersect_with_current_clip_rect: bool) void;
pub const PushClipRect = _ZN5ImGui12PushClipRectERK6ImVec2S2_b;

extern fn _ZN5ImGui11PopClipRectEv() void;
pub const PopClipRect = _ZN5ImGui11PopClipRectEv;

extern fn _ZN5ImGui19SetItemDefaultFocusEv() void;
pub const SetItemDefaultFocus = _ZN5ImGui19SetItemDefaultFocusEv;

extern fn _ZN5ImGui20SetKeyboardFocusHereEi(offset: c_int) void;
pub const SetKeyboardFocusHere = _ZN5ImGui20SetKeyboardFocusHereEi;

extern fn _ZN5ImGui13IsItemHoveredEi(flags: ImGuiHoveredFlags) bool;
pub const IsItemHovered = _ZN5ImGui13IsItemHoveredEi;

extern fn _ZN5ImGui12IsItemActiveEv() bool;
pub const IsItemActive = _ZN5ImGui12IsItemActiveEv;

extern fn _ZN5ImGui13IsItemFocusedEv() bool;
pub const IsItemFocused = _ZN5ImGui13IsItemFocusedEv;

extern fn _ZN5ImGui13IsItemClickedEi(mouse_button: ImGuiMouseButton) bool;
pub const IsItemClicked = _ZN5ImGui13IsItemClickedEi;

extern fn _ZN5ImGui13IsItemVisibleEv() bool;
pub const IsItemVisible = _ZN5ImGui13IsItemVisibleEv;

extern fn _ZN5ImGui12IsItemEditedEv() bool;
pub const IsItemEdited = _ZN5ImGui12IsItemEditedEv;

extern fn _ZN5ImGui15IsItemActivatedEv() bool;
pub const IsItemActivated = _ZN5ImGui15IsItemActivatedEv;

extern fn _ZN5ImGui17IsItemDeactivatedEv() bool;
pub const IsItemDeactivated = _ZN5ImGui17IsItemDeactivatedEv;

extern fn _ZN5ImGui26IsItemDeactivatedAfterEditEv() bool;
pub const IsItemDeactivatedAfterEdit = _ZN5ImGui26IsItemDeactivatedAfterEditEv;

extern fn _ZN5ImGui17IsItemToggledOpenEv() bool;
pub const IsItemToggledOpen = _ZN5ImGui17IsItemToggledOpenEv;

extern fn _ZN5ImGui16IsAnyItemHoveredEv() bool;
pub const IsAnyItemHovered = _ZN5ImGui16IsAnyItemHoveredEv;

extern fn _ZN5ImGui15IsAnyItemActiveEv() bool;
pub const IsAnyItemActive = _ZN5ImGui15IsAnyItemActiveEv;

extern fn _ZN5ImGui16IsAnyItemFocusedEv() bool;
pub const IsAnyItemFocused = _ZN5ImGui16IsAnyItemFocusedEv;

extern fn _ZN5ImGui9GetItemIDEv() ImGuiID;
pub const GetItemID = _ZN5ImGui9GetItemIDEv;

extern fn _ZN5ImGui14GetItemRectMinEv() ImVec2;
pub const GetItemRectMin = _ZN5ImGui14GetItemRectMinEv;

extern fn _ZN5ImGui14GetItemRectMaxEv() ImVec2;
pub const GetItemRectMax = _ZN5ImGui14GetItemRectMaxEv;

extern fn _ZN5ImGui15GetItemRectSizeEv() ImVec2;
pub const GetItemRectSize = _ZN5ImGui15GetItemRectSizeEv;

extern fn _ZN5ImGui19SetItemAllowOverlapEv() void;
pub const SetItemAllowOverlap = _ZN5ImGui19SetItemAllowOverlapEv;

extern fn _ZN5ImGui15GetMainViewportEv() [*c]ImGuiViewport;
pub const GetMainViewport = _ZN5ImGui15GetMainViewportEv;

extern fn _ZN5ImGui21GetBackgroundDrawListEv() [*c]ImDrawList;
pub const GetBackgroundDrawList = _ZN5ImGui21GetBackgroundDrawListEv;

extern fn _ZN5ImGui21GetForegroundDrawListEv() [*c]ImDrawList;
pub const GetForegroundDrawList = _ZN5ImGui21GetForegroundDrawListEv;

extern fn _ZN5ImGui21GetBackgroundDrawListEP13ImGuiViewport(viewport: [*c]ImGuiViewport) [*c]ImDrawList;
pub const GetBackgroundDrawList__Overload2 = _ZN5ImGui21GetBackgroundDrawListEP13ImGuiViewport;

extern fn _ZN5ImGui21GetForegroundDrawListEP13ImGuiViewport(viewport: [*c]ImGuiViewport) [*c]ImDrawList;
pub const GetForegroundDrawList__Overload2 = _ZN5ImGui21GetForegroundDrawListEP13ImGuiViewport;

extern fn _ZN5ImGui13IsRectVisibleERK6ImVec2(size: *const ImVec2) bool;
pub const IsRectVisible = _ZN5ImGui13IsRectVisibleERK6ImVec2;

extern fn _ZN5ImGui13IsRectVisibleERK6ImVec2S2_(rect_min: *const ImVec2, rect_max: *const ImVec2) bool;
pub const IsRectVisible__Overload2 = _ZN5ImGui13IsRectVisibleERK6ImVec2S2_;

extern fn _ZN5ImGui7GetTimeEv() f64;
pub const GetTime = _ZN5ImGui7GetTimeEv;

extern fn _ZN5ImGui13GetFrameCountEv() c_int;
pub const GetFrameCount = _ZN5ImGui13GetFrameCountEv;

extern fn _ZN5ImGui21GetDrawListSharedDataEv() ?*ImDrawListSharedData;
pub const GetDrawListSharedData = _ZN5ImGui21GetDrawListSharedDataEv;

extern fn _ZN5ImGui17GetStyleColorNameEi(idx: ImGuiCol) [*c]const u8;
pub const GetStyleColorName = _ZN5ImGui17GetStyleColorNameEi;

extern fn _ZN5ImGui15SetStateStorageEP12ImGuiStorage(storage: [*c]ImGuiStorage) void;
pub const SetStateStorage = _ZN5ImGui15SetStateStorageEP12ImGuiStorage;

extern fn _ZN5ImGui15GetStateStorageEv() [*c]ImGuiStorage;
pub const GetStateStorage = _ZN5ImGui15GetStateStorageEv;

extern fn _ZN5ImGui15BeginChildFrameEjRK6ImVec2i(id: ImGuiID, size: *const ImVec2, flags: ImGuiWindowFlags) bool;
pub const BeginChildFrame = _ZN5ImGui15BeginChildFrameEjRK6ImVec2i;

extern fn _ZN5ImGui13EndChildFrameEv() void;
pub const EndChildFrame = _ZN5ImGui13EndChildFrameEv;

extern fn _ZN5ImGui12CalcTextSizeEPKcS1_bf(text: [*c]const u8, text_end: [*c]const u8, hide_text_after_double_hash: bool, wrap_width: f32) ImVec2;
pub const CalcTextSize = _ZN5ImGui12CalcTextSizeEPKcS1_bf;

extern fn _ZN5ImGui23ColorConvertU32ToFloat4Ej(in: ImU32) ImVec4;
pub const ColorConvertU32ToFloat4 = _ZN5ImGui23ColorConvertU32ToFloat4Ej;

extern fn _ZN5ImGui23ColorConvertFloat4ToU32ERK6ImVec4(in: *const ImVec4) ImU32;
pub const ColorConvertFloat4ToU32 = _ZN5ImGui23ColorConvertFloat4ToU32ERK6ImVec4;

extern fn _ZN5ImGui20ColorConvertRGBtoHSVEfffRfS0_S0_(r: f32, g: f32, b: f32, out_h: *f32, out_s: *f32, out_v: *f32) void;
pub const ColorConvertRGBtoHSV = _ZN5ImGui20ColorConvertRGBtoHSVEfffRfS0_S0_;

extern fn _ZN5ImGui20ColorConvertHSVtoRGBEfffRfS0_S0_(h: f32, s: f32, v: f32, out_r: *f32, out_g: *f32, out_b: *f32) void;
pub const ColorConvertHSVtoRGB = _ZN5ImGui20ColorConvertHSVtoRGBEfffRfS0_S0_;

extern fn _ZN5ImGui9IsKeyDownE8ImGuiKey(key: ImGuiKey) bool;
pub const IsKeyDown = _ZN5ImGui9IsKeyDownE8ImGuiKey;

extern fn _ZN5ImGui12IsKeyPressedE8ImGuiKeyb(key: ImGuiKey, repeat: bool) bool;
pub const IsKeyPressed = _ZN5ImGui12IsKeyPressedE8ImGuiKeyb;

extern fn _ZN5ImGui13IsKeyReleasedE8ImGuiKey(key: ImGuiKey) bool;
pub const IsKeyReleased = _ZN5ImGui13IsKeyReleasedE8ImGuiKey;

extern fn _ZN5ImGui19GetKeyPressedAmountE8ImGuiKeyff(key: ImGuiKey, repeat_delay: f32, rate: f32) c_int;
pub const GetKeyPressedAmount = _ZN5ImGui19GetKeyPressedAmountE8ImGuiKeyff;

extern fn _ZN5ImGui10GetKeyNameE8ImGuiKey(key: ImGuiKey) [*c]const u8;
pub const GetKeyName = _ZN5ImGui10GetKeyNameE8ImGuiKey;

extern fn _ZN5ImGui31SetNextFrameWantCaptureKeyboardEb(want_capture_keyboard: bool) void;
pub const SetNextFrameWantCaptureKeyboard = _ZN5ImGui31SetNextFrameWantCaptureKeyboardEb;

extern fn _ZN5ImGui11IsMouseDownEi(button: ImGuiMouseButton) bool;
pub const IsMouseDown = _ZN5ImGui11IsMouseDownEi;

extern fn _ZN5ImGui14IsMouseClickedEib(button: ImGuiMouseButton, repeat: bool) bool;
pub const IsMouseClicked = _ZN5ImGui14IsMouseClickedEib;

extern fn _ZN5ImGui15IsMouseReleasedEi(button: ImGuiMouseButton) bool;
pub const IsMouseReleased = _ZN5ImGui15IsMouseReleasedEi;

extern fn _ZN5ImGui20IsMouseDoubleClickedEi(button: ImGuiMouseButton) bool;
pub const IsMouseDoubleClicked = _ZN5ImGui20IsMouseDoubleClickedEi;

extern fn _ZN5ImGui20GetMouseClickedCountEi(button: ImGuiMouseButton) c_int;
pub const GetMouseClickedCount = _ZN5ImGui20GetMouseClickedCountEi;

extern fn _ZN5ImGui19IsMouseHoveringRectERK6ImVec2S2_b(r_min: *const ImVec2, r_max: *const ImVec2, clip: bool) bool;
pub const IsMouseHoveringRect = _ZN5ImGui19IsMouseHoveringRectERK6ImVec2S2_b;

extern fn _ZN5ImGui15IsMousePosValidEPK6ImVec2(mouse_pos: [*c]const ImVec2) bool;
pub const IsMousePosValid = _ZN5ImGui15IsMousePosValidEPK6ImVec2;

extern fn _ZN5ImGui14IsAnyMouseDownEv() bool;
pub const IsAnyMouseDown = _ZN5ImGui14IsAnyMouseDownEv;

extern fn _ZN5ImGui11GetMousePosEv() ImVec2;
pub const GetMousePos = _ZN5ImGui11GetMousePosEv;

extern fn _ZN5ImGui32GetMousePosOnOpeningCurrentPopupEv() ImVec2;
pub const GetMousePosOnOpeningCurrentPopup = _ZN5ImGui32GetMousePosOnOpeningCurrentPopupEv;

extern fn _ZN5ImGui15IsMouseDraggingEif(button: ImGuiMouseButton, lock_threshold: f32) bool;
pub const IsMouseDragging = _ZN5ImGui15IsMouseDraggingEif;

extern fn _ZN5ImGui17GetMouseDragDeltaEif(button: ImGuiMouseButton, lock_threshold: f32) ImVec2;
pub const GetMouseDragDelta = _ZN5ImGui17GetMouseDragDeltaEif;

extern fn _ZN5ImGui19ResetMouseDragDeltaEi(button: ImGuiMouseButton) void;
pub const ResetMouseDragDelta = _ZN5ImGui19ResetMouseDragDeltaEi;

extern fn _ZN5ImGui14GetMouseCursorEv() ImGuiMouseCursor;
pub const GetMouseCursor = _ZN5ImGui14GetMouseCursorEv;

extern fn _ZN5ImGui14SetMouseCursorEi(cursor_type: ImGuiMouseCursor) void;
pub const SetMouseCursor = _ZN5ImGui14SetMouseCursorEi;

extern fn _ZN5ImGui28SetNextFrameWantCaptureMouseEb(want_capture_mouse: bool) void;
pub const SetNextFrameWantCaptureMouse = _ZN5ImGui28SetNextFrameWantCaptureMouseEb;

extern fn _ZN5ImGui16GetClipboardTextEv() [*c]const u8;
pub const GetClipboardText = _ZN5ImGui16GetClipboardTextEv;

extern fn _ZN5ImGui16SetClipboardTextEPKc(text: [*c]const u8) void;
pub const SetClipboardText = _ZN5ImGui16SetClipboardTextEPKc;

extern fn _ZN5ImGui23LoadIniSettingsFromDiskEPKc(ini_filename: [*c]const u8) void;
pub const LoadIniSettingsFromDisk = _ZN5ImGui23LoadIniSettingsFromDiskEPKc;

extern fn _ZN5ImGui25LoadIniSettingsFromMemoryEPKcy(ini_data: [*c]const u8, ini_size: usize) void;
pub const LoadIniSettingsFromMemory = _ZN5ImGui25LoadIniSettingsFromMemoryEPKcy;

extern fn _ZN5ImGui21SaveIniSettingsToDiskEPKc(ini_filename: [*c]const u8) void;
pub const SaveIniSettingsToDisk = _ZN5ImGui21SaveIniSettingsToDiskEPKc;

extern fn _ZN5ImGui23SaveIniSettingsToMemoryEPy(out_ini_size: [*c]usize) [*c]const u8;
pub const SaveIniSettingsToMemory = _ZN5ImGui23SaveIniSettingsToMemoryEPy;

extern fn _ZN5ImGui17DebugTextEncodingEPKc(text: [*c]const u8) void;
pub const DebugTextEncoding = _ZN5ImGui17DebugTextEncodingEPKc;

extern fn _ZN5ImGui30DebugCheckVersionAndDataLayoutEPKcyyyyyy(version_str: [*c]const u8, sz_io: usize, sz_style: usize, sz_vec2: usize, sz_vec4: usize, sz_drawvert: usize, sz_drawidx: usize) bool;
pub const DebugCheckVersionAndDataLayout = _ZN5ImGui30DebugCheckVersionAndDataLayoutEPKcyyyyyy;

extern fn _ZN5ImGui21SetAllocatorFunctionsEPFPvyS0_EPFvS0_S0_ES0_(alloc_func: ImGuiMemAllocFunc, free_func: ImGuiMemFreeFunc, user_data: ?*anyopaque) void;
pub const SetAllocatorFunctions = _ZN5ImGui21SetAllocatorFunctionsEPFPvyS0_EPFvS0_S0_ES0_;

extern fn _ZN5ImGui21GetAllocatorFunctionsEPPFPvyS0_EPPFvS0_S0_EPS0_(p_alloc_func: [*c]ImGuiMemAllocFunc, p_free_func: [*c]ImGuiMemFreeFunc, p_user_data: [*c]?*anyopaque) void;
pub const GetAllocatorFunctions = _ZN5ImGui21GetAllocatorFunctionsEPPFPvyS0_EPPFvS0_S0_EPS0_;

extern fn _ZN5ImGui8MemAllocEy(size: usize) ?*anyopaque;
pub const MemAlloc = _ZN5ImGui8MemAllocEy;

extern fn _ZN5ImGui7MemFreeEPv(ptr: ?*anyopaque) void;
pub const MemFree = _ZN5ImGui7MemFreeEPv;

extern fn _ZN5ImGui13GetPlatformIOEv() *ImGuiPlatformIO;
pub const GetPlatformIO = _ZN5ImGui13GetPlatformIOEv;

extern fn _ZN5ImGui21UpdatePlatformWindowsEv() void;
pub const UpdatePlatformWindows = _ZN5ImGui21UpdatePlatformWindowsEv;

extern fn _ZN5ImGui28RenderPlatformWindowsDefaultEPvS0_(platform_render_arg: ?*anyopaque, renderer_render_arg: ?*anyopaque) void;
pub const RenderPlatformWindowsDefault = _ZN5ImGui28RenderPlatformWindowsDefaultEPvS0_;

extern fn _ZN5ImGui22DestroyPlatformWindowsEv() void;
pub const DestroyPlatformWindows = _ZN5ImGui22DestroyPlatformWindowsEv;

extern fn _ZN5ImGui16FindViewportByIDEj(id: ImGuiID) [*c]ImGuiViewport;
pub const FindViewportByID = _ZN5ImGui16FindViewportByIDEj;

extern fn _ZN5ImGui28FindViewportByPlatformHandleEPv(platform_handle: ?*anyopaque) [*c]ImGuiViewport;
pub const FindViewportByPlatformHandle = _ZN5ImGui28FindViewportByPlatformHandleEPv;

pub const ImGuiWindowFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const NoTitleBar: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const NoResize: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const NoMove: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const NoScrollbar: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const NoScrollWithMouse: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const NoCollapse: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const AlwaysAutoResize: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const NoBackground: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const NoSavedSettings: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 8) };
    pub const NoMouseInputs: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 9) };
    pub const MenuBar: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const HorizontalScrollbar: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 11) };
    pub const NoFocusOnAppearing: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 12) };
    pub const NoBringToFrontOnFocus: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 13) };
    pub const AlwaysVerticalScrollbar: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 14) };
    pub const AlwaysHorizontalScrollbar: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 15) };
    pub const AlwaysUseWindowPadding: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 16) };
    pub const NoNavInputs: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 18) };
    pub const NoNavFocus: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 19) };
    pub const UnsavedDocument: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 20) };
    pub const NoDocking: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 21) };
    pub const NoNav: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, ImGuiWindowFlags_.NoNavInputs.bits | ImGuiWindowFlags_.NoNavFocus.bits) };
    pub const NoDecoration: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, ImGuiWindowFlags_.NoTitleBar.bits | ImGuiWindowFlags_.NoResize.bits | ImGuiWindowFlags_.NoScrollbar.bits | ImGuiWindowFlags_.NoCollapse.bits) };
    pub const NoInputs: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, ImGuiWindowFlags_.NoMouseInputs.bits | ImGuiWindowFlags_.NoNavInputs.bits | ImGuiWindowFlags_.NoNavFocus.bits) };
    pub const NavFlattened: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 23) };
    pub const ChildWindow: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 24) };
    pub const Tooltip: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 25) };
    pub const Popup: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 26) };
    pub const Modal: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 27) };
    pub const ChildMenu: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 28) };
    pub const DockNodeHost: ImGuiWindowFlags_ = .{ .bits = @intCast(c_uint, 1 << 29) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiWindowFlags_);
};

pub const ImGuiInputTextFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const CharsDecimal: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const CharsHexadecimal: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const CharsUppercase: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const CharsNoBlank: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const AutoSelectAll: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const EnterReturnsTrue: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const CallbackCompletion: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const CallbackHistory: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const CallbackAlways: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 8) };
    pub const CallbackCharFilter: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 9) };
    pub const AllowTabInput: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const CtrlEnterForNewLine: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 11) };
    pub const NoHorizontalScroll: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 12) };
    pub const AlwaysOverwrite: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 13) };
    pub const ReadOnly: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 14) };
    pub const Password: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 15) };
    pub const NoUndoRedo: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 16) };
    pub const CharsScientific: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 17) };
    pub const CallbackResize: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 18) };
    pub const CallbackEdit: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 19) };
    pub const EscapeClearsAll: ImGuiInputTextFlags_ = .{ .bits = @intCast(c_uint, 1 << 20) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiInputTextFlags_);
};

pub const ImGuiTreeNodeFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const Selected: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const Framed: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const AllowItemOverlap: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const NoTreePushOnOpen: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const NoAutoOpenOnLog: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const DefaultOpen: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const OpenOnDoubleClick: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const OpenOnArrow: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const Leaf: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 8) };
    pub const Bullet: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 9) };
    pub const FramePadding: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const SpanAvailWidth: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 11) };
    pub const SpanFullWidth: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 12) };
    pub const NavLeftJumpsBackHere: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 13) };
    pub const CollapsingHeader: ImGuiTreeNodeFlags_ = .{ .bits = @intCast(c_uint, ImGuiTreeNodeFlags_.Framed.bits | ImGuiTreeNodeFlags_.NoTreePushOnOpen.bits | ImGuiTreeNodeFlags_.NoAutoOpenOnLog.bits) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiTreeNodeFlags_);
};

pub const ImGuiPopupFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const MouseButtonLeft: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const MouseButtonRight: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, 1) };
    pub const MouseButtonMiddle: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, 2) };
    pub const MouseButtonMask_: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, 31) };
    pub const MouseButtonDefault_: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, 1) };
    pub const NoOpenOverExistingPopup: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const NoOpenOverItems: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const AnyPopupId: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const AnyPopupLevel: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, 1 << 8) };
    pub const AnyPopup: ImGuiPopupFlags_ = .{ .bits = @intCast(c_uint, ImGuiPopupFlags_.AnyPopupId.bits | ImGuiPopupFlags_.AnyPopupLevel.bits) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiPopupFlags_);
};

pub const ImGuiSelectableFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiSelectableFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const DontClosePopups: ImGuiSelectableFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const SpanAllColumns: ImGuiSelectableFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const AllowDoubleClick: ImGuiSelectableFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const Disabled: ImGuiSelectableFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const AllowItemOverlap: ImGuiSelectableFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiSelectableFlags_);
};

pub const ImGuiComboFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiComboFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const PopupAlignLeft: ImGuiComboFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const HeightSmall: ImGuiComboFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const HeightRegular: ImGuiComboFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const HeightLarge: ImGuiComboFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const HeightLargest: ImGuiComboFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const NoArrowButton: ImGuiComboFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const NoPreview: ImGuiComboFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const HeightMask_: ImGuiComboFlags_ = .{ .bits = @intCast(c_uint, ImGuiComboFlags_.HeightSmall.bits | ImGuiComboFlags_.HeightRegular.bits | ImGuiComboFlags_.HeightLarge.bits | ImGuiComboFlags_.HeightLargest.bits) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiComboFlags_);
};

pub const ImGuiTabBarFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const Reorderable: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const AutoSelectNewTabs: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const TabListPopupButton: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const NoCloseWithMiddleMouseButton: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const NoTabListScrollingButtons: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const NoTooltip: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const FittingPolicyResizeDown: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const FittingPolicyScroll: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const FittingPolicyMask_: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, ImGuiTabBarFlags_.FittingPolicyResizeDown.bits | ImGuiTabBarFlags_.FittingPolicyScroll.bits) };
    pub const FittingPolicyDefault_: ImGuiTabBarFlags_ = .{ .bits = @intCast(c_uint, ImGuiTabBarFlags_.FittingPolicyResizeDown.bits) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiTabBarFlags_);
};

pub const ImGuiTabItemFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiTabItemFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const UnsavedDocument: ImGuiTabItemFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const SetSelected: ImGuiTabItemFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const NoCloseWithMiddleMouseButton: ImGuiTabItemFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const NoPushId: ImGuiTabItemFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const NoTooltip: ImGuiTabItemFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const NoReorder: ImGuiTabItemFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const Leading: ImGuiTabItemFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const Trailing: ImGuiTabItemFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiTabItemFlags_);
};

pub const ImGuiTableFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const Resizable: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const Reorderable: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const Hideable: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const Sortable: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const NoSavedSettings: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const ContextMenuInBody: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const RowBg: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const BordersInnerH: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const BordersOuterH: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 8) };
    pub const BordersInnerV: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 9) };
    pub const BordersOuterV: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const BordersH: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, ImGuiTableFlags_.BordersInnerH.bits | ImGuiTableFlags_.BordersOuterH.bits) };
    pub const BordersV: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, ImGuiTableFlags_.BordersInnerV.bits | ImGuiTableFlags_.BordersOuterV.bits) };
    pub const BordersInner: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, ImGuiTableFlags_.BordersInnerV.bits | ImGuiTableFlags_.BordersInnerH.bits) };
    pub const BordersOuter: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, ImGuiTableFlags_.BordersOuterV.bits | ImGuiTableFlags_.BordersOuterH.bits) };
    pub const Borders: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, ImGuiTableFlags_.BordersInner.bits | ImGuiTableFlags_.BordersOuter.bits) };
    pub const NoBordersInBody: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 11) };
    pub const NoBordersInBodyUntilResize: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 12) };
    pub const SizingFixedFit: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 13) };
    pub const SizingFixedSame: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 2 << 13) };
    pub const SizingStretchProp: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 3 << 13) };
    pub const SizingStretchSame: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 4 << 13) };
    pub const NoHostExtendX: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 16) };
    pub const NoHostExtendY: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 17) };
    pub const NoKeepColumnsVisible: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 18) };
    pub const PreciseWidths: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 19) };
    pub const NoClip: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 20) };
    pub const PadOuterX: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 21) };
    pub const NoPadOuterX: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 22) };
    pub const NoPadInnerX: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 23) };
    pub const ScrollX: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 24) };
    pub const ScrollY: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 25) };
    pub const SortMulti: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 26) };
    pub const SortTristate: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, 1 << 27) };
    pub const SizingMask_: ImGuiTableFlags_ = .{ .bits = @intCast(c_uint, ImGuiTableFlags_.SizingFixedFit.bits | ImGuiTableFlags_.SizingFixedSame.bits | ImGuiTableFlags_.SizingStretchProp.bits | ImGuiTableFlags_.SizingStretchSame.bits) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiTableFlags_);
};

pub const ImGuiTableColumnFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const Disabled: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const DefaultHide: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const DefaultSort: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const WidthStretch: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const WidthFixed: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const NoResize: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const NoReorder: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const NoHide: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const NoClip: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 8) };
    pub const NoSort: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 9) };
    pub const NoSortAscending: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const NoSortDescending: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 11) };
    pub const NoHeaderLabel: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 12) };
    pub const NoHeaderWidth: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 13) };
    pub const PreferSortAscending: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 14) };
    pub const PreferSortDescending: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 15) };
    pub const IndentEnable: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 16) };
    pub const IndentDisable: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 17) };
    pub const IsEnabled: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 24) };
    pub const IsVisible: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 25) };
    pub const IsSorted: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 26) };
    pub const IsHovered: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 27) };
    pub const WidthMask_: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, ImGuiTableColumnFlags_.WidthStretch.bits | ImGuiTableColumnFlags_.WidthFixed.bits) };
    pub const IndentMask_: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, ImGuiTableColumnFlags_.IndentEnable.bits | ImGuiTableColumnFlags_.IndentDisable.bits) };
    pub const StatusMask_: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, ImGuiTableColumnFlags_.IsEnabled.bits | ImGuiTableColumnFlags_.IsVisible.bits | ImGuiTableColumnFlags_.IsSorted.bits | ImGuiTableColumnFlags_.IsHovered.bits) };
    pub const NoDirectResize_: ImGuiTableColumnFlags_ = .{ .bits = @intCast(c_uint, 1 << 30) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiTableColumnFlags_);
};

pub const ImGuiTableRowFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiTableRowFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const Headers: ImGuiTableRowFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiTableRowFlags_);
};

pub const ImGuiTableBgTarget_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiTableBgTarget_ = .{ .bits = @intCast(c_uint, 0) };
    pub const RowBg0: ImGuiTableBgTarget_ = .{ .bits = @intCast(c_uint, 1) };
    pub const RowBg1: ImGuiTableBgTarget_ = .{ .bits = @intCast(c_uint, 2) };
    pub const CellBg: ImGuiTableBgTarget_ = .{ .bits = @intCast(c_uint, 3) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiTableBgTarget_);
};

pub const ImGuiFocusedFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiFocusedFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const ChildWindows: ImGuiFocusedFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const RootWindow: ImGuiFocusedFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const AnyWindow: ImGuiFocusedFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const NoPopupHierarchy: ImGuiFocusedFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const DockHierarchy: ImGuiFocusedFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const RootAndChildWindows: ImGuiFocusedFlags_ = .{ .bits = @intCast(c_uint, ImGuiFocusedFlags_.RootWindow.bits | ImGuiFocusedFlags_.ChildWindows.bits) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiFocusedFlags_);
};

pub const ImGuiHoveredFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const ChildWindows: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const RootWindow: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const AnyWindow: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const NoPopupHierarchy: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const DockHierarchy: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const AllowWhenBlockedByPopup: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const AllowWhenBlockedByActiveItem: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const AllowWhenOverlapped: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 8) };
    pub const AllowWhenDisabled: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 9) };
    pub const NoNavOverride: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const RectOnly: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, ImGuiHoveredFlags_.AllowWhenBlockedByPopup.bits | ImGuiHoveredFlags_.AllowWhenBlockedByActiveItem.bits | ImGuiHoveredFlags_.AllowWhenOverlapped.bits) };
    pub const RootAndChildWindows: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, ImGuiHoveredFlags_.RootWindow.bits | ImGuiHoveredFlags_.ChildWindows.bits) };
    pub const DelayNormal: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 11) };
    pub const DelayShort: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 12) };
    pub const NoSharedDelay: ImGuiHoveredFlags_ = .{ .bits = @intCast(c_uint, 1 << 13) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiHoveredFlags_);
};

pub const ImGuiDockNodeFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiDockNodeFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const KeepAliveOnly: ImGuiDockNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const NoDockingInCentralNode: ImGuiDockNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const PassthruCentralNode: ImGuiDockNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const NoSplit: ImGuiDockNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const NoResize: ImGuiDockNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const AutoHideTabBar: ImGuiDockNodeFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiDockNodeFlags_);
};

pub const ImGuiDragDropFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const SourceNoPreviewTooltip: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const SourceNoDisableHover: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const SourceNoHoldToOpenOthers: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const SourceAllowNullID: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const SourceExtern: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const SourceAutoExpirePayload: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const AcceptBeforeDelivery: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const AcceptNoDrawDefaultRect: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, 1 << 11) };
    pub const AcceptNoPreviewTooltip: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, 1 << 12) };
    pub const AcceptPeekOnly: ImGuiDragDropFlags_ = .{ .bits = @intCast(c_uint, ImGuiDragDropFlags_.AcceptBeforeDelivery.bits | ImGuiDragDropFlags_.AcceptNoDrawDefaultRect.bits) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiDragDropFlags_);
};

pub const ImGuiDataType_ = extern struct {
    bits: c_int = 0,

    pub const S8: ImGuiDataType_ = .{ .bits = 0 };
    pub const U8: ImGuiDataType_ = .{ .bits = 1 };
    pub const S16: ImGuiDataType_ = .{ .bits = 2 };
    pub const U16: ImGuiDataType_ = .{ .bits = 3 };
    pub const S32: ImGuiDataType_ = .{ .bits = 4 };
    pub const U32: ImGuiDataType_ = .{ .bits = 5 };
    pub const S64: ImGuiDataType_ = .{ .bits = 6 };
    pub const U64: ImGuiDataType_ = .{ .bits = 7 };
    pub const Float: ImGuiDataType_ = .{ .bits = 8 };
    pub const Double: ImGuiDataType_ = .{ .bits = 9 };
    pub const COUNT: ImGuiDataType_ = .{ .bits = 10 };

    // pub usingnamespace cpp.FlagsMixin(ImGuiDataType_);
};

pub const ImGuiDir_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiDir_ = .{ .bits = -1 };
    pub const Left: ImGuiDir_ = .{ .bits = 0 };
    pub const Right: ImGuiDir_ = .{ .bits = 1 };
    pub const Up: ImGuiDir_ = .{ .bits = 2 };
    pub const Down: ImGuiDir_ = .{ .bits = 3 };
    pub const COUNT: ImGuiDir_ = .{ .bits = ImGuiDir_.Down.bits + 1 };

    // pub usingnamespace cpp.FlagsMixin(ImGuiDir_);
};

pub const ImGuiSortDirection_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiSortDirection_ = .{ .bits = @intCast(c_uint, 0) };
    pub const Ascending: ImGuiSortDirection_ = .{ .bits = @intCast(c_uint, 1) };
    pub const Descending: ImGuiSortDirection_ = .{ .bits = @intCast(c_uint, 2) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiSortDirection_);
};

pub const ImGuiKey = extern struct {
    bits: c_int = 0,

    pub const _None: ImGuiKey = .{ .bits = 0 };
    pub const _Tab: ImGuiKey = .{ .bits = 512 };
    pub const _LeftArrow: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 1 };
    pub const _RightArrow: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 2 };
    pub const _UpArrow: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 3 };
    pub const _DownArrow: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 4 };
    pub const _PageUp: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 5 };
    pub const _PageDown: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 6 };
    pub const _Home: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 7 };
    pub const _End: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 8 };
    pub const _Insert: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 9 };
    pub const _Delete: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 10 };
    pub const _Backspace: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 11 };
    pub const _Space: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 12 };
    pub const _Enter: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 13 };
    pub const _Escape: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 14 };
    pub const _LeftCtrl: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 15 };
    pub const _LeftShift: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 16 };
    pub const _LeftAlt: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 17 };
    pub const _LeftSuper: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 18 };
    pub const _RightCtrl: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 19 };
    pub const _RightShift: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 20 };
    pub const _RightAlt: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 21 };
    pub const _RightSuper: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 22 };
    pub const _Menu: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 23 };
    pub const _0: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 24 };
    pub const _1: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 25 };
    pub const _2: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 26 };
    pub const _3: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 27 };
    pub const _4: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 28 };
    pub const _5: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 29 };
    pub const _6: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 30 };
    pub const _7: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 31 };
    pub const _8: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 32 };
    pub const _9: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 33 };
    pub const _A: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 34 };
    pub const _B: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 35 };
    pub const _C: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 36 };
    pub const _D: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 37 };
    pub const _E: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 38 };
    pub const _F: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 39 };
    pub const _G: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 40 };
    pub const _H: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 41 };
    pub const _I: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 42 };
    pub const _J: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 43 };
    pub const _K: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 44 };
    pub const _L: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 45 };
    pub const _M: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 46 };
    pub const _N: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 47 };
    pub const _O: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 48 };
    pub const _P: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 49 };
    pub const _Q: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 50 };
    pub const _R: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 51 };
    pub const _S: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 52 };
    pub const _T: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 53 };
    pub const _U: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 54 };
    pub const _V: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 55 };
    pub const _W: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 56 };
    pub const _X: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 57 };
    pub const _Y: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 58 };
    pub const _Z: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 59 };
    pub const _F1: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 60 };
    pub const _F2: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 61 };
    pub const _F3: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 62 };
    pub const _F4: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 63 };
    pub const _F5: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 64 };
    pub const _F6: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 65 };
    pub const _F7: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 66 };
    pub const _F8: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 67 };
    pub const _F9: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 68 };
    pub const _F10: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 69 };
    pub const _F11: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 70 };
    pub const _F12: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 71 };
    pub const _Apostrophe: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 72 };
    pub const _Comma: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 73 };
    pub const _Minus: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 74 };
    pub const _Period: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 75 };
    pub const _Slash: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 76 };
    pub const _Semicolon: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 77 };
    pub const _Equal: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 78 };
    pub const _LeftBracket: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 79 };
    pub const _Backslash: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 80 };
    pub const _RightBracket: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 81 };
    pub const _GraveAccent: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 82 };
    pub const _CapsLock: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 83 };
    pub const _ScrollLock: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 84 };
    pub const _NumLock: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 85 };
    pub const _PrintScreen: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 86 };
    pub const _Pause: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 87 };
    pub const _Keypad0: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 88 };
    pub const _Keypad1: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 89 };
    pub const _Keypad2: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 90 };
    pub const _Keypad3: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 91 };
    pub const _Keypad4: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 92 };
    pub const _Keypad5: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 93 };
    pub const _Keypad6: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 94 };
    pub const _Keypad7: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 95 };
    pub const _Keypad8: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 96 };
    pub const _Keypad9: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 97 };
    pub const _KeypadDecimal: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 98 };
    pub const _KeypadDivide: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 99 };
    pub const _KeypadMultiply: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 100 };
    pub const _KeypadSubtract: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 101 };
    pub const _KeypadAdd: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 102 };
    pub const _KeypadEnter: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 103 };
    pub const _KeypadEqual: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 104 };
    pub const _GamepadStart: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 105 };
    pub const _GamepadBack: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 106 };
    pub const _GamepadFaceLeft: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 107 };
    pub const _GamepadFaceRight: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 108 };
    pub const _GamepadFaceUp: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 109 };
    pub const _GamepadFaceDown: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 110 };
    pub const _GamepadDpadLeft: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 111 };
    pub const _GamepadDpadRight: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 112 };
    pub const _GamepadDpadUp: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 113 };
    pub const _GamepadDpadDown: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 114 };
    pub const _GamepadL1: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 115 };
    pub const _GamepadR1: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 116 };
    pub const _GamepadL2: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 117 };
    pub const _GamepadR2: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 118 };
    pub const _GamepadL3: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 119 };
    pub const _GamepadR3: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 120 };
    pub const _GamepadLStickLeft: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 121 };
    pub const _GamepadLStickRight: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 122 };
    pub const _GamepadLStickUp: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 123 };
    pub const _GamepadLStickDown: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 124 };
    pub const _GamepadRStickLeft: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 125 };
    pub const _GamepadRStickRight: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 126 };
    pub const _GamepadRStickUp: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 127 };
    pub const _GamepadRStickDown: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 128 };
    pub const _MouseLeft: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 129 };
    pub const _MouseRight: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 130 };
    pub const _MouseMiddle: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 131 };
    pub const _MouseX1: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 132 };
    pub const _MouseX2: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 133 };
    pub const _MouseWheelX: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 134 };
    pub const _MouseWheelY: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 135 };
    pub const _ReservedForModCtrl: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 136 };
    pub const _ReservedForModShift: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 137 };
    pub const _ReservedForModAlt: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 138 };
    pub const _ReservedForModSuper: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 139 };
    pub const _COUNT: ImGuiKey = .{ .bits = ImGuiKey._Tab.bits + 140 };
    pub const ImGuiMod_None: ImGuiKey = .{ .bits = 0 };
    pub const ImGuiMod_Ctrl: ImGuiKey = .{ .bits = 1 << 12 };
    pub const ImGuiMod_Shift: ImGuiKey = .{ .bits = 1 << 13 };
    pub const ImGuiMod_Alt: ImGuiKey = .{ .bits = 1 << 14 };
    pub const ImGuiMod_Super: ImGuiKey = .{ .bits = 1 << 15 };
    pub const ImGuiMod_Shortcut: ImGuiKey = .{ .bits = 1 << 11 };
    pub const ImGuiMod_Mask_: ImGuiKey = .{ .bits = 63488 };
    pub const _NamedKey_BEGIN: ImGuiKey = .{ .bits = 512 };
    pub const _NamedKey_END: ImGuiKey = .{ .bits = ImGuiKey._COUNT.bits };
    pub const _NamedKey_COUNT: ImGuiKey = .{ .bits = ImGuiKey._NamedKey_END.bits - ImGuiKey._NamedKey_BEGIN.bits };
    pub const _KeysData_SIZE: ImGuiKey = .{ .bits = ImGuiKey._NamedKey_COUNT.bits };
    pub const _KeysData_OFFSET: ImGuiKey = .{ .bits = ImGuiKey._NamedKey_BEGIN.bits };

    // pub usingnamespace cpp.FlagsMixin(ImGuiKey);
};

pub const ImGuiConfigFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const NavEnableKeyboard: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const NavEnableGamepad: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const NavEnableSetMousePos: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const NavNoCaptureKeyboard: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const NoMouse: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const NoMouseCursorChange: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const DockingEnable: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const ViewportsEnable: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const DpiEnableScaleViewports: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 14) };
    pub const DpiEnableScaleFonts: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 15) };
    pub const IsSRGB: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 20) };
    pub const IsTouchScreen: ImGuiConfigFlags_ = .{ .bits = @intCast(c_uint, 1 << 21) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiConfigFlags_);
};

pub const ImGuiBackendFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiBackendFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const HasGamepad: ImGuiBackendFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const HasMouseCursors: ImGuiBackendFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const HasSetMousePos: ImGuiBackendFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const RendererHasVtxOffset: ImGuiBackendFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const PlatformHasViewports: ImGuiBackendFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const HasMouseHoveredViewport: ImGuiBackendFlags_ = .{ .bits = @intCast(c_uint, 1 << 11) };
    pub const RendererHasViewports: ImGuiBackendFlags_ = .{ .bits = @intCast(c_uint, 1 << 12) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiBackendFlags_);
};

pub const ImGuiCol_ = extern struct {
    bits: c_int = 0,

    pub const Text: ImGuiCol_ = .{ .bits = 0 };
    pub const TextDisabled: ImGuiCol_ = .{ .bits = 1 };
    pub const WindowBg: ImGuiCol_ = .{ .bits = 2 };
    pub const ChildBg: ImGuiCol_ = .{ .bits = 3 };
    pub const PopupBg: ImGuiCol_ = .{ .bits = 4 };
    pub const Border: ImGuiCol_ = .{ .bits = 5 };
    pub const BorderShadow: ImGuiCol_ = .{ .bits = 6 };
    pub const FrameBg: ImGuiCol_ = .{ .bits = 7 };
    pub const FrameBgHovered: ImGuiCol_ = .{ .bits = 8 };
    pub const FrameBgActive: ImGuiCol_ = .{ .bits = 9 };
    pub const TitleBg: ImGuiCol_ = .{ .bits = 10 };
    pub const TitleBgActive: ImGuiCol_ = .{ .bits = 11 };
    pub const TitleBgCollapsed: ImGuiCol_ = .{ .bits = 12 };
    pub const MenuBarBg: ImGuiCol_ = .{ .bits = 13 };
    pub const ScrollbarBg: ImGuiCol_ = .{ .bits = 14 };
    pub const ScrollbarGrab: ImGuiCol_ = .{ .bits = 15 };
    pub const ScrollbarGrabHovered: ImGuiCol_ = .{ .bits = 16 };
    pub const ScrollbarGrabActive: ImGuiCol_ = .{ .bits = 17 };
    pub const CheckMark: ImGuiCol_ = .{ .bits = 18 };
    pub const SliderGrab: ImGuiCol_ = .{ .bits = 19 };
    pub const SliderGrabActive: ImGuiCol_ = .{ .bits = 20 };
    pub const Button: ImGuiCol_ = .{ .bits = 21 };
    pub const ButtonHovered: ImGuiCol_ = .{ .bits = 22 };
    pub const ButtonActive: ImGuiCol_ = .{ .bits = 23 };
    pub const Header: ImGuiCol_ = .{ .bits = 24 };
    pub const HeaderHovered: ImGuiCol_ = .{ .bits = 25 };
    pub const HeaderActive: ImGuiCol_ = .{ .bits = 26 };
    pub const Separator: ImGuiCol_ = .{ .bits = 27 };
    pub const SeparatorHovered: ImGuiCol_ = .{ .bits = 28 };
    pub const SeparatorActive: ImGuiCol_ = .{ .bits = 29 };
    pub const ResizeGrip: ImGuiCol_ = .{ .bits = 30 };
    pub const ResizeGripHovered: ImGuiCol_ = .{ .bits = 31 };
    pub const ResizeGripActive: ImGuiCol_ = .{ .bits = 32 };
    pub const Tab: ImGuiCol_ = .{ .bits = 33 };
    pub const TabHovered: ImGuiCol_ = .{ .bits = 34 };
    pub const TabActive: ImGuiCol_ = .{ .bits = 35 };
    pub const TabUnfocused: ImGuiCol_ = .{ .bits = 36 };
    pub const TabUnfocusedActive: ImGuiCol_ = .{ .bits = 37 };
    pub const DockingPreview: ImGuiCol_ = .{ .bits = 38 };
    pub const DockingEmptyBg: ImGuiCol_ = .{ .bits = 39 };
    pub const PlotLines: ImGuiCol_ = .{ .bits = 40 };
    pub const PlotLinesHovered: ImGuiCol_ = .{ .bits = 41 };
    pub const PlotHistogram: ImGuiCol_ = .{ .bits = 42 };
    pub const PlotHistogramHovered: ImGuiCol_ = .{ .bits = 43 };
    pub const TableHeaderBg: ImGuiCol_ = .{ .bits = 44 };
    pub const TableBorderStrong: ImGuiCol_ = .{ .bits = 45 };
    pub const TableBorderLight: ImGuiCol_ = .{ .bits = 46 };
    pub const TableRowBg: ImGuiCol_ = .{ .bits = 47 };
    pub const TableRowBgAlt: ImGuiCol_ = .{ .bits = 48 };
    pub const TextSelectedBg: ImGuiCol_ = .{ .bits = 49 };
    pub const DragDropTarget: ImGuiCol_ = .{ .bits = 50 };
    pub const NavHighlight: ImGuiCol_ = .{ .bits = 51 };
    pub const NavWindowingHighlight: ImGuiCol_ = .{ .bits = 52 };
    pub const NavWindowingDimBg: ImGuiCol_ = .{ .bits = 53 };
    pub const ModalWindowDimBg: ImGuiCol_ = .{ .bits = 54 };
    pub const COUNT: ImGuiCol_ = .{ .bits = 55 };

    // pub usingnamespace cpp.FlagsMixin(ImGuiCol_);
};

pub const ImGuiStyleVar_ = extern struct {
    bits: c_int = 0,

    pub const Alpha: ImGuiStyleVar_ = .{ .bits = 0 };
    pub const DisabledAlpha: ImGuiStyleVar_ = .{ .bits = 1 };
    pub const WindowPadding: ImGuiStyleVar_ = .{ .bits = 2 };
    pub const WindowRounding: ImGuiStyleVar_ = .{ .bits = 3 };
    pub const WindowBorderSize: ImGuiStyleVar_ = .{ .bits = 4 };
    pub const WindowMinSize: ImGuiStyleVar_ = .{ .bits = 5 };
    pub const WindowTitleAlign: ImGuiStyleVar_ = .{ .bits = 6 };
    pub const ChildRounding: ImGuiStyleVar_ = .{ .bits = 7 };
    pub const ChildBorderSize: ImGuiStyleVar_ = .{ .bits = 8 };
    pub const PopupRounding: ImGuiStyleVar_ = .{ .bits = 9 };
    pub const PopupBorderSize: ImGuiStyleVar_ = .{ .bits = 10 };
    pub const FramePadding: ImGuiStyleVar_ = .{ .bits = 11 };
    pub const FrameRounding: ImGuiStyleVar_ = .{ .bits = 12 };
    pub const FrameBorderSize: ImGuiStyleVar_ = .{ .bits = 13 };
    pub const ItemSpacing: ImGuiStyleVar_ = .{ .bits = 14 };
    pub const ItemInnerSpacing: ImGuiStyleVar_ = .{ .bits = 15 };
    pub const IndentSpacing: ImGuiStyleVar_ = .{ .bits = 16 };
    pub const CellPadding: ImGuiStyleVar_ = .{ .bits = 17 };
    pub const ScrollbarSize: ImGuiStyleVar_ = .{ .bits = 18 };
    pub const ScrollbarRounding: ImGuiStyleVar_ = .{ .bits = 19 };
    pub const GrabMinSize: ImGuiStyleVar_ = .{ .bits = 20 };
    pub const GrabRounding: ImGuiStyleVar_ = .{ .bits = 21 };
    pub const TabRounding: ImGuiStyleVar_ = .{ .bits = 22 };
    pub const ButtonTextAlign: ImGuiStyleVar_ = .{ .bits = 23 };
    pub const SelectableTextAlign: ImGuiStyleVar_ = .{ .bits = 24 };
    pub const SeparatorTextBorderSize: ImGuiStyleVar_ = .{ .bits = 25 };
    pub const SeparatorTextAlign: ImGuiStyleVar_ = .{ .bits = 26 };
    pub const SeparatorTextPadding: ImGuiStyleVar_ = .{ .bits = 27 };
    pub const COUNT: ImGuiStyleVar_ = .{ .bits = 28 };

    // pub usingnamespace cpp.FlagsMixin(ImGuiStyleVar_);
};

pub const ImGuiButtonFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiButtonFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const MouseButtonLeft: ImGuiButtonFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const MouseButtonRight: ImGuiButtonFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const MouseButtonMiddle: ImGuiButtonFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const MouseButtonMask_: ImGuiButtonFlags_ = .{ .bits = @intCast(c_uint, ImGuiButtonFlags_.MouseButtonLeft.bits | ImGuiButtonFlags_.MouseButtonRight.bits | ImGuiButtonFlags_.MouseButtonMiddle.bits) };
    pub const MouseButtonDefault_: ImGuiButtonFlags_ = .{ .bits = @intCast(c_uint, ImGuiButtonFlags_.MouseButtonLeft.bits) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiButtonFlags_);
};

pub const ImGuiColorEditFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const NoAlpha: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const NoPicker: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const NoOptions: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const NoSmallPreview: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const NoInputs: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const NoTooltip: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const NoLabel: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const NoSidePreview: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 8) };
    pub const NoDragDrop: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 9) };
    pub const NoBorder: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const AlphaBar: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 16) };
    pub const AlphaPreview: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 17) };
    pub const AlphaPreviewHalf: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 18) };
    pub const HDR: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 19) };
    pub const DisplayRGB: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 20) };
    pub const DisplayHSV: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 21) };
    pub const DisplayHex: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 22) };
    pub const Uint8: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 23) };
    pub const Float: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 24) };
    pub const PickerHueBar: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 25) };
    pub const PickerHueWheel: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 26) };
    pub const InputRGB: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 27) };
    pub const InputHSV: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, 1 << 28) };
    pub const DefaultOptions_: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, ImGuiColorEditFlags_.Uint8.bits | ImGuiColorEditFlags_.DisplayRGB.bits | ImGuiColorEditFlags_.InputRGB.bits | ImGuiColorEditFlags_.PickerHueBar.bits) };
    pub const DisplayMask_: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, ImGuiColorEditFlags_.DisplayRGB.bits | ImGuiColorEditFlags_.DisplayHSV.bits | ImGuiColorEditFlags_.DisplayHex.bits) };
    pub const DataTypeMask_: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, ImGuiColorEditFlags_.Uint8.bits | ImGuiColorEditFlags_.Float.bits) };
    pub const PickerMask_: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, ImGuiColorEditFlags_.PickerHueWheel.bits | ImGuiColorEditFlags_.PickerHueBar.bits) };
    pub const InputMask_: ImGuiColorEditFlags_ = .{ .bits = @intCast(c_uint, ImGuiColorEditFlags_.InputRGB.bits | ImGuiColorEditFlags_.InputHSV.bits) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiColorEditFlags_);
};

pub const ImGuiSliderFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiSliderFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const AlwaysClamp: ImGuiSliderFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const Logarithmic: ImGuiSliderFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const NoRoundToFormat: ImGuiSliderFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const NoInput: ImGuiSliderFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const InvalidMask_: ImGuiSliderFlags_ = .{ .bits = @intCast(c_uint, 1879048207) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiSliderFlags_);
};

pub const ImGuiMouseButton_ = extern struct {
    bits: c_int = 0,

    pub const Left: ImGuiMouseButton_ = .{ .bits = @intCast(c_uint, 0) };
    pub const Right: ImGuiMouseButton_ = .{ .bits = @intCast(c_uint, 1) };
    pub const Middle: ImGuiMouseButton_ = .{ .bits = @intCast(c_uint, 2) };
    pub const COUNT: ImGuiMouseButton_ = .{ .bits = @intCast(c_uint, 5) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiMouseButton_);
};

pub const ImGuiMouseCursor_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiMouseCursor_ = .{ .bits = -1 };
    pub const Arrow: ImGuiMouseCursor_ = .{ .bits = 0 };
    pub const TextInput: ImGuiMouseCursor_ = .{ .bits = ImGuiMouseCursor_.Arrow.bits + 1 };
    pub const ResizeAll: ImGuiMouseCursor_ = .{ .bits = ImGuiMouseCursor_.Arrow.bits + 2 };
    pub const ResizeNS: ImGuiMouseCursor_ = .{ .bits = ImGuiMouseCursor_.Arrow.bits + 3 };
    pub const ResizeEW: ImGuiMouseCursor_ = .{ .bits = ImGuiMouseCursor_.Arrow.bits + 4 };
    pub const ResizeNESW: ImGuiMouseCursor_ = .{ .bits = ImGuiMouseCursor_.Arrow.bits + 5 };
    pub const ResizeNWSE: ImGuiMouseCursor_ = .{ .bits = ImGuiMouseCursor_.Arrow.bits + 6 };
    pub const Hand: ImGuiMouseCursor_ = .{ .bits = ImGuiMouseCursor_.Arrow.bits + 7 };
    pub const NotAllowed: ImGuiMouseCursor_ = .{ .bits = ImGuiMouseCursor_.Arrow.bits + 8 };
    pub const COUNT: ImGuiMouseCursor_ = .{ .bits = ImGuiMouseCursor_.Arrow.bits + 9 };

    // pub usingnamespace cpp.FlagsMixin(ImGuiMouseCursor_);
};

pub const ImGuiMouseSource = extern struct {
    bits: c_int = 0,

    pub const _Mouse: ImGuiMouseSource = .{ .bits = 0 };
    pub const _TouchScreen: ImGuiMouseSource = .{ .bits = ImGuiMouseSource._Mouse.bits + 1 };
    pub const _Pen: ImGuiMouseSource = .{ .bits = ImGuiMouseSource._Mouse.bits + 2 };
    pub const _COUNT: ImGuiMouseSource = .{ .bits = ImGuiMouseSource._Mouse.bits + 3 };

    // pub usingnamespace cpp.FlagsMixin(ImGuiMouseSource);
};

pub const ImGuiCond_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiCond_ = .{ .bits = @intCast(c_uint, 0) };
    pub const Always: ImGuiCond_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const Once: ImGuiCond_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const FirstUseEver: ImGuiCond_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const Appearing: ImGuiCond_ = .{ .bits = @intCast(c_uint, 1 << 3) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiCond_);
};

pub const ImNewWrapper = extern struct {};

pub fn IM_DELETE(comptime T: type, p: [*c]T) void {
    if (p) {
        p.deinit();
        MemFree(p);
    }
}

pub fn ImVector(comptime T: type) type {
    return extern struct {
        const Self = @This();

        Size: c_int,
        Capacity: c_int,
        Data: [*c]T,

        pub const value_type = T;

        pub const iterator = [*c]value_type;

        pub const const_iterator = [*c]const value_type;

        pub inline fn copyFrom(self: *Self, src: *const ImVector(T)) *ImVector(T) {
            self.clear();
            @"unresolvedMemberExpr!"(src.Size);
            if (src.Data) memcpy(self.Data, src.Data, @as(usize, self.Size) * @sizeOf(T));
            return self.*;
        }
        // syntax errors:
        // pub inline fn clear(self: *Self) void {
        //  if (self.Data) {
        // self.Size = self.Capacity = 0;
        // MemFree(self.Data);
        // self.Data = 0;
        // }}
        //
        pub inline fn clear_delete(self: *Self) void {
            {
                var n: c_int = 0;
                while (n < self.Size) : (n += 1) IM_DELETE(self.Data[n]);
            }
            self.clear();
        }
        pub inline fn clear_destruct(self: *Self) void {
            {
                var n: c_int = 0;
                while (n < self.Size) : (n += 1) self.Data[n].deinit();
            }
            self.clear();
        }
        pub inline fn empty(self: *const Self) bool {
            return self.Size == 0;
        }
        pub inline fn size(self: *const Self) c_int {
            return self.Size;
        }
        pub inline fn size_in_bytes(self: *const Self) c_int {
            return self.Size * @as(c_int, @sizeOf(T));
        }
        pub inline fn max_size(self: *const Self) c_int {
            return 2147483647 / @as(c_int, @sizeOf(T));
        }
        pub inline fn capacity(self: *const Self) c_int {
            return self.Capacity;
        }
        pub inline fn getPtr(self: *Self, i: c_int) *T {
            ImAssert(i >= 0 and i < self.Size);
            return self.Data[i];
        }
        pub inline fn get(self: *const Self, i: c_int) *const T {
            ImAssert(i >= 0 and i < self.Size);
            return self.Data[i];
        }
        pub inline fn begin(self: *Self) [*c]T {
            return self.Data;
        }
        pub inline fn begin__Overload2(self: *const Self) [*c]const T {
            return self.Data;
        }
        pub inline fn end(self: *Self) [*c]T {
            return self.Data + self.Size;
        }
        pub inline fn end__Overload2(self: *const Self) [*c]const T {
            return self.Data + self.Size;
        }
        pub inline fn front(self: *Self) *T {
            ImAssert(self.Size > 0);
            return self.Data[0];
        }
        pub inline fn front__Overload2(self: *const Self) *const T {
            ImAssert(self.Size > 0);
            return self.Data[0];
        }
        pub inline fn back(self: *Self) *T {
            ImAssert(self.Size > 0);
            return self.Data[self.Size - 1];
        }
        pub inline fn back__Overload2(self: *const Self) *const T {
            ImAssert(self.Size > 0);
            return self.Data[self.Size - 1];
        }
        pub inline fn swap(self: *Self, rhs: *ImVector(T)) void {
            var rhs_size: c_int = rhs.Size;
            rhs.Size = self.Size;
            self.Size = rhs_size;
            var rhs_cap: c_int = rhs.Capacity;
            rhs.Capacity = self.Capacity;
            self.Capacity = rhs_cap;
            var rhs_data: [*c]T = rhs.Data;
            rhs.Data = self.Data;
            self.Data = rhs_data;
        }
        pub inline fn _grow_capacity(self: *const Self, sz: c_int) c_int {
            var new_capacity: c_int = if (((self.Capacity) != 0)) (self.Capacity + self.Capacity / 2) else 8;
            return if (new_capacity > sz) new_capacity else sz;
        }
        pub inline fn resize(self: *Self, new_size: c_int) void {
            if (new_size > self.Capacity) self.reserve(self._grow_capacity(new_size));
            self.Size = new_size;
        }
        pub inline fn resize__Overload2(self: *Self, new_size: c_int, v: *const T) void {
            if (new_size > self.Capacity) self.reserve(self._grow_capacity(new_size));
            if (new_size > self.Size) {
                var n: c_int = self.Size;
                while (n < new_size) : (n += 1) memcpy(&self.Data[n], &v, @sizeOf(v));
            }
            self.Size = new_size;
        }
        pub inline fn shrink(self: *Self, new_size: c_int) void {
            ImAssert(new_size <= self.Size);
            self.Size = new_size;
        }
        pub inline fn reserve(self: *Self, new_capacity: c_int) void {
            if (new_capacity <= self.Capacity) return;
            var new_data: [*c]T = @as([*c]T, MemAlloc(@intCast(usize, new_capacity) * @sizeOf(T)));
            if (self.Data) {
                memcpy(new_data, self.Data, @as(usize, self.Size) * @sizeOf(T));
                MemFree(self.Data);
            }
            self.Data = new_data;
            self.Capacity = new_capacity;
        }
        pub inline fn reserve_discard(self: *Self, new_capacity: c_int) void {
            if (new_capacity <= self.Capacity) return;
            if (self.Data) MemFree(self.Data);
            self.Data = @as([*c]T, MemAlloc(@intCast(usize, new_capacity) * @sizeOf(T)));
            self.Capacity = new_capacity;
        }
        pub inline fn push_back(self: *Self, v: *const T) void {
            if (self.Size == self.Capacity) self.reserve(self._grow_capacity(self.Size + 1));
            memcpy(&self.Data[self.Size], &v, @sizeOf(v));
            self.Size += 1;
        }
        pub inline fn pop_back(self: *Self) void {
            ImAssert(self.Size > 0);
            self.Size -= 1;
        }
        pub inline fn push_front(self: *Self, v: *const T) void {
            if (self.Size == 0) self.push_back(v) else self.insert(self.Data, v);
        }
        pub inline fn erase(self: *Self, it: [*c]const T) [*c]T {
            ImAssert(it >= self.Data and it < self.Data + self.Size);
            const off: ptrdiff_t = it - self.Data;
            memmove(self.Data + off, self.Data + off + 1, (@as(usize, self.Size) - @as(usize, off) - @intCast(usize, 1)) * @sizeOf(T));
            self.Size -= 1;
            return self.Data + off;
        }
        pub inline fn erase__Overload2(self: *Self, it: [*c]const T, it_last: [*c]const T) [*c]T {
            ImAssert(it >= self.Data and it < self.Data + self.Size and it_last >= it and it_last <= self.Data + self.Size);
            const count: ptrdiff_t = it_last - it;
            const off: ptrdiff_t = it - self.Data;
            memmove(self.Data + off, self.Data + off + count, (@as(usize, self.Size) - @as(usize, off) - @as(usize, count)) * @sizeOf(T));
            self.Size -= @as(c_int, count);
            return self.Data + off;
        }
        pub inline fn erase_unsorted(self: *Self, it: [*c]const T) [*c]T {
            ImAssert(it >= self.Data and it < self.Data + self.Size);
            const off: ptrdiff_t = it - self.Data;
            if (it < self.Data + self.Size - 1) memcpy(self.Data + off, self.Data + self.Size - 1, @sizeOf(T));
            self.Size -= 1;
            return self.Data + off;
        }
        pub inline fn insert(self: *Self, it: [*c]const T, v: *const T) [*c]T {
            ImAssert(it >= self.Data and it <= self.Data + self.Size);
            const off: ptrdiff_t = it - self.Data;
            if (self.Size == self.Capacity) self.reserve(self._grow_capacity(self.Size + 1));
            if (off < @intCast(ptrdiff_t, @as(c_int, self.Size))) memmove(self.Data + off + 1, self.Data + off, (@as(usize, self.Size) - @as(usize, off)) * @sizeOf(T));
            memcpy(&self.Data[off], &v, @sizeOf(v));
            self.Size += 1;
            return self.Data + off;
        }
        // syntax errors:
        // pub inline fn contains(self: *const Self, v: *const T) bool {
        // const data: [*c]T = self.Data;
        // const data_end: [*c]T = self.Data + self.Size;
        // while (data < data_end) if ((data += 1).* == v) return true;
        // return false;
        // }
        //
        pub inline fn find(self: *Self, v: *const T) [*c]T {
            var data: [*c]T = self.Data;
            const data_end: [*c]T = self.Data + self.Size;
            while (data < data_end) if (data.* == v) break else data += 1;
            return data;
        }
        pub inline fn find__Overload2(self: *const Self, v: *const T) [*c]const T {
            const data: [*c]T = self.Data;
            const data_end: [*c]T = self.Data + self.Size;
            while (data < data_end) if (data.* == v) break else data += 1;
            return data;
        }
        pub inline fn find_erase(self: *Self, v: *const T) bool {
            const it: [*c]T = @"unresolvedMemberExpr!"(v);
            if (it < self.Data + self.Size) {
                @"unresolvedMemberExpr!"(it);
                return true;
            }
            return false;
        }
        pub inline fn find_erase_unsorted(self: *Self, v: *const T) bool {
            const it: [*c]T = @"unresolvedMemberExpr!"(v);
            if (it < self.Data + self.Size) {
                self.erase_unsorted(it);
                return true;
            }
            return false;
        }
        pub inline fn index_from_ptr(self: *const Self, it: [*c]const T) c_int {
            ImAssert(it >= self.Data and it < self.Data + self.Size);
            const off: ptrdiff_t = it - self.Data;
            return @as(c_int, off);
        }
    };
}

pub const ImGuiStyle = extern struct {
    Alpha: f32,
    DisabledAlpha: f32,
    WindowPadding: ImVec2,
    WindowRounding: f32,
    WindowBorderSize: f32,
    WindowMinSize: ImVec2,
    WindowTitleAlign: ImVec2,
    WindowMenuButtonPosition: ImGuiDir,
    ChildRounding: f32,
    ChildBorderSize: f32,
    PopupRounding: f32,
    PopupBorderSize: f32,
    FramePadding: ImVec2,
    FrameRounding: f32,
    FrameBorderSize: f32,
    ItemSpacing: ImVec2,
    ItemInnerSpacing: ImVec2,
    CellPadding: ImVec2,
    TouchExtraPadding: ImVec2,
    IndentSpacing: f32,
    ColumnsMinSpacing: f32,
    ScrollbarSize: f32,
    ScrollbarRounding: f32,
    GrabMinSize: f32,
    GrabRounding: f32,
    LogSliderDeadzone: f32,
    TabRounding: f32,
    TabBorderSize: f32,
    TabMinWidthForCloseButton: f32,
    ColorButtonPosition: ImGuiDir,
    ButtonTextAlign: ImVec2,
    SelectableTextAlign: ImVec2,
    SeparatorTextBorderSize: f32,
    SeparatorTextAlign: ImVec2,
    SeparatorTextPadding: ImVec2,
    DisplayWindowPadding: ImVec2,
    DisplaySafeAreaPadding: ImVec2,
    MouseCursorScale: f32,
    AntiAliasedLines: bool,
    AntiAliasedLinesUseTex: bool,
    AntiAliasedFill: bool,
    CurveTessellationTol: f32,
    CircleTessellationMaxError: f32,
    Colors: [55]ImVec4,

    extern fn _ZN10ImGuiStyleC1Ev(self: *ImGuiStyle) void;
    pub inline fn init() ImGuiStyle {
        var self: ImGuiStyle = undefined;
        _ZN10ImGuiStyleC1Ev(&self);
        return self;
    }

    extern fn _ZN10ImGuiStyle13ScaleAllSizesEf(self: *ImGuiStyle, scale_factor: f32) void;
    pub const ScaleAllSizes = _ZN10ImGuiStyle13ScaleAllSizesEf;
};

pub const ImGuiKeyData = extern struct {
    Down: bool,
    DownDuration: f32,
    DownDurationPrev: f32,
    AnalogValue: f32,
};

pub const ImGuiIO = extern struct {
    ConfigFlags: ImGuiConfigFlags,
    BackendFlags: ImGuiBackendFlags,
    DisplaySize: ImVec2,
    DeltaTime: f32,
    IniSavingRate: f32,
    IniFilename: [*c]const u8,
    LogFilename: [*c]const u8,
    MouseDoubleClickTime: f32,
    MouseDoubleClickMaxDist: f32,
    MouseDragThreshold: f32,
    KeyRepeatDelay: f32,
    KeyRepeatRate: f32,
    HoverDelayNormal: f32,
    HoverDelayShort: f32,
    UserData: ?*anyopaque,
    Fonts: [*c]ImFontAtlas,
    FontGlobalScale: f32,
    FontAllowUserScaling: bool,
    FontDefault: [*c]ImFont,
    DisplayFramebufferScale: ImVec2,
    ConfigDockingNoSplit: bool,
    ConfigDockingWithShift: bool,
    ConfigDockingAlwaysTabBar: bool,
    ConfigDockingTransparentPayload: bool,
    ConfigViewportsNoAutoMerge: bool,
    ConfigViewportsNoTaskBarIcon: bool,
    ConfigViewportsNoDecoration: bool,
    ConfigViewportsNoDefaultParent: bool,
    MouseDrawCursor: bool,
    ConfigMacOSXBehaviors: bool,
    ConfigInputTrickleEventQueue: bool,
    ConfigInputTextCursorBlink: bool,
    ConfigInputTextEnterKeepActive: bool,
    ConfigDragClickToInputText: bool,
    ConfigWindowsResizeFromEdges: bool,
    ConfigWindowsMoveFromTitleBarOnly: bool,
    ConfigMemoryCompactTimer: f32,
    ConfigDebugBeginReturnValueOnce: bool,
    ConfigDebugBeginReturnValueLoop: bool,
    BackendPlatformName: [*c]const u8,
    BackendRendererName: [*c]const u8,
    BackendPlatformUserData: ?*anyopaque,
    BackendRendererUserData: ?*anyopaque,
    BackendLanguageUserData: ?*anyopaque,
    GetClipboardTextFn: ?*const fn (?*anyopaque) callconv(.C) [*c]const u8,
    SetClipboardTextFn: ?*const fn (?*anyopaque, [*c]const u8) callconv(.C) void,
    ClipboardUserData: ?*anyopaque,
    SetPlatformImeDataFn: ?*const fn ([*c]ImGuiViewport, [*c]ImGuiPlatformImeData) callconv(.C) void,
    _UnusedPadding: ?*anyopaque,
    WantCaptureMouse: bool,
    WantCaptureKeyboard: bool,
    WantTextInput: bool,
    WantSetMousePos: bool,
    WantSaveIniSettings: bool,
    NavActive: bool,
    NavVisible: bool,
    Framerate: f32,
    MetricsRenderVertices: c_int,
    MetricsRenderIndices: c_int,
    MetricsRenderWindows: c_int,
    MetricsActiveWindows: c_int,
    MetricsActiveAllocations: c_int,
    MouseDelta: ImVec2,
    Ctx: ?*ImGuiContext,
    MousePos: ImVec2,
    MouseDown: [5]bool,
    MouseWheel: f32,
    MouseWheelH: f32,
    MouseSource: ImGuiMouseSource,
    MouseHoveredViewport: ImGuiID,
    KeyCtrl: bool,
    KeyShift: bool,
    KeyAlt: bool,
    KeySuper: bool,
    KeyMods: ImGuiKeyChord,
    KeysData: [140]ImGuiKeyData,
    WantCaptureMouseUnlessPopupClose: bool,
    MousePosPrev: ImVec2,
    MouseClickedPos: [5]ImVec2,
    MouseClickedTime: [5]f64,
    MouseClicked: [5]bool,
    MouseDoubleClicked: [5]bool,
    MouseClickedCount: [5]ImU16,
    MouseClickedLastCount: [5]ImU16,
    MouseReleased: [5]bool,
    MouseDownOwned: [5]bool,
    MouseDownOwnedUnlessPopupClose: [5]bool,
    MouseWheelRequestAxisSwap: bool,
    MouseDownDuration: [5]f32,
    MouseDownDurationPrev: [5]f32,
    MouseDragMaxDistanceAbs: [5]ImVec2,
    MouseDragMaxDistanceSqr: [5]f32,
    PenPressure: f32,
    AppFocusLost: bool,
    AppAcceptingEvents: bool,
    BackendUsingLegacyKeyArrays: ImS8,
    BackendUsingLegacyNavInputArray: bool,
    InputQueueSurrogate: ImWchar16,
    InputQueueCharacters: ImVector(ImWchar),

    extern fn _ZN7ImGuiIO11AddKeyEventE8ImGuiKeyb(self: *ImGuiIO, key: ImGuiKey, down: bool) void;
    pub const AddKeyEvent = _ZN7ImGuiIO11AddKeyEventE8ImGuiKeyb;

    extern fn _ZN7ImGuiIO17AddKeyAnalogEventE8ImGuiKeybf(self: *ImGuiIO, key: ImGuiKey, down: bool, v: f32) void;
    pub const AddKeyAnalogEvent = _ZN7ImGuiIO17AddKeyAnalogEventE8ImGuiKeybf;

    extern fn _ZN7ImGuiIO16AddMousePosEventEff(self: *ImGuiIO, x: f32, y: f32) void;
    pub const AddMousePosEvent = _ZN7ImGuiIO16AddMousePosEventEff;

    extern fn _ZN7ImGuiIO19AddMouseButtonEventEib(self: *ImGuiIO, button: c_int, down: bool) void;
    pub const AddMouseButtonEvent = _ZN7ImGuiIO19AddMouseButtonEventEib;

    extern fn _ZN7ImGuiIO18AddMouseWheelEventEff(self: *ImGuiIO, wheel_x: f32, wheel_y: f32) void;
    pub const AddMouseWheelEvent = _ZN7ImGuiIO18AddMouseWheelEventEff;

    extern fn _ZN7ImGuiIO19AddMouseSourceEventE16ImGuiMouseSource(self: *ImGuiIO, source: ImGuiMouseSource) void;
    pub const AddMouseSourceEvent = _ZN7ImGuiIO19AddMouseSourceEventE16ImGuiMouseSource;

    extern fn _ZN7ImGuiIO21AddMouseViewportEventEj(self: *ImGuiIO, id: ImGuiID) void;
    pub const AddMouseViewportEvent = _ZN7ImGuiIO21AddMouseViewportEventEj;

    extern fn _ZN7ImGuiIO13AddFocusEventEb(self: *ImGuiIO, focused: bool) void;
    pub const AddFocusEvent = _ZN7ImGuiIO13AddFocusEventEb;

    extern fn _ZN7ImGuiIO17AddInputCharacterEj(self: *ImGuiIO, c: c_uint) void;
    pub const AddInputCharacter = _ZN7ImGuiIO17AddInputCharacterEj;

    extern fn _ZN7ImGuiIO22AddInputCharacterUTF16Et(self: *ImGuiIO, c: ImWchar16) void;
    pub const AddInputCharacterUTF16 = _ZN7ImGuiIO22AddInputCharacterUTF16Et;

    extern fn _ZN7ImGuiIO22AddInputCharactersUTF8EPKc(self: *ImGuiIO, str: [*c]const u8) void;
    pub const AddInputCharactersUTF8 = _ZN7ImGuiIO22AddInputCharactersUTF8EPKc;

    extern fn _ZN7ImGuiIO21SetKeyEventNativeDataE8ImGuiKeyiii(self: *ImGuiIO, key: ImGuiKey, native_keycode: c_int, native_scancode: c_int, native_legacy_index: c_int) void;
    pub const SetKeyEventNativeData = _ZN7ImGuiIO21SetKeyEventNativeDataE8ImGuiKeyiii;

    extern fn _ZN7ImGuiIO21SetAppAcceptingEventsEb(self: *ImGuiIO, accepting_events: bool) void;
    pub const SetAppAcceptingEvents = _ZN7ImGuiIO21SetAppAcceptingEventsEb;

    extern fn _ZN7ImGuiIO20ClearInputCharactersEv(self: *ImGuiIO) void;
    pub const ClearInputCharacters = _ZN7ImGuiIO20ClearInputCharactersEv;

    extern fn _ZN7ImGuiIO14ClearInputKeysEv(self: *ImGuiIO) void;
    pub const ClearInputKeys = _ZN7ImGuiIO14ClearInputKeysEv;

    extern fn _ZN7ImGuiIOC1Ev(self: *ImGuiIO) void;
    pub inline fn init() ImGuiIO {
        var self: ImGuiIO = undefined;
        _ZN7ImGuiIOC1Ev(&self);
        return self;
    }
};

pub const ImGuiInputTextCallbackData = extern struct {
    Ctx: ?*ImGuiContext,
    EventFlag: ImGuiInputTextFlags,
    Flags: ImGuiInputTextFlags,
    UserData: ?*anyopaque,
    EventChar: ImWchar,
    EventKey: ImGuiKey,
    Buf: [*c]u8,
    BufTextLen: c_int,
    BufSize: c_int,
    BufDirty: bool,
    CursorPos: c_int,
    SelectionStart: c_int,
    SelectionEnd: c_int,

    extern fn _ZN26ImGuiInputTextCallbackDataC1Ev(self: *ImGuiInputTextCallbackData) void;
    pub inline fn init() ImGuiInputTextCallbackData {
        var self: ImGuiInputTextCallbackData = undefined;
        _ZN26ImGuiInputTextCallbackDataC1Ev(&self);
        return self;
    }

    extern fn _ZN26ImGuiInputTextCallbackData11DeleteCharsEii(self: *ImGuiInputTextCallbackData, pos: c_int, bytes_count: c_int) void;
    pub const DeleteChars = _ZN26ImGuiInputTextCallbackData11DeleteCharsEii;

    extern fn _ZN26ImGuiInputTextCallbackData11InsertCharsEiPKcS1_(self: *ImGuiInputTextCallbackData, pos: c_int, text: [*c]const u8, text_end: [*c]const u8) void;
    pub const InsertChars = _ZN26ImGuiInputTextCallbackData11InsertCharsEiPKcS1_;

    pub fn SelectAll(self: *ImGuiInputTextCallbackData) void {
        self.SelectionStart = 0;
        self.SelectionEnd = self.BufTextLen;
    }
    // syntax errors:
    // pub fn ClearSelection(self: *ImGuiInputTextCallbackData) void {
    // self.SelectionStart = self.SelectionEnd = self.BufTextLen;
    // }
    //
    pub fn HasSelection(self: *const ImGuiInputTextCallbackData) bool {
        return self.SelectionStart != self.SelectionEnd;
    }
};

pub const ImGuiSizeCallbackData = extern struct {
    UserData: ?*anyopaque,
    Pos: ImVec2,
    CurrentSize: ImVec2,
    DesiredSize: ImVec2,
};

pub const ImGuiWindowClass = extern struct {
    ClassId: ImGuiID,
    ParentViewportId: ImGuiID,
    ViewportFlagsOverrideSet: ImGuiViewportFlags,
    ViewportFlagsOverrideClear: ImGuiViewportFlags,
    TabItemFlagsOverrideSet: ImGuiTabItemFlags,
    DockNodeFlagsOverrideSet: ImGuiDockNodeFlags,
    DockingAlwaysTabBar: bool,
    DockingAllowUnclassed: bool,

    extern fn _ZN16ImGuiWindowClassC1Ev(self: *ImGuiWindowClass) void;
    pub inline fn init() ImGuiWindowClass {
        var self: ImGuiWindowClass = undefined;
        _ZN16ImGuiWindowClassC1Ev(&self);
        return self;
    }
};

pub const ImGuiPayload = extern struct {
    Data: ?*anyopaque,
    DataSize: c_int,
    SourceId: ImGuiID,
    SourceParentId: ImGuiID,
    DataFrameCount: c_int,
    DataType: [33]u8,
    Preview: bool,
    Delivery: bool,

    extern fn _ZN12ImGuiPayloadC1Ev(self: *ImGuiPayload) void;
    pub inline fn init() ImGuiPayload {
        var self: ImGuiPayload = undefined;
        _ZN12ImGuiPayloadC1Ev(&self);
        return self;
    }

    // syntax errors:
    // pub fn Clear(self: *ImGuiPayload) void {
    // self.SourceId = self.SourceParentId = @intCast(ImGuiID, 0);
    // self.Data = null;
    // self.DataSize = 0;
    // memset(@bitCast(?*anyopaque, @as([*c]u8, self.DataType)), 0, @sizeOf(self.DataType));
    // self.DataFrameCount = -1;
    // self.Preview = self.Delivery = false;
    // }
    //
    pub fn IsDataType(self: *const ImGuiPayload, typeName: [*c]const u8) bool {
        return self.DataFrameCount != -1 and strcmp(typeName, @as([*c]const u8, self.DataType)) == 0;
    }
    pub fn IsPreview(self: *const ImGuiPayload) bool {
        return self.Preview;
    }
    pub fn IsDelivery(self: *const ImGuiPayload) bool {
        return self.Delivery;
    }
};

pub const ImGuiTableColumnSortSpecs = extern struct {
    ColumnUserID: ImGuiID,
    ColumnIndex: ImS16,
    SortOrder: ImS16,
    SortDirection: ImGuiSortDirection,

    extern fn _ZN25ImGuiTableColumnSortSpecsC1Ev(self: *ImGuiTableColumnSortSpecs) void;
    pub inline fn init() ImGuiTableColumnSortSpecs {
        var self: ImGuiTableColumnSortSpecs = undefined;
        _ZN25ImGuiTableColumnSortSpecsC1Ev(&self);
        return self;
    }
};

pub const ImGuiTableSortSpecs = extern struct {
    Specs: [*c]const ImGuiTableColumnSortSpecs,
    SpecsCount: c_int,
    SpecsDirty: bool,

    extern fn _ZN19ImGuiTableSortSpecsC1Ev(self: *ImGuiTableSortSpecs) void;
    pub inline fn init() ImGuiTableSortSpecs {
        var self: ImGuiTableSortSpecs = undefined;
        _ZN19ImGuiTableSortSpecsC1Ev(&self);
        return self;
    }
};

pub const ImGuiOnceUponAFrame = extern struct {
    RefFrame: c_int,

    extern fn _ZN19ImGuiOnceUponAFrameC1Ev(self: *ImGuiOnceUponAFrame) void;
    pub inline fn init() ImGuiOnceUponAFrame {
        var self: ImGuiOnceUponAFrame = undefined;
        _ZN19ImGuiOnceUponAFrameC1Ev(&self);
        return self;
    }
};

pub const ImGuiTextFilter = extern struct {
    pub const ImGuiTextRange = extern struct {
        b: [*c]const u8,
        e: [*c]const u8,

        extern fn _ZN15ImGuiTextFilter14ImGuiTextRangeC1Ev(self: *ImGuiTextRange) void;
        pub inline fn init() ImGuiTextRange {
            var self: ImGuiTextRange = undefined;
            _ZN15ImGuiTextFilter14ImGuiTextRangeC1Ev(&self);
            return self;
        }

        extern fn _ZN15ImGuiTextFilter14ImGuiTextRangeC1EPKcS2_(self: *ImGuiTextRange, _b: [*c]const u8, _e: [*c]const u8) void;
        pub inline fn init1(_b: [*c]const u8, _e: [*c]const u8) ImGuiTextRange {
            var self: ImGuiTextRange = undefined;
            _ZN15ImGuiTextFilter14ImGuiTextRangeC1EPKcS2_(&self, _b, _e);
            return self;
        }

        pub fn empty(self: *const ImGuiTextRange) bool {
            return self.b == self.e;
        }
        extern fn _ZNK15ImGuiTextFilter14ImGuiTextRange5splitEcP8ImVectorIS0_E(self: *const ImGuiTextRange, separator: u8, out: [*c]ImVector(ImGuiTextRange)) void;
        pub const split = _ZNK15ImGuiTextFilter14ImGuiTextRange5splitEcP8ImVectorIS0_E;
    };

    InputBuf: [256]u8,
    Filters: ImVector(ImGuiTextRange),
    CountGrep: c_int,

    extern fn _ZN15ImGuiTextFilterC1EPKc(self: *ImGuiTextFilter, default_filter: [*c]const u8) void;
    pub inline fn init(default_filter: [*c]const u8) ImGuiTextFilter {
        var self: ImGuiTextFilter = undefined;
        _ZN15ImGuiTextFilterC1EPKc(&self, default_filter);
        return self;
    }

    extern fn _ZN15ImGuiTextFilter4DrawEPKcf(self: *ImGuiTextFilter, label: [*c]const u8, width: f32) bool;
    pub const Draw = _ZN15ImGuiTextFilter4DrawEPKcf;

    extern fn _ZNK15ImGuiTextFilter10PassFilterEPKcS1_(self: *const ImGuiTextFilter, text: [*c]const u8, text_end: [*c]const u8) bool;
    pub const PassFilter = _ZNK15ImGuiTextFilter10PassFilterEPKcS1_;

    extern fn _ZN15ImGuiTextFilter5BuildEv(self: *ImGuiTextFilter) void;
    pub const Build = _ZN15ImGuiTextFilter5BuildEv;

    pub fn Clear(self: *ImGuiTextFilter) void {
        @as([*c]u8, self.InputBuf)[0] = @intCast(u8, 0);
        self.Build();
    }
    pub fn IsActive(self: *const ImGuiTextFilter) bool {
        return !self.empty();
    }
};

pub const ImGuiTextBuffer = extern struct {
    Buf: ImVector(u8),

    extern var _ZN15ImGuiTextBuffer11EmptyStringE: [1]u8;
    pub inline fn EmptyString() *[1]u8 {
        return &_ZN15ImGuiTextBuffer11EmptyStringE;
    }

    extern fn _ZN15ImGuiTextBufferC1Ev(self: *ImGuiTextBuffer) void;
    pub inline fn init() ImGuiTextBuffer {
        var self: ImGuiTextBuffer = undefined;
        _ZN15ImGuiTextBufferC1Ev(&self);
        return self;
    }

    pub inline fn get(self: *const ImGuiTextBuffer, i: c_int) u8 {
        ImAssert(self.Buf.Data != null);
        return self.Buf.Data[i];
    }
    pub fn begin(self: *const ImGuiTextBuffer) [*c]const u8 {
        return if (@as(bool, self.Buf.Data)) &self.front() else @as([*c]u8, EmptyString);
    }
    pub fn end(self: *const ImGuiTextBuffer) [*c]const u8 {
        return if (@as(bool, self.Buf.Data)) &self.back() else @as([*c]u8, EmptyString);
    }
    pub fn size(self: *const ImGuiTextBuffer) c_int {
        return if (((self.Buf.Size) != 0)) self.Buf.Size - 1 else 0;
    }
    pub fn empty(self: *const ImGuiTextBuffer) bool {
        return self.Buf.Size <= 1;
    }
    pub fn clear(self: *ImGuiTextBuffer) void {
        self.clear();
    }
    pub fn reserve(self: *ImGuiTextBuffer, capacity: c_int) void {
        self.reserve(capacity);
    }
    pub fn c_str(self: *const ImGuiTextBuffer) [*c]const u8 {
        return if (@as(bool, self.Buf.Data)) self.Buf.Data else @as([*c]u8, EmptyString);
    }
    extern fn _ZN15ImGuiTextBuffer6appendEPKcS1_(self: *ImGuiTextBuffer, str: [*c]const u8, str_end: [*c]const u8) void;
    pub const append = _ZN15ImGuiTextBuffer6appendEPKcS1_;

    extern fn _ZN15ImGuiTextBuffer7appendfEPKcz(self: *ImGuiTextBuffer, fmt: [*c]const u8) void;
    pub const appendf = _ZN15ImGuiTextBuffer7appendfEPKcz;

    extern fn _ZN15ImGuiTextBuffer8appendfvEPKcPc(self: *ImGuiTextBuffer, fmt: [*c]const u8, args: [*c]u8) void;
    pub const appendfv = _ZN15ImGuiTextBuffer8appendfvEPKcPc;
};

pub const ImGuiStorage = extern struct {
    pub const ImGuiStoragePair = extern struct {
        key: ImGuiID,
        field0: extern union {
            val_i: c_int,
            val_f: f32,
            val_p: ?*anyopaque,
        },

        extern fn _ZN12ImGuiStorage16ImGuiStoragePairC1Eji(self: *ImGuiStoragePair, _key: ImGuiID, _val_i: c_int) void;
        pub inline fn init(_key: ImGuiID, _val_i: c_int) ImGuiStoragePair {
            var self: ImGuiStoragePair = undefined;
            _ZN12ImGuiStorage16ImGuiStoragePairC1Eji(&self, _key, _val_i);
            return self;
        }

        extern fn _ZN12ImGuiStorage16ImGuiStoragePairC1Ejf(self: *ImGuiStoragePair, _key: ImGuiID, _val_f: f32) void;
        pub inline fn init1(_key: ImGuiID, _val_f: f32) ImGuiStoragePair {
            var self: ImGuiStoragePair = undefined;
            _ZN12ImGuiStorage16ImGuiStoragePairC1Ejf(&self, _key, _val_f);
            return self;
        }

        extern fn _ZN12ImGuiStorage16ImGuiStoragePairC1EjPv(self: *ImGuiStoragePair, _key: ImGuiID, _val_p: ?*anyopaque) void;
        pub inline fn init2(_key: ImGuiID, _val_p: ?*anyopaque) ImGuiStoragePair {
            var self: ImGuiStoragePair = undefined;
            _ZN12ImGuiStorage16ImGuiStoragePairC1EjPv(&self, _key, _val_p);
            return self;
        }
    };

    Data: ImVector(ImGuiStoragePair),

    pub fn Clear(self: *ImGuiStorage) void {
        self.clear();
    }
    extern fn _ZNK12ImGuiStorage6GetIntEji(self: *const ImGuiStorage, key: ImGuiID, default_val: c_int) c_int;
    pub const GetInt = _ZNK12ImGuiStorage6GetIntEji;

    extern fn _ZN12ImGuiStorage6SetIntEji(self: *ImGuiStorage, key: ImGuiID, val: c_int) void;
    pub const SetInt = _ZN12ImGuiStorage6SetIntEji;

    extern fn _ZNK12ImGuiStorage7GetBoolEjb(self: *const ImGuiStorage, key: ImGuiID, default_val: bool) bool;
    pub const GetBool = _ZNK12ImGuiStorage7GetBoolEjb;

    extern fn _ZN12ImGuiStorage7SetBoolEjb(self: *ImGuiStorage, key: ImGuiID, val: bool) void;
    pub const SetBool = _ZN12ImGuiStorage7SetBoolEjb;

    extern fn _ZNK12ImGuiStorage8GetFloatEjf(self: *const ImGuiStorage, key: ImGuiID, default_val: f32) f32;
    pub const GetFloat = _ZNK12ImGuiStorage8GetFloatEjf;

    extern fn _ZN12ImGuiStorage8SetFloatEjf(self: *ImGuiStorage, key: ImGuiID, val: f32) void;
    pub const SetFloat = _ZN12ImGuiStorage8SetFloatEjf;

    extern fn _ZNK12ImGuiStorage10GetVoidPtrEj(self: *const ImGuiStorage, key: ImGuiID) ?*anyopaque;
    pub const GetVoidPtr = _ZNK12ImGuiStorage10GetVoidPtrEj;

    extern fn _ZN12ImGuiStorage10SetVoidPtrEjPv(self: *ImGuiStorage, key: ImGuiID, val: ?*anyopaque) void;
    pub const SetVoidPtr = _ZN12ImGuiStorage10SetVoidPtrEjPv;

    extern fn _ZN12ImGuiStorage9GetIntRefEji(self: *ImGuiStorage, key: ImGuiID, default_val: c_int) [*c]c_int;
    pub const GetIntRef = _ZN12ImGuiStorage9GetIntRefEji;

    extern fn _ZN12ImGuiStorage10GetBoolRefEjb(self: *ImGuiStorage, key: ImGuiID, default_val: bool) [*c]bool;
    pub const GetBoolRef = _ZN12ImGuiStorage10GetBoolRefEjb;

    extern fn _ZN12ImGuiStorage11GetFloatRefEjf(self: *ImGuiStorage, key: ImGuiID, default_val: f32) [*c]f32;
    pub const GetFloatRef = _ZN12ImGuiStorage11GetFloatRefEjf;

    extern fn _ZN12ImGuiStorage13GetVoidPtrRefEjPv(self: *ImGuiStorage, key: ImGuiID, default_val: ?*anyopaque) [*c]?*anyopaque;
    pub const GetVoidPtrRef = _ZN12ImGuiStorage13GetVoidPtrRefEjPv;

    extern fn _ZN12ImGuiStorage9SetAllIntEi(self: *ImGuiStorage, val: c_int) void;
    pub const SetAllInt = _ZN12ImGuiStorage9SetAllIntEi;

    extern fn _ZN12ImGuiStorage14BuildSortByKeyEv(self: *ImGuiStorage) void;
    pub const BuildSortByKey = _ZN12ImGuiStorage14BuildSortByKeyEv;
};

pub const ImGuiListClipper = extern struct {
    Ctx: ?*ImGuiContext,
    DisplayStart: c_int,
    DisplayEnd: c_int,
    ItemsCount: c_int,
    ItemsHeight: f32,
    StartPosY: f32,
    TempData: ?*anyopaque,

    extern fn _ZN16ImGuiListClipperC1Ev(self: *ImGuiListClipper) void;
    pub inline fn init() ImGuiListClipper {
        var self: ImGuiListClipper = undefined;
        _ZN16ImGuiListClipperC1Ev(&self);
        return self;
    }

    extern fn _ZN16ImGuiListClipperD1Ev(self: *ImGuiListClipper) void;
    pub inline fn deinit(self: *ImGuiListClipper) void {
        self._ZN16ImGuiListClipperD1Ev();
    }

    extern fn _ZN16ImGuiListClipper5BeginEif(self: *ImGuiListClipper, items_count: c_int, items_height: f32) void;
    pub const Begin = _ZN16ImGuiListClipper5BeginEif;

    extern fn _ZN16ImGuiListClipper3EndEv(self: *ImGuiListClipper) void;
    pub const End = _ZN16ImGuiListClipper3EndEv;

    extern fn _ZN16ImGuiListClipper4StepEv(self: *ImGuiListClipper) bool;
    pub const Step = _ZN16ImGuiListClipper4StepEv;

    extern fn _ZN16ImGuiListClipper26ForceDisplayRangeByIndicesEii(self: *ImGuiListClipper, item_min: c_int, item_max: c_int) void;
    pub const ForceDisplayRangeByIndices = _ZN16ImGuiListClipper26ForceDisplayRangeByIndicesEii;
};

pub const ImColor = extern struct {
    Value: ImVec4,

    extern fn _ZN7ImColorC1Eiiii(self: *ImColor, r: c_int, g: c_int, b: c_int, a: c_int) void;
    pub inline fn init(r: c_int, g: c_int, b: c_int, a: c_int) ImColor {
        var self: ImColor = undefined;
        _ZN7ImColorC1Eiiii(&self, r, g, b, a);
        return self;
    }

    extern fn _ZN7ImColorC1Ej(self: *ImColor, rgba: ImU32) void;
    pub inline fn init1(rgba: ImU32) ImColor {
        var self: ImColor = undefined;
        _ZN7ImColorC1Ej(&self, rgba);
        return self;
    }

    pub inline fn SetHSV(self: *ImColor, h: f32, s: f32, v: f32, a: f32) void {
        ColorConvertHSVtoRGB(h, s, v, self.Value.x, self.Value.y, self.Value.z);
        self.Value.w = a;
    }
    pub fn HSV(self: *ImColor, h: f32, s: f32, v: f32, a: f32) ImColor {
        var r: f32;
        var g: f32;
        var b: f32;
        ColorConvertHSVtoRGB(h, s, v, r, g, b);
        return;
    }
};

pub const ImDrawCallback = ?*const fn ([*c]const ImDrawList, [*c]const ImDrawCmd) callconv(.C) void;

pub const ImDrawCmd = extern struct {
    ClipRect: ImVec4,
    TextureId: ImTextureID,
    VtxOffset: c_uint,
    IdxOffset: c_uint,
    ElemCount: c_uint,
    UserCallback: ImDrawCallback,
    UserCallbackData: ?*anyopaque,

    extern fn _ZN9ImDrawCmdC1Ev(self: *ImDrawCmd) void;
    pub inline fn init() ImDrawCmd {
        var self: ImDrawCmd = undefined;
        _ZN9ImDrawCmdC1Ev(&self);
        return self;
    }

    pub inline fn GetTexID(self: *const ImDrawCmd) ImTextureID {
        return self.TextureId;
    }
};

pub const ImDrawVert = extern struct {
    pos: ImVec2,
    uv: ImVec2,
    col: ImU32,
};

pub const ImDrawCmdHeader = extern struct {
    ClipRect: ImVec4,
    TextureId: ImTextureID,
    VtxOffset: c_uint,
};

pub const ImDrawChannel = extern struct {
    _CmdBuffer: ImVector(ImDrawCmd),
    _IdxBuffer: ImVector(ImDrawIdx),
};

pub const ImDrawListSplitter = extern struct {
    _Current: c_int,
    _Count: c_int,
    _Channels: ImVector(ImDrawChannel),

    extern fn _ZN18ImDrawListSplitterC1Ev(self: *ImDrawListSplitter) void;
    pub inline fn init() ImDrawListSplitter {
        var self: ImDrawListSplitter = undefined;
        _ZN18ImDrawListSplitterC1Ev(&self);
        return self;
    }

    extern fn _ZN18ImDrawListSplitterD1Ev(self: *ImDrawListSplitter) void;
    pub inline fn deinit(self: *ImDrawListSplitter) void {
        self._ZN18ImDrawListSplitterD1Ev();
    }

    pub inline fn Clear(self: *ImDrawListSplitter) void {
        self._Current = 0;
        self._Count = 1;
    }
    extern fn _ZN18ImDrawListSplitter15ClearFreeMemoryEv(self: *ImDrawListSplitter) void;
    pub const ClearFreeMemory = _ZN18ImDrawListSplitter15ClearFreeMemoryEv;

    extern fn _ZN18ImDrawListSplitter5SplitEP10ImDrawListi(self: *ImDrawListSplitter, draw_list: [*c]ImDrawList, count: c_int) void;
    pub const Split = _ZN18ImDrawListSplitter5SplitEP10ImDrawListi;

    extern fn _ZN18ImDrawListSplitter5MergeEP10ImDrawList(self: *ImDrawListSplitter, draw_list: [*c]ImDrawList) void;
    pub const Merge = _ZN18ImDrawListSplitter5MergeEP10ImDrawList;

    extern fn _ZN18ImDrawListSplitter17SetCurrentChannelEP10ImDrawListi(self: *ImDrawListSplitter, draw_list: [*c]ImDrawList, channel_idx: c_int) void;
    pub const SetCurrentChannel = _ZN18ImDrawListSplitter17SetCurrentChannelEP10ImDrawListi;
};

pub const ImDrawFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImDrawFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const Closed: ImDrawFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const RoundCornersTopLeft: ImDrawFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const RoundCornersTopRight: ImDrawFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const RoundCornersBottomLeft: ImDrawFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const RoundCornersBottomRight: ImDrawFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const RoundCornersNone: ImDrawFlags_ = .{ .bits = @intCast(c_uint, 1 << 8) };
    pub const RoundCornersTop: ImDrawFlags_ = .{ .bits = @intCast(c_uint, ImDrawFlags_.RoundCornersTopLeft.bits | ImDrawFlags_.RoundCornersTopRight.bits) };
    pub const RoundCornersBottom: ImDrawFlags_ = .{ .bits = @intCast(c_uint, ImDrawFlags_.RoundCornersBottomLeft.bits | ImDrawFlags_.RoundCornersBottomRight.bits) };
    pub const RoundCornersLeft: ImDrawFlags_ = .{ .bits = @intCast(c_uint, ImDrawFlags_.RoundCornersBottomLeft.bits | ImDrawFlags_.RoundCornersTopLeft.bits) };
    pub const RoundCornersRight: ImDrawFlags_ = .{ .bits = @intCast(c_uint, ImDrawFlags_.RoundCornersBottomRight.bits | ImDrawFlags_.RoundCornersTopRight.bits) };
    pub const RoundCornersAll: ImDrawFlags_ = .{ .bits = @intCast(c_uint, ImDrawFlags_.RoundCornersTopLeft.bits | ImDrawFlags_.RoundCornersTopRight.bits | ImDrawFlags_.RoundCornersBottomLeft.bits | ImDrawFlags_.RoundCornersBottomRight.bits) };
    pub const RoundCornersDefault_: ImDrawFlags_ = .{ .bits = @intCast(c_uint, ImDrawFlags_.RoundCornersAll.bits) };
    pub const RoundCornersMask_: ImDrawFlags_ = .{ .bits = @intCast(c_uint, ImDrawFlags_.RoundCornersAll.bits | ImDrawFlags_.RoundCornersNone.bits) };

    // pub usingnamespace cpp.FlagsMixin(ImDrawFlags_);
};

pub const ImDrawListFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImDrawListFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const AntiAliasedLines: ImDrawListFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const AntiAliasedLinesUseTex: ImDrawListFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const AntiAliasedFill: ImDrawListFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const AllowVtxOffset: ImDrawListFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };

    // pub usingnamespace cpp.FlagsMixin(ImDrawListFlags_);
};

pub const ImDrawList = extern struct {
    CmdBuffer: ImVector(ImDrawCmd),
    IdxBuffer: ImVector(ImDrawIdx),
    VtxBuffer: ImVector(ImDrawVert),
    Flags: ImDrawListFlags,
    _VtxCurrentIdx: c_uint,
    _Data: ?*ImDrawListSharedData,
    _OwnerName: [*c]const u8,
    _VtxWritePtr: [*c]ImDrawVert,
    _IdxWritePtr: [*c]ImDrawIdx,
    _ClipRectStack: ImVector(ImVec4),
    _TextureIdStack: ImVector(ImTextureID),
    _Path: ImVector(ImVec2),
    _CmdHeader: ImDrawCmdHeader,
    _Splitter: ImDrawListSplitter,
    _FringeScale: f32,

    extern fn _ZN10ImDrawListC1EP20ImDrawListSharedData(self: *ImDrawList, shared_data: ?*ImDrawListSharedData) void;
    pub inline fn init(shared_data: ?*ImDrawListSharedData) ImDrawList {
        var self: ImDrawList = undefined;
        _ZN10ImDrawListC1EP20ImDrawListSharedData(&self, shared_data);
        return self;
    }

    extern fn _ZN10ImDrawListD1Ev(self: *ImDrawList) void;
    pub inline fn deinit(self: *ImDrawList) void {
        self._ZN10ImDrawListD1Ev();
    }

    extern fn _ZN10ImDrawList12PushClipRectERK6ImVec2S2_b(self: *ImDrawList, clip_rect_min: *const ImVec2, clip_rect_max: *const ImVec2, intersect_with_current_clip_rect: bool) void;
    pub const PushClipRect = _ZN10ImDrawList12PushClipRectERK6ImVec2S2_b;

    extern fn _ZN10ImDrawList22PushClipRectFullScreenEv(self: *ImDrawList) void;
    pub const PushClipRectFullScreen = _ZN10ImDrawList22PushClipRectFullScreenEv;

    extern fn _ZN10ImDrawList11PopClipRectEv(self: *ImDrawList) void;
    pub const PopClipRect = _ZN10ImDrawList11PopClipRectEv;

    extern fn _ZN10ImDrawList13PushTextureIDEPv(self: *ImDrawList, texture_id: ImTextureID) void;
    pub const PushTextureID = _ZN10ImDrawList13PushTextureIDEPv;

    extern fn _ZN10ImDrawList12PopTextureIDEv(self: *ImDrawList) void;
    pub const PopTextureID = _ZN10ImDrawList12PopTextureIDEv;

    pub inline fn GetClipRectMin(self: *const ImDrawList) ImVec2 {
        const cr: *ImVec4 = self.back();
        return;
    }
    pub inline fn GetClipRectMax(self: *const ImDrawList) ImVec2 {
        const cr: *ImVec4 = self.back();
        return;
    }
    extern fn _ZN10ImDrawList7AddLineERK6ImVec2S2_jf(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, col: ImU32, thickness: f32) void;
    pub const AddLine = _ZN10ImDrawList7AddLineERK6ImVec2S2_jf;

    extern fn _ZN10ImDrawList7AddRectERK6ImVec2S2_jfif(self: *ImDrawList, p_min: *const ImVec2, p_max: *const ImVec2, col: ImU32, rounding: f32, flags: ImDrawFlags, thickness: f32) void;
    pub const AddRect = _ZN10ImDrawList7AddRectERK6ImVec2S2_jfif;

    extern fn _ZN10ImDrawList13AddRectFilledERK6ImVec2S2_jfi(self: *ImDrawList, p_min: *const ImVec2, p_max: *const ImVec2, col: ImU32, rounding: f32, flags: ImDrawFlags) void;
    pub const AddRectFilled = _ZN10ImDrawList13AddRectFilledERK6ImVec2S2_jfi;

    extern fn _ZN10ImDrawList23AddRectFilledMultiColorERK6ImVec2S2_jjjj(self: *ImDrawList, p_min: *const ImVec2, p_max: *const ImVec2, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32) void;
    pub const AddRectFilledMultiColor = _ZN10ImDrawList23AddRectFilledMultiColorERK6ImVec2S2_jjjj;

    extern fn _ZN10ImDrawList7AddQuadERK6ImVec2S2_S2_S2_jf(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, p4: *const ImVec2, col: ImU32, thickness: f32) void;
    pub const AddQuad = _ZN10ImDrawList7AddQuadERK6ImVec2S2_S2_S2_jf;

    extern fn _ZN10ImDrawList13AddQuadFilledERK6ImVec2S2_S2_S2_j(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, p4: *const ImVec2, col: ImU32) void;
    pub const AddQuadFilled = _ZN10ImDrawList13AddQuadFilledERK6ImVec2S2_S2_S2_j;

    extern fn _ZN10ImDrawList11AddTriangleERK6ImVec2S2_S2_jf(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, col: ImU32, thickness: f32) void;
    pub const AddTriangle = _ZN10ImDrawList11AddTriangleERK6ImVec2S2_S2_jf;

    extern fn _ZN10ImDrawList17AddTriangleFilledERK6ImVec2S2_S2_j(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, col: ImU32) void;
    pub const AddTriangleFilled = _ZN10ImDrawList17AddTriangleFilledERK6ImVec2S2_S2_j;

    extern fn _ZN10ImDrawList9AddCircleERK6ImVec2fjif(self: *ImDrawList, center: *const ImVec2, radius: f32, col: ImU32, num_segments: c_int, thickness: f32) void;
    pub const AddCircle = _ZN10ImDrawList9AddCircleERK6ImVec2fjif;

    extern fn _ZN10ImDrawList15AddCircleFilledERK6ImVec2fji(self: *ImDrawList, center: *const ImVec2, radius: f32, col: ImU32, num_segments: c_int) void;
    pub const AddCircleFilled = _ZN10ImDrawList15AddCircleFilledERK6ImVec2fji;

    extern fn _ZN10ImDrawList7AddNgonERK6ImVec2fjif(self: *ImDrawList, center: *const ImVec2, radius: f32, col: ImU32, num_segments: c_int, thickness: f32) void;
    pub const AddNgon = _ZN10ImDrawList7AddNgonERK6ImVec2fjif;

    extern fn _ZN10ImDrawList13AddNgonFilledERK6ImVec2fji(self: *ImDrawList, center: *const ImVec2, radius: f32, col: ImU32, num_segments: c_int) void;
    pub const AddNgonFilled = _ZN10ImDrawList13AddNgonFilledERK6ImVec2fji;

    extern fn _ZN10ImDrawList7AddTextERK6ImVec2jPKcS4_(self: *ImDrawList, pos: *const ImVec2, col: ImU32, text_begin: [*c]const u8, text_end: [*c]const u8) void;
    pub const AddText = _ZN10ImDrawList7AddTextERK6ImVec2jPKcS4_;

    extern fn _ZN10ImDrawList7AddTextEPK6ImFontfRK6ImVec2jPKcS7_fPK6ImVec4(self: *ImDrawList, font: [*c]const ImFont, font_size: f32, pos: *const ImVec2, col: ImU32, text_begin: [*c]const u8, text_end: [*c]const u8, wrap_width: f32, cpu_fine_clip_rect: [*c]const ImVec4) void;
    pub const AddText__Overload2 = _ZN10ImDrawList7AddTextEPK6ImFontfRK6ImVec2jPKcS7_fPK6ImVec4;

    extern fn _ZN10ImDrawList11AddPolylineEPK6ImVec2ijif(self: *ImDrawList, points: [*c]const ImVec2, num_points: c_int, col: ImU32, flags: ImDrawFlags, thickness: f32) void;
    pub const AddPolyline = _ZN10ImDrawList11AddPolylineEPK6ImVec2ijif;

    extern fn _ZN10ImDrawList19AddConvexPolyFilledEPK6ImVec2ij(self: *ImDrawList, points: [*c]const ImVec2, num_points: c_int, col: ImU32) void;
    pub const AddConvexPolyFilled = _ZN10ImDrawList19AddConvexPolyFilledEPK6ImVec2ij;

    extern fn _ZN10ImDrawList14AddBezierCubicERK6ImVec2S2_S2_S2_jfi(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, p4: *const ImVec2, col: ImU32, thickness: f32, num_segments: c_int) void;
    pub const AddBezierCubic = _ZN10ImDrawList14AddBezierCubicERK6ImVec2S2_S2_S2_jfi;

    extern fn _ZN10ImDrawList18AddBezierQuadraticERK6ImVec2S2_S2_jfi(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, col: ImU32, thickness: f32, num_segments: c_int) void;
    pub const AddBezierQuadratic = _ZN10ImDrawList18AddBezierQuadraticERK6ImVec2S2_S2_jfi;

    extern fn _ZN10ImDrawList8AddImageEPvRK6ImVec2S3_S3_S3_j(self: *ImDrawList, user_texture_id: ImTextureID, p_min: *const ImVec2, p_max: *const ImVec2, uv_min: *const ImVec2, uv_max: *const ImVec2, col: ImU32) void;
    pub const AddImage = _ZN10ImDrawList8AddImageEPvRK6ImVec2S3_S3_S3_j;

    extern fn _ZN10ImDrawList12AddImageQuadEPvRK6ImVec2S3_S3_S3_S3_S3_S3_S3_j(self: *ImDrawList, user_texture_id: ImTextureID, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, p4: *const ImVec2, uv1: *const ImVec2, uv2: *const ImVec2, uv3: *const ImVec2, uv4: *const ImVec2, col: ImU32) void;
    pub const AddImageQuad = _ZN10ImDrawList12AddImageQuadEPvRK6ImVec2S3_S3_S3_S3_S3_S3_S3_j;

    extern fn _ZN10ImDrawList15AddImageRoundedEPvRK6ImVec2S3_S3_S3_jfi(self: *ImDrawList, user_texture_id: ImTextureID, p_min: *const ImVec2, p_max: *const ImVec2, uv_min: *const ImVec2, uv_max: *const ImVec2, col: ImU32, rounding: f32, flags: ImDrawFlags) void;
    pub const AddImageRounded = _ZN10ImDrawList15AddImageRoundedEPvRK6ImVec2S3_S3_S3_jfi;

    pub inline fn PathClear(self: *ImDrawList) void {
        self._Path.Size = 0;
    }
    pub inline fn PathLineTo(self: *ImDrawList, pos: *const ImVec2) void {
        self.push_back(pos);
    }
    pub inline fn PathLineToMergeDuplicate(self: *ImDrawList, pos: *const ImVec2) void {
        if (self._Path.Size == 0 or memcmp(@bitCast(?*const anyopaque, &self._Path.Data[self._Path.Size - 1]), @bitCast(?*const anyopaque, &pos), @intCast(usize, 8)) != 0) self.push_back(pos);
    }
    pub inline fn PathFillConvex(self: *ImDrawList, col: ImU32) void {
        self.AddConvexPolyFilled(self._Path.Data, self._Path.Size, col);
        self._Path.Size = 0;
    }
    pub inline fn PathStroke(self: *ImDrawList, col: ImU32, flags: ImDrawFlags, thickness: f32) void {
        self.AddPolyline(self._Path.Data, self._Path.Size, col, flags, thickness);
        self._Path.Size = 0;
    }
    extern fn _ZN10ImDrawList9PathArcToERK6ImVec2fffi(self: *ImDrawList, center: *const ImVec2, radius: f32, a_min: f32, a_max: f32, num_segments: c_int) void;
    pub const PathArcTo = _ZN10ImDrawList9PathArcToERK6ImVec2fffi;

    extern fn _ZN10ImDrawList13PathArcToFastERK6ImVec2fii(self: *ImDrawList, center: *const ImVec2, radius: f32, a_min_of_12: c_int, a_max_of_12: c_int) void;
    pub const PathArcToFast = _ZN10ImDrawList13PathArcToFastERK6ImVec2fii;

    extern fn _ZN10ImDrawList22PathBezierCubicCurveToERK6ImVec2S2_S2_i(self: *ImDrawList, p2: *const ImVec2, p3: *const ImVec2, p4: *const ImVec2, num_segments: c_int) void;
    pub const PathBezierCubicCurveTo = _ZN10ImDrawList22PathBezierCubicCurveToERK6ImVec2S2_S2_i;

    extern fn _ZN10ImDrawList26PathBezierQuadraticCurveToERK6ImVec2S2_i(self: *ImDrawList, p2: *const ImVec2, p3: *const ImVec2, num_segments: c_int) void;
    pub const PathBezierQuadraticCurveTo = _ZN10ImDrawList26PathBezierQuadraticCurveToERK6ImVec2S2_i;

    extern fn _ZN10ImDrawList8PathRectERK6ImVec2S2_fi(self: *ImDrawList, rect_min: *const ImVec2, rect_max: *const ImVec2, rounding: f32, flags: ImDrawFlags) void;
    pub const PathRect = _ZN10ImDrawList8PathRectERK6ImVec2S2_fi;

    extern fn _ZN10ImDrawList11AddCallbackEPFvPKS_PK9ImDrawCmdEPv(self: *ImDrawList, callback: ImDrawCallback, callback_data: ?*anyopaque) void;
    pub const AddCallback = _ZN10ImDrawList11AddCallbackEPFvPKS_PK9ImDrawCmdEPv;

    extern fn _ZN10ImDrawList10AddDrawCmdEv(self: *ImDrawList) void;
    pub const AddDrawCmd = _ZN10ImDrawList10AddDrawCmdEv;

    extern fn _ZNK10ImDrawList11CloneOutputEv(self: *const ImDrawList) [*c]ImDrawList;
    pub const CloneOutput = _ZNK10ImDrawList11CloneOutputEv;

    pub inline fn ChannelsSplit(self: *ImDrawList, count: c_int) void {
        self.Split(self, count);
    }
    pub inline fn ChannelsMerge(self: *ImDrawList) void {
        self.Merge(self);
    }
    pub inline fn ChannelsSetCurrent(self: *ImDrawList, n: c_int) void {
        self.SetCurrentChannel(self, n);
    }
    extern fn _ZN10ImDrawList11PrimReserveEii(self: *ImDrawList, idx_count: c_int, vtx_count: c_int) void;
    pub const PrimReserve = _ZN10ImDrawList11PrimReserveEii;

    extern fn _ZN10ImDrawList13PrimUnreserveEii(self: *ImDrawList, idx_count: c_int, vtx_count: c_int) void;
    pub const PrimUnreserve = _ZN10ImDrawList13PrimUnreserveEii;

    extern fn _ZN10ImDrawList8PrimRectERK6ImVec2S2_j(self: *ImDrawList, a: *const ImVec2, b: *const ImVec2, col: ImU32) void;
    pub const PrimRect = _ZN10ImDrawList8PrimRectERK6ImVec2S2_j;

    extern fn _ZN10ImDrawList10PrimRectUVERK6ImVec2S2_S2_S2_j(self: *ImDrawList, a: *const ImVec2, b: *const ImVec2, uv_a: *const ImVec2, uv_b: *const ImVec2, col: ImU32) void;
    pub const PrimRectUV = _ZN10ImDrawList10PrimRectUVERK6ImVec2S2_S2_S2_j;

    extern fn _ZN10ImDrawList10PrimQuadUVERK6ImVec2S2_S2_S2_S2_S2_S2_S2_j(self: *ImDrawList, a: *const ImVec2, b: *const ImVec2, c: *const ImVec2, d: *const ImVec2, uv_a: *const ImVec2, uv_b: *const ImVec2, uv_c: *const ImVec2, uv_d: *const ImVec2, col: ImU32) void;
    pub const PrimQuadUV = _ZN10ImDrawList10PrimQuadUVERK6ImVec2S2_S2_S2_S2_S2_S2_S2_j;

    pub inline fn PrimWriteVtx(self: *ImDrawList, pos: *const ImVec2, uv: *const ImVec2, col: ImU32) void {
        self._VtxWritePtr.pos.copyFrom(pos);
        self._VtxWritePtr.uv.copyFrom(uv);
        self._VtxWritePtr.col = col;
        self._VtxWritePtr += 1;
        self._VtxCurrentIdx += 1;
    }
    pub inline fn PrimWriteIdx(self: *ImDrawList, idx: ImDrawIdx) void {
        self._IdxWritePtr.* = idx;
        self._IdxWritePtr += 1;
    }
    pub inline fn PrimVtx(self: *ImDrawList, pos: *const ImVec2, uv: *const ImVec2, col: ImU32) void {
        self.PrimWriteIdx(@intCast(ImDrawIdx, self._VtxCurrentIdx));
        self.PrimWriteVtx(pos, uv, col);
    }
    extern fn _ZN10ImDrawList17_ResetForNewFrameEv(self: *ImDrawList) void;
    pub const _ResetForNewFrame = _ZN10ImDrawList17_ResetForNewFrameEv;

    extern fn _ZN10ImDrawList16_ClearFreeMemoryEv(self: *ImDrawList) void;
    pub const _ClearFreeMemory = _ZN10ImDrawList16_ClearFreeMemoryEv;

    extern fn _ZN10ImDrawList17_PopUnusedDrawCmdEv(self: *ImDrawList) void;
    pub const _PopUnusedDrawCmd = _ZN10ImDrawList17_PopUnusedDrawCmdEv;

    extern fn _ZN10ImDrawList17_TryMergeDrawCmdsEv(self: *ImDrawList) void;
    pub const _TryMergeDrawCmds = _ZN10ImDrawList17_TryMergeDrawCmdsEv;

    extern fn _ZN10ImDrawList18_OnChangedClipRectEv(self: *ImDrawList) void;
    pub const _OnChangedClipRect = _ZN10ImDrawList18_OnChangedClipRectEv;

    extern fn _ZN10ImDrawList19_OnChangedTextureIDEv(self: *ImDrawList) void;
    pub const _OnChangedTextureID = _ZN10ImDrawList19_OnChangedTextureIDEv;

    extern fn _ZN10ImDrawList19_OnChangedVtxOffsetEv(self: *ImDrawList) void;
    pub const _OnChangedVtxOffset = _ZN10ImDrawList19_OnChangedVtxOffsetEv;

    extern fn _ZNK10ImDrawList27_CalcCircleAutoSegmentCountEf(self: *const ImDrawList, radius: f32) c_int;
    pub const _CalcCircleAutoSegmentCount = _ZNK10ImDrawList27_CalcCircleAutoSegmentCountEf;

    extern fn _ZN10ImDrawList16_PathArcToFastExERK6ImVec2fiii(self: *ImDrawList, center: *const ImVec2, radius: f32, a_min_sample: c_int, a_max_sample: c_int, a_step: c_int) void;
    pub const _PathArcToFastEx = _ZN10ImDrawList16_PathArcToFastExERK6ImVec2fiii;

    extern fn _ZN10ImDrawList11_PathArcToNERK6ImVec2fffi(self: *ImDrawList, center: *const ImVec2, radius: f32, a_min: f32, a_max: f32, num_segments: c_int) void;
    pub const _PathArcToN = _ZN10ImDrawList11_PathArcToNERK6ImVec2fffi;
};

pub const ImDrawData = extern struct {
    Valid: bool,
    CmdListsCount: c_int,
    TotalIdxCount: c_int,
    TotalVtxCount: c_int,
    CmdLists: [*c][*c]ImDrawList,
    DisplayPos: ImVec2,
    DisplaySize: ImVec2,
    FramebufferScale: ImVec2,
    OwnerViewport: [*c]ImGuiViewport,

    extern fn _ZN10ImDrawDataC1Ev(self: *ImDrawData) void;
    pub inline fn init() ImDrawData {
        var self: ImDrawData = undefined;
        _ZN10ImDrawDataC1Ev(&self);
        return self;
    }

    pub fn Clear(self: *ImDrawData) void {
        memset(@bitCast(?*anyopaque, self), 0, @sizeOf(self.*));
    }
    extern fn _ZN10ImDrawData17DeIndexAllBuffersEv(self: *ImDrawData) void;
    pub const DeIndexAllBuffers = _ZN10ImDrawData17DeIndexAllBuffersEv;

    extern fn _ZN10ImDrawData14ScaleClipRectsERK6ImVec2(self: *ImDrawData, fb_scale: *const ImVec2) void;
    pub const ScaleClipRects = _ZN10ImDrawData14ScaleClipRectsERK6ImVec2;
};

pub const ImFontConfig = extern struct {
    FontData: ?*anyopaque,
    FontDataSize: c_int,
    FontDataOwnedByAtlas: bool,
    FontNo: c_int,
    SizePixels: f32,
    OversampleH: c_int,
    OversampleV: c_int,
    PixelSnapH: bool,
    GlyphExtraSpacing: ImVec2,
    GlyphOffset: ImVec2,
    GlyphRanges: [*c]const ImWchar,
    GlyphMinAdvanceX: f32,
    GlyphMaxAdvanceX: f32,
    MergeMode: bool,
    FontBuilderFlags: c_uint,
    RasterizerMultiply: f32,
    EllipsisChar: ImWchar,
    Name: [40]u8,
    DstFont: [*c]ImFont,

    extern fn _ZN12ImFontConfigC1Ev(self: *ImFontConfig) void;
    pub inline fn init() ImFontConfig {
        var self: ImFontConfig = undefined;
        _ZN12ImFontConfigC1Ev(&self);
        return self;
    }
};

pub const ImFontGlyph = extern struct {
    Colored: c_uint,
    Visible: c_uint,
    Codepoint: c_uint,
    AdvanceX: f32,
    X0: f32,
    Y0: f32,
    X1: f32,
    Y1: f32,
    U0: f32,
    V0: f32,
    U1: f32,
    V1: f32,
};

pub const ImFontGlyphRangesBuilder = extern struct {
    UsedChars: ImVector(ImU32),

    extern fn _ZN24ImFontGlyphRangesBuilderC1Ev(self: *ImFontGlyphRangesBuilder) void;
    pub inline fn init() ImFontGlyphRangesBuilder {
        var self: ImFontGlyphRangesBuilder = undefined;
        _ZN24ImFontGlyphRangesBuilderC1Ev(&self);
        return self;
    }

    pub inline fn Clear(self: *ImFontGlyphRangesBuilder) void {
        var size_in_bytes: c_int = (65535 + 1) / 8;
        self.resize(size_in_bytes / @intCast(c_int, @sizeOf(ImU32)));
        memset(@bitCast(?*anyopaque, self.UsedChars.Data), 0, @intCast(usize, size_in_bytes));
    }
    pub inline fn GetBit(self: *const ImFontGlyphRangesBuilder, n: usize) bool {
        var off: c_int = @intCast(c_int, (n >> 5));
        var mask: ImU32 = 1 << (n & @intCast(usize, 31));
        return (self.UsedChars.get(off) & mask) != @intCast(c_uint, 0);
    }
    pub inline fn SetBit(self: *ImFontGlyphRangesBuilder, n: usize) void {
        var off: c_int = @intCast(c_int, (n >> 5));
        var mask: ImU32 = 1 << (n & @intCast(usize, 31));
        self.UsedChars.getPtr(off).* |= mask;
    }
    pub inline fn AddChar(self: *ImFontGlyphRangesBuilder, c: ImWchar) void {
        self.SetBit(@intCast(usize, c));
    }
    extern fn _ZN24ImFontGlyphRangesBuilder7AddTextEPKcS1_(self: *ImFontGlyphRangesBuilder, text: [*c]const u8, text_end: [*c]const u8) void;
    pub const AddText = _ZN24ImFontGlyphRangesBuilder7AddTextEPKcS1_;

    extern fn _ZN24ImFontGlyphRangesBuilder9AddRangesEPKt(self: *ImFontGlyphRangesBuilder, ranges: [*c]const ImWchar) void;
    pub const AddRanges = _ZN24ImFontGlyphRangesBuilder9AddRangesEPKt;

    extern fn _ZN24ImFontGlyphRangesBuilder11BuildRangesEP8ImVectorItE(self: *ImFontGlyphRangesBuilder, out_ranges: [*c]ImVector(ImWchar)) void;
    pub const BuildRanges = _ZN24ImFontGlyphRangesBuilder11BuildRangesEP8ImVectorItE;
};

pub const ImFontAtlasCustomRect = extern struct {
    Width: c_ushort,
    Height: c_ushort,
    X: c_ushort,
    Y: c_ushort,
    GlyphID: c_uint,
    GlyphAdvanceX: f32,
    GlyphOffset: ImVec2,
    Font: [*c]ImFont,

    extern fn _ZN21ImFontAtlasCustomRectC1Ev(self: *ImFontAtlasCustomRect) void;
    pub inline fn init() ImFontAtlasCustomRect {
        var self: ImFontAtlasCustomRect = undefined;
        _ZN21ImFontAtlasCustomRectC1Ev(&self);
        return self;
    }

    pub fn IsPacked(self: *const ImFontAtlasCustomRect) bool {
        return @intCast(c_int, self.X) != 65535;
    }
};

pub const ImFontAtlasFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImFontAtlasFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const NoPowerOfTwoHeight: ImFontAtlasFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const NoMouseCursors: ImFontAtlasFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const NoBakedLines: ImFontAtlasFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };

    // pub usingnamespace cpp.FlagsMixin(ImFontAtlasFlags_);
};

pub const ImFontAtlas = extern struct {
    Flags: ImFontAtlasFlags,
    TexID: ImTextureID,
    TexDesiredWidth: c_int,
    TexGlyphPadding: c_int,
    Locked: bool,
    UserData: ?*anyopaque,
    TexReady: bool,
    TexPixelsUseColors: bool,
    TexPixelsAlpha8: [*c]u8,
    TexPixelsRGBA32: [*c]c_uint,
    TexWidth: c_int,
    TexHeight: c_int,
    TexUvScale: ImVec2,
    TexUvWhitePixel: ImVec2,
    Fonts: ImVector([*c]ImFont),
    CustomRects: ImVector(ImFontAtlasCustomRect),
    ConfigData: ImVector(ImFontConfig),
    TexUvLines: [64]ImVec4,
    FontBuilderIO: ?*const ImFontBuilderIO,
    FontBuilderFlags: c_uint,
    PackIdMouseCursors: c_int,
    PackIdLines: c_int,

    extern fn _ZN11ImFontAtlasC1Ev(self: *ImFontAtlas) void;
    pub inline fn init() ImFontAtlas {
        var self: ImFontAtlas = undefined;
        _ZN11ImFontAtlasC1Ev(&self);
        return self;
    }

    extern fn _ZN11ImFontAtlasD1Ev(self: *ImFontAtlas) void;
    pub inline fn deinit(self: *ImFontAtlas) void {
        self._ZN11ImFontAtlasD1Ev();
    }

    extern fn _ZN11ImFontAtlas7AddFontEPK12ImFontConfig(self: *ImFontAtlas, font_cfg: [*c]const ImFontConfig) [*c]ImFont;
    pub const AddFont = _ZN11ImFontAtlas7AddFontEPK12ImFontConfig;

    extern fn _ZN11ImFontAtlas14AddFontDefaultEPK12ImFontConfig(self: *ImFontAtlas, font_cfg: [*c]const ImFontConfig) [*c]ImFont;
    pub const AddFontDefault = _ZN11ImFontAtlas14AddFontDefaultEPK12ImFontConfig;

    extern fn _ZN11ImFontAtlas18AddFontFromFileTTFEPKcfPK12ImFontConfigPKt(self: *ImFontAtlas, filename: [*c]const u8, size_pixels: f32, font_cfg: [*c]const ImFontConfig, glyph_ranges: [*c]const ImWchar) [*c]ImFont;
    pub const AddFontFromFileTTF = _ZN11ImFontAtlas18AddFontFromFileTTFEPKcfPK12ImFontConfigPKt;

    extern fn _ZN11ImFontAtlas20AddFontFromMemoryTTFEPvifPK12ImFontConfigPKt(self: *ImFontAtlas, font_data: ?*anyopaque, font_size: c_int, size_pixels: f32, font_cfg: [*c]const ImFontConfig, glyph_ranges: [*c]const ImWchar) [*c]ImFont;
    pub const AddFontFromMemoryTTF = _ZN11ImFontAtlas20AddFontFromMemoryTTFEPvifPK12ImFontConfigPKt;

    extern fn _ZN11ImFontAtlas30AddFontFromMemoryCompressedTTFEPKvifPK12ImFontConfigPKt(self: *ImFontAtlas, compressed_font_data: ?*const anyopaque, compressed_font_size: c_int, size_pixels: f32, font_cfg: [*c]const ImFontConfig, glyph_ranges: [*c]const ImWchar) [*c]ImFont;
    pub const AddFontFromMemoryCompressedTTF = _ZN11ImFontAtlas30AddFontFromMemoryCompressedTTFEPKvifPK12ImFontConfigPKt;

    extern fn _ZN11ImFontAtlas36AddFontFromMemoryCompressedBase85TTFEPKcfPK12ImFontConfigPKt(self: *ImFontAtlas, compressed_font_data_base85: [*c]const u8, size_pixels: f32, font_cfg: [*c]const ImFontConfig, glyph_ranges: [*c]const ImWchar) [*c]ImFont;
    pub const AddFontFromMemoryCompressedBase85TTF = _ZN11ImFontAtlas36AddFontFromMemoryCompressedBase85TTFEPKcfPK12ImFontConfigPKt;

    extern fn _ZN11ImFontAtlas14ClearInputDataEv(self: *ImFontAtlas) void;
    pub const ClearInputData = _ZN11ImFontAtlas14ClearInputDataEv;

    extern fn _ZN11ImFontAtlas12ClearTexDataEv(self: *ImFontAtlas) void;
    pub const ClearTexData = _ZN11ImFontAtlas12ClearTexDataEv;

    extern fn _ZN11ImFontAtlas10ClearFontsEv(self: *ImFontAtlas) void;
    pub const ClearFonts = _ZN11ImFontAtlas10ClearFontsEv;

    extern fn _ZN11ImFontAtlas5ClearEv(self: *ImFontAtlas) void;
    pub const Clear = _ZN11ImFontAtlas5ClearEv;

    extern fn _ZN11ImFontAtlas5BuildEv(self: *ImFontAtlas) bool;
    pub const Build = _ZN11ImFontAtlas5BuildEv;

    extern fn _ZN11ImFontAtlas18GetTexDataAsAlpha8EPPhPiS2_S2_(self: *ImFontAtlas, out_pixels: [*c][*c]u8, out_width: [*c]c_int, out_height: [*c]c_int, out_bytes_per_pixel: [*c]c_int) void;
    pub const GetTexDataAsAlpha8 = _ZN11ImFontAtlas18GetTexDataAsAlpha8EPPhPiS2_S2_;

    extern fn _ZN11ImFontAtlas18GetTexDataAsRGBA32EPPhPiS2_S2_(self: *ImFontAtlas, out_pixels: [*c][*c]u8, out_width: [*c]c_int, out_height: [*c]c_int, out_bytes_per_pixel: [*c]c_int) void;
    pub const GetTexDataAsRGBA32 = _ZN11ImFontAtlas18GetTexDataAsRGBA32EPPhPiS2_S2_;

    pub fn IsBuilt(self: *const ImFontAtlas) bool {
        return self.Fonts.Size > 0 and self.TexReady;
    }
    pub fn SetTexID(self: *ImFontAtlas, id: ImTextureID) void {
        self.TexID = id;
    }
    extern fn _ZN11ImFontAtlas21GetGlyphRangesDefaultEv(self: *ImFontAtlas) [*c]const ImWchar;
    pub const GetGlyphRangesDefault = _ZN11ImFontAtlas21GetGlyphRangesDefaultEv;

    extern fn _ZN11ImFontAtlas19GetGlyphRangesGreekEv(self: *ImFontAtlas) [*c]const ImWchar;
    pub const GetGlyphRangesGreek = _ZN11ImFontAtlas19GetGlyphRangesGreekEv;

    extern fn _ZN11ImFontAtlas20GetGlyphRangesKoreanEv(self: *ImFontAtlas) [*c]const ImWchar;
    pub const GetGlyphRangesKorean = _ZN11ImFontAtlas20GetGlyphRangesKoreanEv;

    extern fn _ZN11ImFontAtlas22GetGlyphRangesJapaneseEv(self: *ImFontAtlas) [*c]const ImWchar;
    pub const GetGlyphRangesJapanese = _ZN11ImFontAtlas22GetGlyphRangesJapaneseEv;

    extern fn _ZN11ImFontAtlas25GetGlyphRangesChineseFullEv(self: *ImFontAtlas) [*c]const ImWchar;
    pub const GetGlyphRangesChineseFull = _ZN11ImFontAtlas25GetGlyphRangesChineseFullEv;

    extern fn _ZN11ImFontAtlas37GetGlyphRangesChineseSimplifiedCommonEv(self: *ImFontAtlas) [*c]const ImWchar;
    pub const GetGlyphRangesChineseSimplifiedCommon = _ZN11ImFontAtlas37GetGlyphRangesChineseSimplifiedCommonEv;

    extern fn _ZN11ImFontAtlas22GetGlyphRangesCyrillicEv(self: *ImFontAtlas) [*c]const ImWchar;
    pub const GetGlyphRangesCyrillic = _ZN11ImFontAtlas22GetGlyphRangesCyrillicEv;

    extern fn _ZN11ImFontAtlas18GetGlyphRangesThaiEv(self: *ImFontAtlas) [*c]const ImWchar;
    pub const GetGlyphRangesThai = _ZN11ImFontAtlas18GetGlyphRangesThaiEv;

    extern fn _ZN11ImFontAtlas24GetGlyphRangesVietnameseEv(self: *ImFontAtlas) [*c]const ImWchar;
    pub const GetGlyphRangesVietnamese = _ZN11ImFontAtlas24GetGlyphRangesVietnameseEv;

    extern fn _ZN11ImFontAtlas20AddCustomRectRegularEii(self: *ImFontAtlas, width: c_int, height: c_int) c_int;
    pub const AddCustomRectRegular = _ZN11ImFontAtlas20AddCustomRectRegularEii;

    extern fn _ZN11ImFontAtlas22AddCustomRectFontGlyphEP6ImFonttiifRK6ImVec2(self: *ImFontAtlas, font: [*c]ImFont, id: ImWchar, width: c_int, height: c_int, advance_x: f32, offset: *const ImVec2) c_int;
    pub const AddCustomRectFontGlyph = _ZN11ImFontAtlas22AddCustomRectFontGlyphEP6ImFonttiifRK6ImVec2;

    pub fn GetCustomRectByIndex(self: *ImFontAtlas, index: c_int) [*c]ImFontAtlasCustomRect {
        ImAssert(index >= 0);
        return &self.CustomRects.getPtr(index).*;
    }
    extern fn _ZNK11ImFontAtlas16CalcCustomRectUVEPK21ImFontAtlasCustomRectP6ImVec2S4_(self: *const ImFontAtlas, rect: [*c]const ImFontAtlasCustomRect, out_uv_min: [*c]ImVec2, out_uv_max: [*c]ImVec2) void;
    pub const CalcCustomRectUV = _ZNK11ImFontAtlas16CalcCustomRectUVEPK21ImFontAtlasCustomRectP6ImVec2S4_;

    extern fn _ZN11ImFontAtlas21GetMouseCursorTexDataEiP6ImVec2S1_S1_S1_(self: *ImFontAtlas, cursor: ImGuiMouseCursor, out_offset: [*c]ImVec2, out_size: [*c]ImVec2, out_uv_border: [*c]ImVec2, out_uv_fill: [*c]ImVec2) bool;
    pub const GetMouseCursorTexData = _ZN11ImFontAtlas21GetMouseCursorTexDataEiP6ImVec2S1_S1_S1_;
};

pub const ImFont = extern struct {
    IndexAdvanceX: ImVector(f32),
    FallbackAdvanceX: f32,
    FontSize: f32,
    IndexLookup: ImVector(ImWchar),
    Glyphs: ImVector(ImFontGlyph),
    FallbackGlyph: [*c]const ImFontGlyph,
    ContainerAtlas: [*c]ImFontAtlas,
    ConfigData: [*c]const ImFontConfig,
    ConfigDataCount: c_short,
    FallbackChar: ImWchar,
    EllipsisChar: ImWchar,
    EllipsisCharCount: c_short,
    EllipsisWidth: f32,
    EllipsisCharStep: f32,
    DirtyLookupTables: bool,
    Scale: f32,
    Ascent: f32,
    Descent: f32,
    MetricsTotalSurface: c_int,
    Used4kPagesMap: [2]ImU8,

    extern fn _ZN6ImFontC1Ev(self: *ImFont) void;
    pub inline fn init() ImFont {
        var self: ImFont = undefined;
        _ZN6ImFontC1Ev(&self);
        return self;
    }

    extern fn _ZN6ImFontD1Ev(self: *ImFont) void;
    pub inline fn deinit(self: *ImFont) void {
        self._ZN6ImFontD1Ev();
    }

    extern fn _ZNK6ImFont9FindGlyphEt(self: *const ImFont, c: ImWchar) [*c]const ImFontGlyph;
    pub const FindGlyph = _ZNK6ImFont9FindGlyphEt;

    extern fn _ZNK6ImFont19FindGlyphNoFallbackEt(self: *const ImFont, c: ImWchar) [*c]const ImFontGlyph;
    pub const FindGlyphNoFallback = _ZNK6ImFont19FindGlyphNoFallbackEt;

    pub fn GetCharAdvance(self: *const ImFont, c: ImWchar) f32 {
        return if ((@intCast(c_int, c) < self.IndexAdvanceX.Size)) self.IndexAdvanceX.get(@intCast(c_int, c)) else self.FallbackAdvanceX;
    }
    pub fn IsLoaded(self: *const ImFont) bool {
        return self.ContainerAtlas != null;
    }
    pub fn GetDebugName(self: *const ImFont) [*c]const u8 {
        return if (@as(bool, self.ConfigData)) @as([*c]const u8, self.ConfigData.Name) else @as([*c]const u8, "\"<unknown>\"");
    }
    extern fn _ZNK6ImFont13CalcTextSizeAEfffPKcS1_PS1_(self: *const ImFont, size: f32, max_width: f32, wrap_width: f32, text_begin: [*c]const u8, text_end: [*c]const u8, remaining: [*c]const [*c]u8) ImVec2;
    pub const CalcTextSizeA = _ZNK6ImFont13CalcTextSizeAEfffPKcS1_PS1_;

    extern fn _ZNK6ImFont21CalcWordWrapPositionAEfPKcS1_f(self: *const ImFont, scale: f32, text: [*c]const u8, text_end: [*c]const u8, wrap_width: f32) [*c]const u8;
    pub const CalcWordWrapPositionA = _ZNK6ImFont21CalcWordWrapPositionAEfPKcS1_f;

    extern fn _ZNK6ImFont10RenderCharEP10ImDrawListfRK6ImVec2jt(self: *const ImFont, draw_list: [*c]ImDrawList, size: f32, pos: *const ImVec2, col: ImU32, c: ImWchar) void;
    pub const RenderChar = _ZNK6ImFont10RenderCharEP10ImDrawListfRK6ImVec2jt;

    extern fn _ZNK6ImFont10RenderTextEP10ImDrawListfRK6ImVec2jRK6ImVec4PKcS9_fb(self: *const ImFont, draw_list: [*c]ImDrawList, size: f32, pos: *const ImVec2, col: ImU32, clip_rect: *const ImVec4, text_begin: [*c]const u8, text_end: [*c]const u8, wrap_width: f32, cpu_fine_clip: bool) void;
    pub const RenderText = _ZNK6ImFont10RenderTextEP10ImDrawListfRK6ImVec2jRK6ImVec4PKcS9_fb;

    extern fn _ZN6ImFont16BuildLookupTableEv(self: *ImFont) void;
    pub const BuildLookupTable = _ZN6ImFont16BuildLookupTableEv;

    extern fn _ZN6ImFont15ClearOutputDataEv(self: *ImFont) void;
    pub const ClearOutputData = _ZN6ImFont15ClearOutputDataEv;

    extern fn _ZN6ImFont9GrowIndexEi(self: *ImFont, new_size: c_int) void;
    pub const GrowIndex = _ZN6ImFont9GrowIndexEi;

    extern fn _ZN6ImFont8AddGlyphEPK12ImFontConfigtfffffffff(self: *ImFont, src_cfg: [*c]const ImFontConfig, c: ImWchar, x0: f32, y0: f32, x1: f32, y1: f32, u0: f32, v0: f32, u1: f32, v1: f32, advance_x: f32) void;
    pub const AddGlyph = _ZN6ImFont8AddGlyphEPK12ImFontConfigtfffffffff;

    extern fn _ZN6ImFont12AddRemapCharEttb(self: *ImFont, dst: ImWchar, src: ImWchar, overwrite_dst: bool) void;
    pub const AddRemapChar = _ZN6ImFont12AddRemapCharEttb;

    extern fn _ZN6ImFont15SetGlyphVisibleEtb(self: *ImFont, c: ImWchar, visible: bool) void;
    pub const SetGlyphVisible = _ZN6ImFont15SetGlyphVisibleEtb;

    extern fn _ZN6ImFont18IsGlyphRangeUnusedEjj(self: *ImFont, c_begin: c_uint, c_last: c_uint) bool;
    pub const IsGlyphRangeUnused = _ZN6ImFont18IsGlyphRangeUnusedEjj;
};

pub const ImGuiViewportFlags_ = extern struct {
    bits: c_int = 0,

    pub const None: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 0) };
    pub const IsPlatformWindow: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 0) };
    pub const IsPlatformMonitor: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 1) };
    pub const OwnedByApp: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 2) };
    pub const NoDecoration: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 3) };
    pub const NoTaskBarIcon: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 4) };
    pub const NoFocusOnAppearing: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 5) };
    pub const NoFocusOnClick: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 6) };
    pub const NoInputs: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 7) };
    pub const NoRendererClear: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 8) };
    pub const NoAutoMerge: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 9) };
    pub const TopMost: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 10) };
    pub const CanHostOtherWindows: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 11) };
    pub const IsMinimized: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 12) };
    pub const IsFocused: ImGuiViewportFlags_ = .{ .bits = @intCast(c_uint, 1 << 13) };

    // pub usingnamespace cpp.FlagsMixin(ImGuiViewportFlags_);
};

pub const ImGuiViewport = extern struct {
    ID: ImGuiID,
    Flags: ImGuiViewportFlags,
    Pos: ImVec2,
    Size: ImVec2,
    WorkPos: ImVec2,
    WorkSize: ImVec2,
    DpiScale: f32,
    ParentViewportId: ImGuiID,
    DrawData: [*c]ImDrawData,
    RendererUserData: ?*anyopaque,
    PlatformUserData: ?*anyopaque,
    PlatformHandle: ?*anyopaque,
    PlatformHandleRaw: ?*anyopaque,
    PlatformWindowCreated: bool,
    PlatformRequestMove: bool,
    PlatformRequestResize: bool,
    PlatformRequestClose: bool,

    extern fn _ZN13ImGuiViewportC1Ev(self: *ImGuiViewport) void;
    pub inline fn init() ImGuiViewport {
        var self: ImGuiViewport = undefined;
        _ZN13ImGuiViewportC1Ev(&self);
        return self;
    }

    extern fn _ZN13ImGuiViewportD1Ev(self: *ImGuiViewport) void;
    pub inline fn deinit(self: *ImGuiViewport) void {
        self._ZN13ImGuiViewportD1Ev();
    }

    pub fn GetCenter(self: *const ImGuiViewport) ImVec2 {
        return;
    }
    pub fn GetWorkCenter(self: *const ImGuiViewport) ImVec2 {
        return;
    }
};

pub const ImGuiPlatformIO = extern struct {
    Platform_CreateWindow: ?*const fn ([*c]ImGuiViewport) callconv(.C) void,
    Platform_DestroyWindow: ?*const fn ([*c]ImGuiViewport) callconv(.C) void,
    Platform_ShowWindow: ?*const fn ([*c]ImGuiViewport) callconv(.C) void,
    Platform_SetWindowPos: ?*const fn ([*c]ImGuiViewport, ImVec2) callconv(.C) void,
    Platform_GetWindowPos: ?*const fn ([*c]ImGuiViewport) callconv(.C) ImVec2,
    Platform_SetWindowSize: ?*const fn ([*c]ImGuiViewport, ImVec2) callconv(.C) void,
    Platform_GetWindowSize: ?*const fn ([*c]ImGuiViewport) callconv(.C) ImVec2,
    Platform_SetWindowFocus: ?*const fn ([*c]ImGuiViewport) callconv(.C) void,
    Platform_GetWindowFocus: ?*const fn ([*c]ImGuiViewport) callconv(.C) bool,
    Platform_GetWindowMinimized: ?*const fn ([*c]ImGuiViewport) callconv(.C) bool,
    Platform_SetWindowTitle: ?*const fn ([*c]ImGuiViewport, [*c]const u8) callconv(.C) void,
    Platform_SetWindowAlpha: ?*const fn ([*c]ImGuiViewport, f32) callconv(.C) void,
    Platform_UpdateWindow: ?*const fn ([*c]ImGuiViewport) callconv(.C) void,
    Platform_RenderWindow: ?*const fn ([*c]ImGuiViewport, ?*anyopaque) callconv(.C) void,
    Platform_SwapBuffers: ?*const fn ([*c]ImGuiViewport, ?*anyopaque) callconv(.C) void,
    Platform_GetWindowDpiScale: ?*const fn ([*c]ImGuiViewport) callconv(.C) f32,
    Platform_OnChangedViewport: ?*const fn ([*c]ImGuiViewport) callconv(.C) void,
    Platform_CreateVkSurface: ?*const fn ([*c]ImGuiViewport, ImU64, ?*const anyopaque, [*c]ImU64) callconv(.C) c_int,
    Renderer_CreateWindow: ?*const fn ([*c]ImGuiViewport) callconv(.C) void,
    Renderer_DestroyWindow: ?*const fn ([*c]ImGuiViewport) callconv(.C) void,
    Renderer_SetWindowSize: ?*const fn ([*c]ImGuiViewport, ImVec2) callconv(.C) void,
    Renderer_RenderWindow: ?*const fn ([*c]ImGuiViewport, ?*anyopaque) callconv(.C) void,
    Renderer_SwapBuffers: ?*const fn ([*c]ImGuiViewport, ?*anyopaque) callconv(.C) void,
    Monitors: ImVector(ImGuiPlatformMonitor),
    Viewports: ImVector([*c]ImGuiViewport),

    extern fn _ZN15ImGuiPlatformIOC1Ev(self: *ImGuiPlatformIO) void;
    pub inline fn init() ImGuiPlatformIO {
        var self: ImGuiPlatformIO = undefined;
        _ZN15ImGuiPlatformIOC1Ev(&self);
        return self;
    }
};

pub const ImGuiPlatformMonitor = extern struct {
    MainPos: ImVec2,
    MainSize: ImVec2,
    WorkPos: ImVec2,
    WorkSize: ImVec2,
    DpiScale: f32,

    extern fn _ZN20ImGuiPlatformMonitorC1Ev(self: *ImGuiPlatformMonitor) void;
    pub inline fn init() ImGuiPlatformMonitor {
        var self: ImGuiPlatformMonitor = undefined;
        _ZN20ImGuiPlatformMonitorC1Ev(&self);
        return self;
    }
};

pub const ImGuiPlatformImeData = extern struct {
    WantVisible: bool,
    InputPos: ImVec2,
    InputLineHeight: f32,

    extern fn _ZN20ImGuiPlatformImeDataC1Ev(self: *ImGuiPlatformImeData) void;
    pub inline fn init() ImGuiPlatformImeData {
        var self: ImGuiPlatformImeData = undefined;
        _ZN20ImGuiPlatformImeDataC1Ev(&self);
        return self;
    }
};

pub inline fn GetKeyIndex(key: ImGuiKey) ImGuiKey {
    ImAssert(@intCast(c_int, key) >= @intCast(c_int, ImGuiKey._NamedKey_BEGIN.bits) and @intCast(c_int, key) < @intCast(c_int, ImGuiKey._NamedKey_END.bits) and @as(bool, @as([*c]const u8, "\"ImGuiKey and native_index was merged together and native_index is disabled by IMGUI_DISABLE_OBSOLETE_KEYIO. Please switch to ImGuiKey.\"")));
    return key;
}

// opaques

const ImDrawListSharedData = anyopaque;
const ImGuiContext = anyopaque;
const ImFontBuilderIO = anyopaque;
