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
pub const ImTextureID = *void;
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
pub const ImGuiInputTextCallback = *const fn () c_int;
pub const ImGuiSizeCallback = *const fn () void;
pub const ImGuiMemAllocFunc = *const fn (usize) *void;
pub const ImGuiMemFreeFunc = *const fn (*void) void;
pub const ImVec2 = extern struct {
    x: f32,
    y: f32,
};

pub const ImVec4 = extern struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,
};

pub const ImGuiContext = anyopaque;
pub const ImDrawListSharedData = anyopaque;
pub const ImFontBuilderIO = anyopaque;

pub const ImGui = struct {
    pub const CreateContext = _ZN5ImGui13CreateContextEP11ImFontAtlas;
    extern fn _ZN5ImGui13CreateContextEP11ImFontAtlas(shared_font_atlas: *ImFontAtlas) *ImGuiContext;
    pub const DestroyContext = _ZN5ImGui14DestroyContextEP12ImGuiContext;
    extern fn _ZN5ImGui14DestroyContextEP12ImGuiContext(ctx: *ImGuiContext) void;
    pub const GetCurrentContext = _ZN5ImGui17GetCurrentContextEv;
    extern fn _ZN5ImGui17GetCurrentContextEv() *ImGuiContext;
    pub const SetCurrentContext = _ZN5ImGui17SetCurrentContextEP12ImGuiContext;
    extern fn _ZN5ImGui17SetCurrentContextEP12ImGuiContext(ctx: *ImGuiContext) void;
    pub const GetIO = _ZN5ImGui5GetIOEv;
    extern fn _ZN5ImGui5GetIOEv() *ImGuiIO;
    pub const GetStyle = _ZN5ImGui8GetStyleEv;
    extern fn _ZN5ImGui8GetStyleEv() *ImGuiStyle;
    pub const NewFrame = _ZN5ImGui8NewFrameEv;
    extern fn _ZN5ImGui8NewFrameEv() void;
    pub const EndFrame = _ZN5ImGui8EndFrameEv;
    extern fn _ZN5ImGui8EndFrameEv() void;
    pub const Render = _ZN5ImGui6RenderEv;
    extern fn _ZN5ImGui6RenderEv() void;
    pub const GetDrawData = _ZN5ImGui11GetDrawDataEv;
    extern fn _ZN5ImGui11GetDrawDataEv() *ImDrawData;
    pub const ShowDemoWindow = _ZN5ImGui14ShowDemoWindowEPb;
    extern fn _ZN5ImGui14ShowDemoWindowEPb(p_open: *bool) void;
    pub const ShowMetricsWindow = _ZN5ImGui17ShowMetricsWindowEPb;
    extern fn _ZN5ImGui17ShowMetricsWindowEPb(p_open: *bool) void;
    pub const ShowDebugLogWindow = _ZN5ImGui18ShowDebugLogWindowEPb;
    extern fn _ZN5ImGui18ShowDebugLogWindowEPb(p_open: *bool) void;
    pub const ShowStackToolWindow = _ZN5ImGui19ShowStackToolWindowEPb;
    extern fn _ZN5ImGui19ShowStackToolWindowEPb(p_open: *bool) void;
    pub const ShowAboutWindow = _ZN5ImGui15ShowAboutWindowEPb;
    extern fn _ZN5ImGui15ShowAboutWindowEPb(p_open: *bool) void;
    pub const ShowStyleEditor = _ZN5ImGui15ShowStyleEditorEP10ImGuiStyle;
    extern fn _ZN5ImGui15ShowStyleEditorEP10ImGuiStyle(ref: *ImGuiStyle) void;
    pub const ShowStyleSelector = _ZN5ImGui17ShowStyleSelectorEPKc;
    extern fn _ZN5ImGui17ShowStyleSelectorEPKc(label: *const u8) bool;
    pub const ShowFontSelector = _ZN5ImGui16ShowFontSelectorEPKc;
    extern fn _ZN5ImGui16ShowFontSelectorEPKc(label: *const u8) void;
    pub const ShowUserGuide = _ZN5ImGui13ShowUserGuideEv;
    extern fn _ZN5ImGui13ShowUserGuideEv() void;
    pub const GetVersion = _ZN5ImGui10GetVersionEv;
    extern fn _ZN5ImGui10GetVersionEv() *const u8;
    pub const StyleColorsDark = _ZN5ImGui15StyleColorsDarkEP10ImGuiStyle;
    extern fn _ZN5ImGui15StyleColorsDarkEP10ImGuiStyle(dst: *ImGuiStyle) void;
    pub const StyleColorsLight = _ZN5ImGui16StyleColorsLightEP10ImGuiStyle;
    extern fn _ZN5ImGui16StyleColorsLightEP10ImGuiStyle(dst: *ImGuiStyle) void;
    pub const StyleColorsClassic = _ZN5ImGui18StyleColorsClassicEP10ImGuiStyle;
    extern fn _ZN5ImGui18StyleColorsClassicEP10ImGuiStyle(dst: *ImGuiStyle) void;
    pub const Begin = _ZN5ImGui5BeginEPKcPbi;
    extern fn _ZN5ImGui5BeginEPKcPbi(name: *const u8, p_open: *bool, flags: ImGuiWindowFlags) bool;
    pub const End = _ZN5ImGui3EndEv;
    extern fn _ZN5ImGui3EndEv() void;
    pub const BeginChild = _ZN5ImGui10BeginChildEPKcRK6ImVec2bi;
    extern fn _ZN5ImGui10BeginChildEPKcRK6ImVec2bi(str_id: *const u8, size: *const ImVec2, border: bool, flags: ImGuiWindowFlags) bool;
    pub const BeginChildId = _ZN5ImGui10BeginChildEjRK6ImVec2bi;
    extern fn _ZN5ImGui10BeginChildEjRK6ImVec2bi(id: ImGuiID, size: *const ImVec2, border: bool, flags: ImGuiWindowFlags) bool;
    pub const EndChild = _ZN5ImGui8EndChildEv;
    extern fn _ZN5ImGui8EndChildEv() void;
    pub const IsWindowAppearing = _ZN5ImGui17IsWindowAppearingEv;
    extern fn _ZN5ImGui17IsWindowAppearingEv() bool;
    pub const IsWindowCollapsed = _ZN5ImGui17IsWindowCollapsedEv;
    extern fn _ZN5ImGui17IsWindowCollapsedEv() bool;
    pub const IsWindowFocused = _ZN5ImGui15IsWindowFocusedEi;
    extern fn _ZN5ImGui15IsWindowFocusedEi(flags: ImGuiFocusedFlags) bool;
    pub const IsWindowHovered = _ZN5ImGui15IsWindowHoveredEi;
    extern fn _ZN5ImGui15IsWindowHoveredEi(flags: ImGuiHoveredFlags) bool;
    pub const GetWindowDrawList = _ZN5ImGui17GetWindowDrawListEv;
    extern fn _ZN5ImGui17GetWindowDrawListEv() *ImDrawList;
    pub const GetWindowDpiScale = _ZN5ImGui17GetWindowDpiScaleEv;
    extern fn _ZN5ImGui17GetWindowDpiScaleEv() f32;
    pub const GetWindowPos = _ZN5ImGui12GetWindowPosEv;
    extern fn _ZN5ImGui12GetWindowPosEv() ImVec2;
    pub const GetWindowSize = _ZN5ImGui13GetWindowSizeEv;
    extern fn _ZN5ImGui13GetWindowSizeEv() ImVec2;
    pub const GetWindowWidth = _ZN5ImGui14GetWindowWidthEv;
    extern fn _ZN5ImGui14GetWindowWidthEv() f32;
    pub const GetWindowHeight = _ZN5ImGui15GetWindowHeightEv;
    extern fn _ZN5ImGui15GetWindowHeightEv() f32;
    pub const GetWindowViewport = _ZN5ImGui17GetWindowViewportEv;
    extern fn _ZN5ImGui17GetWindowViewportEv() *ImGuiViewport;
    pub const SetNextWindowPos = _ZN5ImGui16SetNextWindowPosERK6ImVec2iS2_;
    extern fn _ZN5ImGui16SetNextWindowPosERK6ImVec2iS2_(pos: *const ImVec2, cond: ImGuiCond, pivot: *const ImVec2) void;
    pub const SetNextWindowSize = _ZN5ImGui17SetNextWindowSizeERK6ImVec2i;
    extern fn _ZN5ImGui17SetNextWindowSizeERK6ImVec2i(size: *const ImVec2, cond: ImGuiCond) void;
    pub const SetNextWindowSizeConstraints = _ZN5ImGui28SetNextWindowSizeConstraintsERK6ImVec2S2_PFvP21ImGuiSizeCallbackDataEPv;
    extern fn _ZN5ImGui28SetNextWindowSizeConstraintsERK6ImVec2S2_PFvP21ImGuiSizeCallbackDataEPv(size_min: *const ImVec2, size_max: *const ImVec2, custom_callback: ImGuiSizeCallback, custom_callback_data: *void) void;
    pub const SetNextWindowContentSize = _ZN5ImGui24SetNextWindowContentSizeERK6ImVec2;
    extern fn _ZN5ImGui24SetNextWindowContentSizeERK6ImVec2(size: *const ImVec2) void;
    pub const SetNextWindowCollapsed = _ZN5ImGui22SetNextWindowCollapsedEbi;
    extern fn _ZN5ImGui22SetNextWindowCollapsedEbi(collapsed: bool, cond: ImGuiCond) void;
    pub const SetNextWindowFocus = _ZN5ImGui18SetNextWindowFocusEv;
    extern fn _ZN5ImGui18SetNextWindowFocusEv() void;
    pub const SetNextWindowScroll = _ZN5ImGui19SetNextWindowScrollERK6ImVec2;
    extern fn _ZN5ImGui19SetNextWindowScrollERK6ImVec2(scroll: *const ImVec2) void;
    pub const SetNextWindowBgAlpha = _ZN5ImGui20SetNextWindowBgAlphaEf;
    extern fn _ZN5ImGui20SetNextWindowBgAlphaEf(alpha: f32) void;
    pub const SetNextWindowViewport = _ZN5ImGui21SetNextWindowViewportEj;
    extern fn _ZN5ImGui21SetNextWindowViewportEj(viewport_id: ImGuiID) void;
    pub const SetWindowPos = _ZN5ImGui12SetWindowPosERK6ImVec2i;
    extern fn _ZN5ImGui12SetWindowPosERK6ImVec2i(pos: *const ImVec2, cond: ImGuiCond) void;
    pub const SetWindowSize = _ZN5ImGui13SetWindowSizeERK6ImVec2i;
    extern fn _ZN5ImGui13SetWindowSizeERK6ImVec2i(size: *const ImVec2, cond: ImGuiCond) void;
    pub const SetWindowCollapsed = _ZN5ImGui18SetWindowCollapsedEbi;
    extern fn _ZN5ImGui18SetWindowCollapsedEbi(collapsed: bool, cond: ImGuiCond) void;
    pub const SetWindowFocus = _ZN5ImGui14SetWindowFocusEv;
    extern fn _ZN5ImGui14SetWindowFocusEv() void;
    pub const SetWindowFontScale = _ZN5ImGui18SetWindowFontScaleEf;
    extern fn _ZN5ImGui18SetWindowFontScaleEf(scale: f32) void;
    pub const SetWindowPosByName = _ZN5ImGui12SetWindowPosEPKcRK6ImVec2i;
    extern fn _ZN5ImGui12SetWindowPosEPKcRK6ImVec2i(name: *const u8, pos: *const ImVec2, cond: ImGuiCond) void;
    pub const SetWindowSizeByName = _ZN5ImGui13SetWindowSizeEPKcRK6ImVec2i;
    extern fn _ZN5ImGui13SetWindowSizeEPKcRK6ImVec2i(name: *const u8, size: *const ImVec2, cond: ImGuiCond) void;
    pub const SetWindowCollapsedByName = _ZN5ImGui18SetWindowCollapsedEPKcbi;
    extern fn _ZN5ImGui18SetWindowCollapsedEPKcbi(name: *const u8, collapsed: bool, cond: ImGuiCond) void;
    pub const SetWindowFocusByName = _ZN5ImGui14SetWindowFocusEPKc;
    extern fn _ZN5ImGui14SetWindowFocusEPKc(name: *const u8) void;
    pub const GetContentRegionAvail = _ZN5ImGui21GetContentRegionAvailEv;
    extern fn _ZN5ImGui21GetContentRegionAvailEv() ImVec2;
    pub const GetContentRegionMax = _ZN5ImGui19GetContentRegionMaxEv;
    extern fn _ZN5ImGui19GetContentRegionMaxEv() ImVec2;
    pub const GetWindowContentRegionMin = _ZN5ImGui25GetWindowContentRegionMinEv;
    extern fn _ZN5ImGui25GetWindowContentRegionMinEv() ImVec2;
    pub const GetWindowContentRegionMax = _ZN5ImGui25GetWindowContentRegionMaxEv;
    extern fn _ZN5ImGui25GetWindowContentRegionMaxEv() ImVec2;
    pub const GetScrollX = _ZN5ImGui10GetScrollXEv;
    extern fn _ZN5ImGui10GetScrollXEv() f32;
    pub const GetScrollY = _ZN5ImGui10GetScrollYEv;
    extern fn _ZN5ImGui10GetScrollYEv() f32;
    pub const SetScrollX = _ZN5ImGui10SetScrollXEf;
    extern fn _ZN5ImGui10SetScrollXEf(scroll_x: f32) void;
    pub const SetScrollY = _ZN5ImGui10SetScrollYEf;
    extern fn _ZN5ImGui10SetScrollYEf(scroll_y: f32) void;
    pub const GetScrollMaxX = _ZN5ImGui13GetScrollMaxXEv;
    extern fn _ZN5ImGui13GetScrollMaxXEv() f32;
    pub const GetScrollMaxY = _ZN5ImGui13GetScrollMaxYEv;
    extern fn _ZN5ImGui13GetScrollMaxYEv() f32;
    pub const SetScrollHereX = _ZN5ImGui14SetScrollHereXEf;
    extern fn _ZN5ImGui14SetScrollHereXEf(center_x_ratio: f32) void;
    pub const SetScrollHereY = _ZN5ImGui14SetScrollHereYEf;
    extern fn _ZN5ImGui14SetScrollHereYEf(center_y_ratio: f32) void;
    pub const SetScrollFromPosX = _ZN5ImGui17SetScrollFromPosXEff;
    extern fn _ZN5ImGui17SetScrollFromPosXEff(local_x: f32, center_x_ratio: f32) void;
    pub const SetScrollFromPosY = _ZN5ImGui17SetScrollFromPosYEff;
    extern fn _ZN5ImGui17SetScrollFromPosYEff(local_y: f32, center_y_ratio: f32) void;
    pub const PushFont = _ZN5ImGui8PushFontEP6ImFont;
    extern fn _ZN5ImGui8PushFontEP6ImFont(font: *ImFont) void;
    pub const PopFont = _ZN5ImGui7PopFontEv;
    extern fn _ZN5ImGui7PopFontEv() void;
    pub const PushStyleColor32 = _ZN5ImGui14PushStyleColorEij;
    extern fn _ZN5ImGui14PushStyleColorEij(idx: ImGuiCol, col: ImU32) void;
    pub const PushStyleColor = _ZN5ImGui14PushStyleColorEiRK6ImVec4;
    extern fn _ZN5ImGui14PushStyleColorEiRK6ImVec4(idx: ImGuiCol, col: *const ImVec4) void;
    pub const PopStyleColor = _ZN5ImGui13PopStyleColorEi;
    extern fn _ZN5ImGui13PopStyleColorEi(count: c_int) void;
    pub const PushStyleVarFloat = _ZN5ImGui12PushStyleVarEif;
    extern fn _ZN5ImGui12PushStyleVarEif(idx: ImGuiStyleVar, val: f32) void;
    pub const PushStyleVarVec2 = _ZN5ImGui12PushStyleVarEiRK6ImVec2;
    extern fn _ZN5ImGui12PushStyleVarEiRK6ImVec2(idx: ImGuiStyleVar, val: *const ImVec2) void;
    pub const PopStyleVar = _ZN5ImGui11PopStyleVarEi;
    extern fn _ZN5ImGui11PopStyleVarEi(count: c_int) void;
    pub const PushTabStop = _ZN5ImGui11PushTabStopEb;
    extern fn _ZN5ImGui11PushTabStopEb(tab_stop: bool) void;
    pub const PopTabStop = _ZN5ImGui10PopTabStopEv;
    extern fn _ZN5ImGui10PopTabStopEv() void;
    pub const PushButtonRepeat = _ZN5ImGui16PushButtonRepeatEb;
    extern fn _ZN5ImGui16PushButtonRepeatEb(repeat: bool) void;
    pub const PopButtonRepeat = _ZN5ImGui15PopButtonRepeatEv;
    extern fn _ZN5ImGui15PopButtonRepeatEv() void;
    pub const PushItemWidth = _ZN5ImGui13PushItemWidthEf;
    extern fn _ZN5ImGui13PushItemWidthEf(item_width: f32) void;
    pub const PopItemWidth = _ZN5ImGui12PopItemWidthEv;
    extern fn _ZN5ImGui12PopItemWidthEv() void;
    pub const SetNextItemWidth = _ZN5ImGui16SetNextItemWidthEf;
    extern fn _ZN5ImGui16SetNextItemWidthEf(item_width: f32) void;
    pub const CalcItemWidth = _ZN5ImGui13CalcItemWidthEv;
    extern fn _ZN5ImGui13CalcItemWidthEv() f32;
    pub const PushTextWrapPos = _ZN5ImGui15PushTextWrapPosEf;
    extern fn _ZN5ImGui15PushTextWrapPosEf(wrap_local_pos_x: f32) void;
    pub const PopTextWrapPos = _ZN5ImGui14PopTextWrapPosEv;
    extern fn _ZN5ImGui14PopTextWrapPosEv() void;
    pub const GetFont = _ZN5ImGui7GetFontEv;
    extern fn _ZN5ImGui7GetFontEv() *ImFont;
    pub const GetFontSize = _ZN5ImGui11GetFontSizeEv;
    extern fn _ZN5ImGui11GetFontSizeEv() f32;
    pub const GetFontTexUvWhitePixel = _ZN5ImGui22GetFontTexUvWhitePixelEv;
    extern fn _ZN5ImGui22GetFontTexUvWhitePixelEv() ImVec2;
    pub const GetColorU32FromStyle = _ZN5ImGui11GetColorU32Eif;
    extern fn _ZN5ImGui11GetColorU32Eif(idx: ImGuiCol, alpha_mul: f32) ImU32;
    pub const GetColorU32FromVec4 = _ZN5ImGui11GetColorU32ERK6ImVec4;
    extern fn _ZN5ImGui11GetColorU32ERK6ImVec4(col: *const ImVec4) ImU32;
    pub const GetColorU32 = _ZN5ImGui11GetColorU32Ej;
    extern fn _ZN5ImGui11GetColorU32Ej(col: ImU32) ImU32;
    pub const GetStyleColorVec4 = _ZN5ImGui17GetStyleColorVec4Ei;
    extern fn _ZN5ImGui17GetStyleColorVec4Ei(idx: ImGuiCol) *const ImVec4;
    pub const Separator = _ZN5ImGui9SeparatorEv;
    extern fn _ZN5ImGui9SeparatorEv() void;
    pub const SameLine = _ZN5ImGui8SameLineEff;
    extern fn _ZN5ImGui8SameLineEff(offset_from_start_x: f32, spacing: f32) void;
    pub const NewLine = _ZN5ImGui7NewLineEv;
    extern fn _ZN5ImGui7NewLineEv() void;
    pub const Spacing = _ZN5ImGui7SpacingEv;
    extern fn _ZN5ImGui7SpacingEv() void;
    pub const Dummy = _ZN5ImGui5DummyERK6ImVec2;
    extern fn _ZN5ImGui5DummyERK6ImVec2(size: *const ImVec2) void;
    pub const Indent = _ZN5ImGui6IndentEf;
    extern fn _ZN5ImGui6IndentEf(indent_w: f32) void;
    pub const Unindent = _ZN5ImGui8UnindentEf;
    extern fn _ZN5ImGui8UnindentEf(indent_w: f32) void;
    pub const BeginGroup = _ZN5ImGui10BeginGroupEv;
    extern fn _ZN5ImGui10BeginGroupEv() void;
    pub const EndGroup = _ZN5ImGui8EndGroupEv;
    extern fn _ZN5ImGui8EndGroupEv() void;
    pub const GetCursorPos = _ZN5ImGui12GetCursorPosEv;
    extern fn _ZN5ImGui12GetCursorPosEv() ImVec2;
    pub const GetCursorPosX = _ZN5ImGui13GetCursorPosXEv;
    extern fn _ZN5ImGui13GetCursorPosXEv() f32;
    pub const GetCursorPosY = _ZN5ImGui13GetCursorPosYEv;
    extern fn _ZN5ImGui13GetCursorPosYEv() f32;
    pub const SetCursorPos = _ZN5ImGui12SetCursorPosERK6ImVec2;
    extern fn _ZN5ImGui12SetCursorPosERK6ImVec2(local_pos: *const ImVec2) void;
    pub const SetCursorPosX = _ZN5ImGui13SetCursorPosXEf;
    extern fn _ZN5ImGui13SetCursorPosXEf(local_x: f32) void;
    pub const SetCursorPosY = _ZN5ImGui13SetCursorPosYEf;
    extern fn _ZN5ImGui13SetCursorPosYEf(local_y: f32) void;
    pub const GetCursorStartPos = _ZN5ImGui17GetCursorStartPosEv;
    extern fn _ZN5ImGui17GetCursorStartPosEv() ImVec2;
    pub const GetCursorScreenPos = _ZN5ImGui18GetCursorScreenPosEv;
    extern fn _ZN5ImGui18GetCursorScreenPosEv() ImVec2;
    pub const SetCursorScreenPos = _ZN5ImGui18SetCursorScreenPosERK6ImVec2;
    extern fn _ZN5ImGui18SetCursorScreenPosERK6ImVec2(pos: *const ImVec2) void;
    pub const AlignTextToFramePadding = _ZN5ImGui23AlignTextToFramePaddingEv;
    extern fn _ZN5ImGui23AlignTextToFramePaddingEv() void;
    pub const GetTextLineHeight = _ZN5ImGui17GetTextLineHeightEv;
    extern fn _ZN5ImGui17GetTextLineHeightEv() f32;
    pub const GetTextLineHeightWithSpacing = _ZN5ImGui28GetTextLineHeightWithSpacingEv;
    extern fn _ZN5ImGui28GetTextLineHeightWithSpacingEv() f32;
    pub const GetFrameHeight = _ZN5ImGui14GetFrameHeightEv;
    extern fn _ZN5ImGui14GetFrameHeightEv() f32;
    pub const GetFrameHeightWithSpacing = _ZN5ImGui25GetFrameHeightWithSpacingEv;
    extern fn _ZN5ImGui25GetFrameHeightWithSpacingEv() f32;
    pub const PushID = _ZN5ImGui6PushIDEPKc;
    extern fn _ZN5ImGui6PushIDEPKc(str_id: *const u8) void;
    // pub const PushID = _ZN5ImGui6PushIDEPKcS1_;
    // extern fn _ZN5ImGui6PushIDEPKcS1_(str_id_begin: *const u8, str_id_end: *const u8) void;
    pub const PushIDFromData = _ZN5ImGui6PushIDEPKv;
    extern fn _ZN5ImGui6PushIDEPKv(ptr_id: *const void) void;
    pub const PushIDFromInt = _ZN5ImGui6PushIDEi;
    extern fn _ZN5ImGui6PushIDEi(int_id: c_int) void;
    pub const PopID = _ZN5ImGui5PopIDEv;
    extern fn _ZN5ImGui5PopIDEv() void;
    pub const GetID = _ZN5ImGui5GetIDEPKc;
    extern fn _ZN5ImGui5GetIDEPKc(str_id: *const u8) ImGuiID;
    // pub const GetID = _ZN5ImGui5GetIDEPKcS1_;
    // extern fn _ZN5ImGui5GetIDEPKcS1_(str_id_begin: *const u8, str_id_end: *const u8) ImGuiID;
    pub const GetIDFromData = _ZN5ImGui5GetIDEPKv;
    extern fn _ZN5ImGui5GetIDEPKv(ptr_id: *const void) ImGuiID;
    pub const TextUnformatted = _ZN5ImGui15TextUnformattedEPKcS1_;
    extern fn _ZN5ImGui15TextUnformattedEPKcS1_(text: *const u8, text_end: *const u8) void;
    pub const Text = _ZN5ImGui4TextEPKcz;
    extern fn _ZN5ImGui4TextEPKcz(fmt: *const u8, ...) callconv(.C) void;
    pub const TextV = _ZN5ImGui5TextVEPKcPc;
    extern fn _ZN5ImGui5TextVEPKcPc(fmt: *const u8, args: *u8) void;
    pub const TextColored = _ZN5ImGui11TextColoredERK6ImVec4PKcz;
    extern fn _ZN5ImGui11TextColoredERK6ImVec4PKcz(col: *const ImVec4, fmt: *const u8, ...) callconv(.C) void;
    pub const TextColoredV = _ZN5ImGui12TextColoredVERK6ImVec4PKcPc;
    extern fn _ZN5ImGui12TextColoredVERK6ImVec4PKcPc(col: *const ImVec4, fmt: *const u8, args: *u8) void;
    pub const TextDisabled = _ZN5ImGui12TextDisabledEPKcz;
    extern fn _ZN5ImGui12TextDisabledEPKcz(fmt: *const u8, ...) callconv(.C) void;
    pub const TextDisabledV = _ZN5ImGui13TextDisabledVEPKcPc;
    extern fn _ZN5ImGui13TextDisabledVEPKcPc(fmt: *const u8, args: *u8) void;
    pub const TextWrapped = _ZN5ImGui11TextWrappedEPKcz;
    extern fn _ZN5ImGui11TextWrappedEPKcz(fmt: *const u8, ...) callconv(.C) void;
    pub const TextWrappedV = _ZN5ImGui12TextWrappedVEPKcPc;
    extern fn _ZN5ImGui12TextWrappedVEPKcPc(fmt: *const u8, args: *u8) void;
    pub const LabelText = _ZN5ImGui9LabelTextEPKcS1_z;
    extern fn _ZN5ImGui9LabelTextEPKcS1_z(label: *const u8, fmt: *const u8, ...) callconv(.C) void;
    pub const LabelTextV = _ZN5ImGui10LabelTextVEPKcS1_Pc;
    extern fn _ZN5ImGui10LabelTextVEPKcS1_Pc(label: *const u8, fmt: *const u8, args: *u8) void;
    pub const BulletText = _ZN5ImGui10BulletTextEPKcz;
    extern fn _ZN5ImGui10BulletTextEPKcz(fmt: *const u8, ...) callconv(.C) void;
    pub const BulletTextV = _ZN5ImGui11BulletTextVEPKcPc;
    extern fn _ZN5ImGui11BulletTextVEPKcPc(fmt: *const u8, args: *u8) void;
    pub const SeparatorText = _ZN5ImGui13SeparatorTextEPKc;
    extern fn _ZN5ImGui13SeparatorTextEPKc(label: *const u8) void;
    pub const Button = _ZN5ImGui6ButtonEPKcRK6ImVec2;
    extern fn _ZN5ImGui6ButtonEPKcRK6ImVec2(label: *const u8, size: *const ImVec2) bool;
    pub const SmallButton = _ZN5ImGui11SmallButtonEPKc;
    extern fn _ZN5ImGui11SmallButtonEPKc(label: *const u8) bool;
    pub const InvisibleButton = _ZN5ImGui15InvisibleButtonEPKcRK6ImVec2i;
    extern fn _ZN5ImGui15InvisibleButtonEPKcRK6ImVec2i(str_id: *const u8, size: *const ImVec2, flags: ImGuiButtonFlags) bool;
    pub const ArrowButton = _ZN5ImGui11ArrowButtonEPKci;
    extern fn _ZN5ImGui11ArrowButtonEPKci(str_id: *const u8, dir: ImGuiDir) bool;
    pub const Checkbox = _ZN5ImGui8CheckboxEPKcPb;
    extern fn _ZN5ImGui8CheckboxEPKcPb(label: *const u8, v: *bool) bool;
    pub const CheckboxFlags = _ZN5ImGui13CheckboxFlagsEPKcPii;
    extern fn _ZN5ImGui13CheckboxFlagsEPKcPii(label: *const u8, flags: *c_int, flags_value: c_int) bool;
    pub const CheckboxFlagsUInt = _ZN5ImGui13CheckboxFlagsEPKcPjj;
    extern fn _ZN5ImGui13CheckboxFlagsEPKcPjj(label: *const u8, flags: *c_uint, flags_value: c_uint) bool;
    pub const RadioButton = _ZN5ImGui11RadioButtonEPKcb;
    extern fn _ZN5ImGui11RadioButtonEPKcb(label: *const u8, active: bool) bool;
    pub const RadioButtonPtr = _ZN5ImGui11RadioButtonEPKcPii;
    extern fn _ZN5ImGui11RadioButtonEPKcPii(label: *const u8, v: *c_int, v_button: c_int) bool;
    pub const ProgressBar = _ZN5ImGui11ProgressBarEfRK6ImVec2PKc;
    extern fn _ZN5ImGui11ProgressBarEfRK6ImVec2PKc(fraction: f32, size_arg: *const ImVec2, overlay: *const u8) void;
    pub const Bullet = _ZN5ImGui6BulletEv;
    extern fn _ZN5ImGui6BulletEv() void;
    pub const Image = _ZN5ImGui5ImageEPvRK6ImVec2S3_S3_RK6ImVec4S6_;
    extern fn _ZN5ImGui5ImageEPvRK6ImVec2S3_S3_RK6ImVec4S6_(user_texture_id: ImTextureID, size: *const ImVec2, uv0: *const ImVec2, uv1: *const ImVec2, tint_col: *const ImVec4, border_col: *const ImVec4) void;
    pub const ImageButton = _ZN5ImGui11ImageButtonEPKcPvRK6ImVec2S5_S5_RK6ImVec4S8_;
    extern fn _ZN5ImGui11ImageButtonEPKcPvRK6ImVec2S5_S5_RK6ImVec4S8_(str_id: *const u8, user_texture_id: ImTextureID, size: *const ImVec2, uv0: *const ImVec2, uv1: *const ImVec2, bg_col: *const ImVec4, tint_col: *const ImVec4) bool;
    pub const BeginCombo = _ZN5ImGui10BeginComboEPKcS1_i;
    extern fn _ZN5ImGui10BeginComboEPKcS1_i(label: *const u8, preview_value: *const u8, flags: ImGuiComboFlags) bool;
    pub const EndCombo = _ZN5ImGui8EndComboEv;
    extern fn _ZN5ImGui8EndComboEv() void;
    pub const Combo = _ZN5ImGui5ComboEPKcPiPKS1_ii;
    extern fn _ZN5ImGui5ComboEPKcPiPKS1_ii(label: *const u8, current_item: *c_int, items: *const *const u8, items_count: c_int, popup_max_height_in_items: c_int) bool;
    pub const ComboFromStrArray = _ZN5ImGui5ComboEPKcPiS1_i;
    extern fn _ZN5ImGui5ComboEPKcPiS1_i(label: *const u8, current_item: *c_int, items_separated_by_zeros: *const u8, popup_max_height_in_items: c_int) bool;
    pub const ComboFromGetter = _ZN5ImGui5ComboEPKcPiPFbPviPS1_ES3_ii;
    extern fn _ZN5ImGui5ComboEPKcPiPFbPviPS1_ES3_ii(label: *const u8, current_item: *c_int, items_getter: *const fn (*void, c_int) bool, data: *void, items_count: c_int, popup_max_height_in_items: c_int) bool;
    pub const DragFloat = _ZN5ImGui9DragFloatEPKcPffffS1_i;
    extern fn _ZN5ImGui9DragFloatEPKcPffffS1_i(label: *const u8, v: *f32, v_speed: f32, v_min: f32, v_max: f32, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragFloat2 = _ZN5ImGui10DragFloat2EPKcPffffS1_i;
    extern fn _ZN5ImGui10DragFloat2EPKcPffffS1_i(label: *const u8, v: *f32, v_speed: f32, v_min: f32, v_max: f32, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragFloat3 = _ZN5ImGui10DragFloat3EPKcPffffS1_i;
    extern fn _ZN5ImGui10DragFloat3EPKcPffffS1_i(label: *const u8, v: *f32, v_speed: f32, v_min: f32, v_max: f32, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragFloat4 = _ZN5ImGui10DragFloat4EPKcPffffS1_i;
    extern fn _ZN5ImGui10DragFloat4EPKcPffffS1_i(label: *const u8, v: *f32, v_speed: f32, v_min: f32, v_max: f32, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragFloatRange2 = _ZN5ImGui15DragFloatRange2EPKcPfS2_fffS1_S1_i;
    extern fn _ZN5ImGui15DragFloatRange2EPKcPfS2_fffS1_S1_i(label: *const u8, v_current_min: *f32, v_current_max: *f32, v_speed: f32, v_min: f32, v_max: f32, format: *const u8, format_max: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragInt = _ZN5ImGui7DragIntEPKcPifiiS1_i;
    extern fn _ZN5ImGui7DragIntEPKcPifiiS1_i(label: *const u8, v: *c_int, v_speed: f32, v_min: c_int, v_max: c_int, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragInt2 = _ZN5ImGui8DragInt2EPKcPifiiS1_i;
    extern fn _ZN5ImGui8DragInt2EPKcPifiiS1_i(label: *const u8, v: *c_int, v_speed: f32, v_min: c_int, v_max: c_int, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragInt3 = _ZN5ImGui8DragInt3EPKcPifiiS1_i;
    extern fn _ZN5ImGui8DragInt3EPKcPifiiS1_i(label: *const u8, v: *c_int, v_speed: f32, v_min: c_int, v_max: c_int, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragInt4 = _ZN5ImGui8DragInt4EPKcPifiiS1_i;
    extern fn _ZN5ImGui8DragInt4EPKcPifiiS1_i(label: *const u8, v: *c_int, v_speed: f32, v_min: c_int, v_max: c_int, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragIntRange2 = _ZN5ImGui13DragIntRange2EPKcPiS2_fiiS1_S1_i;
    extern fn _ZN5ImGui13DragIntRange2EPKcPiS2_fiiS1_S1_i(label: *const u8, v_current_min: *c_int, v_current_max: *c_int, v_speed: f32, v_min: c_int, v_max: c_int, format: *const u8, format_max: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragScalar = _ZN5ImGui10DragScalarEPKciPvfPKvS4_S1_i;
    extern fn _ZN5ImGui10DragScalarEPKciPvfPKvS4_S1_i(label: *const u8, data_type: ImGuiDataType, p_data: *void, v_speed: f32, p_min: *const void, p_max: *const void, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const DragScalarN = _ZN5ImGui11DragScalarNEPKciPvifPKvS4_S1_i;
    extern fn _ZN5ImGui11DragScalarNEPKciPvifPKvS4_S1_i(label: *const u8, data_type: ImGuiDataType, p_data: *void, components: c_int, v_speed: f32, p_min: *const void, p_max: *const void, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderFloat = _ZN5ImGui11SliderFloatEPKcPfffS1_i;
    extern fn _ZN5ImGui11SliderFloatEPKcPfffS1_i(label: *const u8, v: *f32, v_min: f32, v_max: f32, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderFloat2 = _ZN5ImGui12SliderFloat2EPKcPfffS1_i;
    extern fn _ZN5ImGui12SliderFloat2EPKcPfffS1_i(label: *const u8, v: *f32, v_min: f32, v_max: f32, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderFloat3 = _ZN5ImGui12SliderFloat3EPKcPfffS1_i;
    extern fn _ZN5ImGui12SliderFloat3EPKcPfffS1_i(label: *const u8, v: *f32, v_min: f32, v_max: f32, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderFloat4 = _ZN5ImGui12SliderFloat4EPKcPfffS1_i;
    extern fn _ZN5ImGui12SliderFloat4EPKcPfffS1_i(label: *const u8, v: *f32, v_min: f32, v_max: f32, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderAngle = _ZN5ImGui11SliderAngleEPKcPfffS1_i;
    extern fn _ZN5ImGui11SliderAngleEPKcPfffS1_i(label: *const u8, v_rad: *f32, v_degrees_min: f32, v_degrees_max: f32, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderInt = _ZN5ImGui9SliderIntEPKcPiiiS1_i;
    extern fn _ZN5ImGui9SliderIntEPKcPiiiS1_i(label: *const u8, v: *c_int, v_min: c_int, v_max: c_int, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderInt2 = _ZN5ImGui10SliderInt2EPKcPiiiS1_i;
    extern fn _ZN5ImGui10SliderInt2EPKcPiiiS1_i(label: *const u8, v: *c_int, v_min: c_int, v_max: c_int, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderInt3 = _ZN5ImGui10SliderInt3EPKcPiiiS1_i;
    extern fn _ZN5ImGui10SliderInt3EPKcPiiiS1_i(label: *const u8, v: *c_int, v_min: c_int, v_max: c_int, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderInt4 = _ZN5ImGui10SliderInt4EPKcPiiiS1_i;
    extern fn _ZN5ImGui10SliderInt4EPKcPiiiS1_i(label: *const u8, v: *c_int, v_min: c_int, v_max: c_int, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderScalar = _ZN5ImGui12SliderScalarEPKciPvPKvS4_S1_i;
    extern fn _ZN5ImGui12SliderScalarEPKciPvPKvS4_S1_i(label: *const u8, data_type: ImGuiDataType, p_data: *void, p_min: *const void, p_max: *const void, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const SliderScalarN = _ZN5ImGui13SliderScalarNEPKciPviPKvS4_S1_i;
    extern fn _ZN5ImGui13SliderScalarNEPKciPviPKvS4_S1_i(label: *const u8, data_type: ImGuiDataType, p_data: *void, components: c_int, p_min: *const void, p_max: *const void, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const VSliderFloat = _ZN5ImGui12VSliderFloatEPKcRK6ImVec2PfffS1_i;
    extern fn _ZN5ImGui12VSliderFloatEPKcRK6ImVec2PfffS1_i(label: *const u8, size: *const ImVec2, v: *f32, v_min: f32, v_max: f32, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const VSliderInt = _ZN5ImGui10VSliderIntEPKcRK6ImVec2PiiiS1_i;
    extern fn _ZN5ImGui10VSliderIntEPKcRK6ImVec2PiiiS1_i(label: *const u8, size: *const ImVec2, v: *c_int, v_min: c_int, v_max: c_int, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const VSliderScalar = _ZN5ImGui13VSliderScalarEPKcRK6ImVec2iPvPKvS7_S1_i;
    extern fn _ZN5ImGui13VSliderScalarEPKcRK6ImVec2iPvPKvS7_S1_i(label: *const u8, size: *const ImVec2, data_type: ImGuiDataType, p_data: *void, p_min: *const void, p_max: *const void, format: *const u8, flags: ImGuiSliderFlags) bool;
    pub const InputText = _ZN5ImGui9InputTextEPKcPcyiPFiP26ImGuiInputTextCallbackDataEPv;
    extern fn _ZN5ImGui9InputTextEPKcPcyiPFiP26ImGuiInputTextCallbackDataEPv(label: *const u8, buf: *u8, buf_size: usize, flags: ImGuiInputTextFlags, callback: ImGuiInputTextCallback, user_data: *void) bool;
    pub const InputTextMultiline = _ZN5ImGui18InputTextMultilineEPKcPcyRK6ImVec2iPFiP26ImGuiInputTextCallbackDataEPv;
    extern fn _ZN5ImGui18InputTextMultilineEPKcPcyRK6ImVec2iPFiP26ImGuiInputTextCallbackDataEPv(label: *const u8, buf: *u8, buf_size: usize, size: *const ImVec2, flags: ImGuiInputTextFlags, callback: ImGuiInputTextCallback, user_data: *void) bool;
    pub const InputTextWithHint = _ZN5ImGui17InputTextWithHintEPKcS1_PcyiPFiP26ImGuiInputTextCallbackDataEPv;
    extern fn _ZN5ImGui17InputTextWithHintEPKcS1_PcyiPFiP26ImGuiInputTextCallbackDataEPv(label: *const u8, hint: *const u8, buf: *u8, buf_size: usize, flags: ImGuiInputTextFlags, callback: ImGuiInputTextCallback, user_data: *void) bool;
    pub const InputFloat = _ZN5ImGui10InputFloatEPKcPfffS1_i;
    extern fn _ZN5ImGui10InputFloatEPKcPfffS1_i(label: *const u8, v: *f32, step: f32, step_fast: f32, format: *const u8, flags: ImGuiInputTextFlags) bool;
    pub const InputFloat2 = _ZN5ImGui11InputFloat2EPKcPfS1_i;
    extern fn _ZN5ImGui11InputFloat2EPKcPfS1_i(label: *const u8, v: *f32, format: *const u8, flags: ImGuiInputTextFlags) bool;
    pub const InputFloat3 = _ZN5ImGui11InputFloat3EPKcPfS1_i;
    extern fn _ZN5ImGui11InputFloat3EPKcPfS1_i(label: *const u8, v: *f32, format: *const u8, flags: ImGuiInputTextFlags) bool;
    pub const InputFloat4 = _ZN5ImGui11InputFloat4EPKcPfS1_i;
    extern fn _ZN5ImGui11InputFloat4EPKcPfS1_i(label: *const u8, v: *f32, format: *const u8, flags: ImGuiInputTextFlags) bool;
    pub const InputInt = _ZN5ImGui8InputIntEPKcPiiii;
    extern fn _ZN5ImGui8InputIntEPKcPiiii(label: *const u8, v: *c_int, step: c_int, step_fast: c_int, flags: ImGuiInputTextFlags) bool;
    pub const InputInt2 = _ZN5ImGui9InputInt2EPKcPii;
    extern fn _ZN5ImGui9InputInt2EPKcPii(label: *const u8, v: *c_int, flags: ImGuiInputTextFlags) bool;
    pub const InputInt3 = _ZN5ImGui9InputInt3EPKcPii;
    extern fn _ZN5ImGui9InputInt3EPKcPii(label: *const u8, v: *c_int, flags: ImGuiInputTextFlags) bool;
    pub const InputInt4 = _ZN5ImGui9InputInt4EPKcPii;
    extern fn _ZN5ImGui9InputInt4EPKcPii(label: *const u8, v: *c_int, flags: ImGuiInputTextFlags) bool;
    pub const InputDouble = _ZN5ImGui11InputDoubleEPKcPdddS1_i;
    extern fn _ZN5ImGui11InputDoubleEPKcPdddS1_i(label: *const u8, v: *f64, step: f64, step_fast: f64, format: *const u8, flags: ImGuiInputTextFlags) bool;
    pub const InputScalar = _ZN5ImGui11InputScalarEPKciPvPKvS4_S1_i;
    extern fn _ZN5ImGui11InputScalarEPKciPvPKvS4_S1_i(label: *const u8, data_type: ImGuiDataType, p_data: *void, p_step: *const void, p_step_fast: *const void, format: *const u8, flags: ImGuiInputTextFlags) bool;
    pub const InputScalarN = _ZN5ImGui12InputScalarNEPKciPviPKvS4_S1_i;
    extern fn _ZN5ImGui12InputScalarNEPKciPviPKvS4_S1_i(label: *const u8, data_type: ImGuiDataType, p_data: *void, components: c_int, p_step: *const void, p_step_fast: *const void, format: *const u8, flags: ImGuiInputTextFlags) bool;
    pub const ColorEdit3 = _ZN5ImGui10ColorEdit3EPKcPfi;
    extern fn _ZN5ImGui10ColorEdit3EPKcPfi(label: *const u8, col: *f32, flags: ImGuiColorEditFlags) bool;
    pub const ColorEdit4 = _ZN5ImGui10ColorEdit4EPKcPfi;
    extern fn _ZN5ImGui10ColorEdit4EPKcPfi(label: *const u8, col: *f32, flags: ImGuiColorEditFlags) bool;
    pub const ColorPicker3 = _ZN5ImGui12ColorPicker3EPKcPfi;
    extern fn _ZN5ImGui12ColorPicker3EPKcPfi(label: *const u8, col: *f32, flags: ImGuiColorEditFlags) bool;
    pub const ColorPicker4 = _ZN5ImGui12ColorPicker4EPKcPfiPKf;
    extern fn _ZN5ImGui12ColorPicker4EPKcPfiPKf(label: *const u8, col: *f32, flags: ImGuiColorEditFlags, ref_col: *const f32) bool;
    pub const ColorButton = _ZN5ImGui11ColorButtonEPKcRK6ImVec4iRK6ImVec2;
    extern fn _ZN5ImGui11ColorButtonEPKcRK6ImVec4iRK6ImVec2(desc_id: *const u8, col: *const ImVec4, flags: ImGuiColorEditFlags, size: *const ImVec2) bool;
    pub const SetColorEditOptions = _ZN5ImGui19SetColorEditOptionsEi;
    extern fn _ZN5ImGui19SetColorEditOptionsEi(flags: ImGuiColorEditFlags) void;
    pub const TreeNode = _ZN5ImGui8TreeNodeEPKc;
    extern fn _ZN5ImGui8TreeNodeEPKc(label: *const u8) bool;
    pub const TreeNodeFmt = _ZN5ImGui8TreeNodeEPKcS1_z;
    extern fn _ZN5ImGui8TreeNodeEPKcS1_z(str_id: *const u8, fmt: *const u8, ...) callconv(.C) bool;
    pub const TreeNodeFmtId = _ZN5ImGui8TreeNodeEPKvPKcz;
    extern fn _ZN5ImGui8TreeNodeEPKvPKcz(ptr_id: *const void, fmt: *const u8, ...) callconv(.C) bool;
    // pub const TreeNodeV = _ZN5ImGui9TreeNodeVEPKcS1_Pc;
    // extern fn _ZN5ImGui9TreeNodeVEPKcS1_Pc(str_id: *const u8, fmt: *const u8, args: *u8) bool;
    // pub const TreeNodeV = _ZN5ImGui9TreeNodeVEPKvPKcPc;
    // extern fn _ZN5ImGui9TreeNodeVEPKvPKcPc(ptr_id: *const void, fmt: *const u8, args: *u8) bool;
    pub const TreeNodeEx = _ZN5ImGui10TreeNodeExEPKci;
    extern fn _ZN5ImGui10TreeNodeExEPKci(label: *const u8, flags: ImGuiTreeNodeFlags) bool;
    pub const TreeNodeExFmt = _ZN5ImGui10TreeNodeExEPKciS1_z;
    extern fn _ZN5ImGui10TreeNodeExEPKciS1_z(str_id: *const u8, flags: ImGuiTreeNodeFlags, fmt: *const u8, ...) callconv(.C) bool;
    pub const TreeNodeExFmtId = _ZN5ImGui10TreeNodeExEPKviPKcz;
    extern fn _ZN5ImGui10TreeNodeExEPKviPKcz(ptr_id: *const void, flags: ImGuiTreeNodeFlags, fmt: *const u8, ...) callconv(.C) bool;
    // pub const TreeNodeExV = _ZN5ImGui11TreeNodeExVEPKciS1_Pc;
    // extern fn _ZN5ImGui11TreeNodeExVEPKciS1_Pc(str_id: *const u8, flags: ImGuiTreeNodeFlags, fmt: *const u8, args: *u8) bool;
    // pub const TreeNodeExV = _ZN5ImGui11TreeNodeExVEPKviPKcPc;
    // extern fn _ZN5ImGui11TreeNodeExVEPKviPKcPc(ptr_id: *const void, flags: ImGuiTreeNodeFlags, fmt: *const u8, args: *u8) bool;
    pub const TreePush = _ZN5ImGui8TreePushEPKc;
    extern fn _ZN5ImGui8TreePushEPKc(str_id: *const u8) void;
    pub const TreePushId = _ZN5ImGui8TreePushEPKv;
    extern fn _ZN5ImGui8TreePushEPKv(ptr_id: *const void) void;
    pub const TreePop = _ZN5ImGui7TreePopEv;
    extern fn _ZN5ImGui7TreePopEv() void;
    pub const GetTreeNodeToLabelSpacing = _ZN5ImGui25GetTreeNodeToLabelSpacingEv;
    extern fn _ZN5ImGui25GetTreeNodeToLabelSpacingEv() f32;
    pub const CollapsingHeader = _ZN5ImGui16CollapsingHeaderEPKci;
    extern fn _ZN5ImGui16CollapsingHeaderEPKci(label: *const u8, flags: ImGuiTreeNodeFlags) bool;
    pub const CollapsingHeaderPtr = _ZN5ImGui16CollapsingHeaderEPKcPbi;
    extern fn _ZN5ImGui16CollapsingHeaderEPKcPbi(label: *const u8, p_visible: *bool, flags: ImGuiTreeNodeFlags) bool;
    pub const SetNextItemOpen = _ZN5ImGui15SetNextItemOpenEbi;
    extern fn _ZN5ImGui15SetNextItemOpenEbi(is_open: bool, cond: ImGuiCond) void;
    pub const Selectable = _ZN5ImGui10SelectableEPKcbiRK6ImVec2;
    extern fn _ZN5ImGui10SelectableEPKcbiRK6ImVec2(label: *const u8, selected: bool, flags: ImGuiSelectableFlags, size: *const ImVec2) bool;
    pub const SelectablePtr = _ZN5ImGui10SelectableEPKcPbiRK6ImVec2;
    extern fn _ZN5ImGui10SelectableEPKcPbiRK6ImVec2(label: *const u8, p_selected: *bool, flags: ImGuiSelectableFlags, size: *const ImVec2) bool;
    pub const BeginListBox = _ZN5ImGui12BeginListBoxEPKcRK6ImVec2;
    extern fn _ZN5ImGui12BeginListBoxEPKcRK6ImVec2(label: *const u8, size: *const ImVec2) bool;
    pub const EndListBox = _ZN5ImGui10EndListBoxEv;
    extern fn _ZN5ImGui10EndListBoxEv() void;
    pub const ListBox = _ZN5ImGui7ListBoxEPKcPiPKS1_ii;
    extern fn _ZN5ImGui7ListBoxEPKcPiPKS1_ii(label: *const u8, current_item: *c_int, items: *const *const u8, items_count: c_int, height_in_items: c_int) bool;
    pub const ListBoxFromGetter = _ZN5ImGui7ListBoxEPKcPiPFbPviPS1_ES3_ii;
    extern fn _ZN5ImGui7ListBoxEPKcPiPFbPviPS1_ES3_ii(label: *const u8, current_item: *c_int, items_getter: *const fn (*void, c_int) bool, data: *void, items_count: c_int, height_in_items: c_int) bool;
    pub const PlotLines = _ZN5ImGui9PlotLinesEPKcPKfiiS1_ff6ImVec2i;
    extern fn _ZN5ImGui9PlotLinesEPKcPKfiiS1_ff6ImVec2i(label: *const u8, values: *const f32, values_count: c_int, values_offset: c_int, overlay_text: *const u8, scale_min: f32, scale_max: f32, graph_size: ImVec2, stride: c_int) void;
    pub const PlotLinesFromGetter = _ZN5ImGui9PlotLinesEPKcPFfPviES2_iiS1_ff6ImVec2;
    extern fn _ZN5ImGui9PlotLinesEPKcPFfPviES2_iiS1_ff6ImVec2(label: *const u8, values_getter: *const fn (*void) f32, data: *void, values_count: c_int, values_offset: c_int, overlay_text: *const u8, scale_min: f32, scale_max: f32, graph_size: ImVec2) void;
    pub const PlotHistogram = _ZN5ImGui13PlotHistogramEPKcPKfiiS1_ff6ImVec2i;
    extern fn _ZN5ImGui13PlotHistogramEPKcPKfiiS1_ff6ImVec2i(label: *const u8, values: *const f32, values_count: c_int, values_offset: c_int, overlay_text: *const u8, scale_min: f32, scale_max: f32, graph_size: ImVec2, stride: c_int) void;
    pub const PlotHistogramFromGetter = _ZN5ImGui13PlotHistogramEPKcPFfPviES2_iiS1_ff6ImVec2;
    extern fn _ZN5ImGui13PlotHistogramEPKcPFfPviES2_iiS1_ff6ImVec2(label: *const u8, values_getter: *const fn (*void) f32, data: *void, values_count: c_int, values_offset: c_int, overlay_text: *const u8, scale_min: f32, scale_max: f32, graph_size: ImVec2) void;
    pub const ValueBool = _ZN5ImGui5ValueEPKcb;
    extern fn _ZN5ImGui5ValueEPKcb(prefix: *const u8, b: bool) void;
    pub const ValueInt = _ZN5ImGui5ValueEPKci;
    extern fn _ZN5ImGui5ValueEPKci(prefix: *const u8, v: c_int) void;
    pub const ValueUInt = _ZN5ImGui5ValueEPKcj;
    extern fn _ZN5ImGui5ValueEPKcj(prefix: *const u8, v: c_uint) void;
    pub const ValueFloat = _ZN5ImGui5ValueEPKcfS1_;
    extern fn _ZN5ImGui5ValueEPKcfS1_(prefix: *const u8, v: f32, float_format: *const u8) void;
    pub const BeginMenuBar = _ZN5ImGui12BeginMenuBarEv;
    extern fn _ZN5ImGui12BeginMenuBarEv() bool;
    pub const EndMenuBar = _ZN5ImGui10EndMenuBarEv;
    extern fn _ZN5ImGui10EndMenuBarEv() void;
    pub const BeginMainMenuBar = _ZN5ImGui16BeginMainMenuBarEv;
    extern fn _ZN5ImGui16BeginMainMenuBarEv() bool;
    pub const EndMainMenuBar = _ZN5ImGui14EndMainMenuBarEv;
    extern fn _ZN5ImGui14EndMainMenuBarEv() void;
    pub const BeginMenu = _ZN5ImGui9BeginMenuEPKcb;
    extern fn _ZN5ImGui9BeginMenuEPKcb(label: *const u8, enabled: bool) bool;
    pub const EndMenu = _ZN5ImGui7EndMenuEv;
    extern fn _ZN5ImGui7EndMenuEv() void;
    pub const MenuItem = _ZN5ImGui8MenuItemEPKcS1_bb;
    extern fn _ZN5ImGui8MenuItemEPKcS1_bb(label: *const u8, shortcut: *const u8, selected: bool, enabled: bool) bool;
    pub const MenuItemPtr = _ZN5ImGui8MenuItemEPKcS1_Pbb;
    extern fn _ZN5ImGui8MenuItemEPKcS1_Pbb(label: *const u8, shortcut: *const u8, p_selected: *bool, enabled: bool) bool;
    pub const BeginTooltip = _ZN5ImGui12BeginTooltipEv;
    extern fn _ZN5ImGui12BeginTooltipEv() bool;
    pub const EndTooltip = _ZN5ImGui10EndTooltipEv;
    extern fn _ZN5ImGui10EndTooltipEv() void;
    pub const SetTooltip = _ZN5ImGui10SetTooltipEPKcz;
    extern fn _ZN5ImGui10SetTooltipEPKcz(fmt: *const u8, ...) callconv(.C) void;
    pub const SetTooltipV = _ZN5ImGui11SetTooltipVEPKcPc;
    extern fn _ZN5ImGui11SetTooltipVEPKcPc(fmt: *const u8, args: *u8) void;
    pub const BeginPopup = _ZN5ImGui10BeginPopupEPKci;
    extern fn _ZN5ImGui10BeginPopupEPKci(str_id: *const u8, flags: ImGuiWindowFlags) bool;
    pub const BeginPopupModal = _ZN5ImGui15BeginPopupModalEPKcPbi;
    extern fn _ZN5ImGui15BeginPopupModalEPKcPbi(name: *const u8, p_open: *bool, flags: ImGuiWindowFlags) bool;
    pub const EndPopup = _ZN5ImGui8EndPopupEv;
    extern fn _ZN5ImGui8EndPopupEv() void;
    pub const OpenPopup = _ZN5ImGui9OpenPopupEPKci;
    extern fn _ZN5ImGui9OpenPopupEPKci(str_id: *const u8, popup_flags: ImGuiPopupFlags) void;
    pub const OpenPopupId = _ZN5ImGui9OpenPopupEji;
    extern fn _ZN5ImGui9OpenPopupEji(id: ImGuiID, popup_flags: ImGuiPopupFlags) void;
    pub const OpenPopupOnItemClick = _ZN5ImGui20OpenPopupOnItemClickEPKci;
    extern fn _ZN5ImGui20OpenPopupOnItemClickEPKci(str_id: *const u8, popup_flags: ImGuiPopupFlags) void;
    pub const CloseCurrentPopup = _ZN5ImGui17CloseCurrentPopupEv;
    extern fn _ZN5ImGui17CloseCurrentPopupEv() void;
    pub const BeginPopupContextItem = _ZN5ImGui21BeginPopupContextItemEPKci;
    extern fn _ZN5ImGui21BeginPopupContextItemEPKci(str_id: *const u8, popup_flags: ImGuiPopupFlags) bool;
    pub const BeginPopupContextWindow = _ZN5ImGui23BeginPopupContextWindowEPKci;
    extern fn _ZN5ImGui23BeginPopupContextWindowEPKci(str_id: *const u8, popup_flags: ImGuiPopupFlags) bool;
    pub const BeginPopupContextVoid = _ZN5ImGui21BeginPopupContextVoidEPKci;
    extern fn _ZN5ImGui21BeginPopupContextVoidEPKci(str_id: *const u8, popup_flags: ImGuiPopupFlags) bool;
    pub const IsPopupOpen = _ZN5ImGui11IsPopupOpenEPKci;
    extern fn _ZN5ImGui11IsPopupOpenEPKci(str_id: *const u8, flags: ImGuiPopupFlags) bool;
    pub const BeginTable = _ZN5ImGui10BeginTableEPKciiRK6ImVec2f;
    extern fn _ZN5ImGui10BeginTableEPKciiRK6ImVec2f(str_id: *const u8, column: c_int, flags: ImGuiTableFlags, outer_size: *const ImVec2, inner_width: f32) bool;
    pub const EndTable = _ZN5ImGui8EndTableEv;
    extern fn _ZN5ImGui8EndTableEv() void;
    pub const TableNextRow = _ZN5ImGui12TableNextRowEif;
    extern fn _ZN5ImGui12TableNextRowEif(row_flags: ImGuiTableRowFlags, min_row_height: f32) void;
    pub const TableNextColumn = _ZN5ImGui15TableNextColumnEv;
    extern fn _ZN5ImGui15TableNextColumnEv() bool;
    pub const TableSetColumnIndex = _ZN5ImGui19TableSetColumnIndexEi;
    extern fn _ZN5ImGui19TableSetColumnIndexEi(column_n: c_int) bool;
    pub const TableSetupColumn = _ZN5ImGui16TableSetupColumnEPKcifj;
    extern fn _ZN5ImGui16TableSetupColumnEPKcifj(label: *const u8, flags: ImGuiTableColumnFlags, init_width_or_weight: f32, user_id: ImGuiID) void;
    pub const TableSetupScrollFreeze = _ZN5ImGui22TableSetupScrollFreezeEii;
    extern fn _ZN5ImGui22TableSetupScrollFreezeEii(cols: c_int, rows: c_int) void;
    pub const TableHeadersRow = _ZN5ImGui15TableHeadersRowEv;
    extern fn _ZN5ImGui15TableHeadersRowEv() void;
    pub const TableHeader = _ZN5ImGui11TableHeaderEPKc;
    extern fn _ZN5ImGui11TableHeaderEPKc(label: *const u8) void;
    pub const TableGetSortSpecs = _ZN5ImGui17TableGetSortSpecsEv;
    extern fn _ZN5ImGui17TableGetSortSpecsEv() *ImGuiTableSortSpecs;
    pub const TableGetColumnCount = _ZN5ImGui19TableGetColumnCountEv;
    extern fn _ZN5ImGui19TableGetColumnCountEv() c_int;
    pub const TableGetColumnIndex = _ZN5ImGui19TableGetColumnIndexEv;
    extern fn _ZN5ImGui19TableGetColumnIndexEv() c_int;
    pub const TableGetRowIndex = _ZN5ImGui16TableGetRowIndexEv;
    extern fn _ZN5ImGui16TableGetRowIndexEv() c_int;
    pub const TableGetColumnName = _ZN5ImGui18TableGetColumnNameEi;
    extern fn _ZN5ImGui18TableGetColumnNameEi(column_n: c_int) *const u8;
    pub const TableGetColumnFlags = _ZN5ImGui19TableGetColumnFlagsEi;
    extern fn _ZN5ImGui19TableGetColumnFlagsEi(column_n: c_int) ImGuiTableColumnFlags;
    pub const TableSetColumnEnabled = _ZN5ImGui21TableSetColumnEnabledEib;
    extern fn _ZN5ImGui21TableSetColumnEnabledEib(column_n: c_int, v: bool) void;
    pub const TableSetBgColor = _ZN5ImGui15TableSetBgColorEiji;
    extern fn _ZN5ImGui15TableSetBgColorEiji(target: ImGuiTableBgTarget, color: ImU32, column_n: c_int) void;
    pub const Columns = _ZN5ImGui7ColumnsEiPKcb;
    extern fn _ZN5ImGui7ColumnsEiPKcb(count: c_int, id: *const u8, border: bool) void;
    pub const NextColumn = _ZN5ImGui10NextColumnEv;
    extern fn _ZN5ImGui10NextColumnEv() void;
    pub const GetColumnIndex = _ZN5ImGui14GetColumnIndexEv;
    extern fn _ZN5ImGui14GetColumnIndexEv() c_int;
    pub const GetColumnWidth = _ZN5ImGui14GetColumnWidthEi;
    extern fn _ZN5ImGui14GetColumnWidthEi(column_index: c_int) f32;
    pub const SetColumnWidth = _ZN5ImGui14SetColumnWidthEif;
    extern fn _ZN5ImGui14SetColumnWidthEif(column_index: c_int, width: f32) void;
    pub const GetColumnOffset = _ZN5ImGui15GetColumnOffsetEi;
    extern fn _ZN5ImGui15GetColumnOffsetEi(column_index: c_int) f32;
    pub const SetColumnOffset = _ZN5ImGui15SetColumnOffsetEif;
    extern fn _ZN5ImGui15SetColumnOffsetEif(column_index: c_int, offset_x: f32) void;
    pub const GetColumnsCount = _ZN5ImGui15GetColumnsCountEv;
    extern fn _ZN5ImGui15GetColumnsCountEv() c_int;
    pub const BeginTabBar = _ZN5ImGui11BeginTabBarEPKci;
    extern fn _ZN5ImGui11BeginTabBarEPKci(str_id: *const u8, flags: ImGuiTabBarFlags) bool;
    pub const EndTabBar = _ZN5ImGui9EndTabBarEv;
    extern fn _ZN5ImGui9EndTabBarEv() void;
    pub const BeginTabItem = _ZN5ImGui12BeginTabItemEPKcPbi;
    extern fn _ZN5ImGui12BeginTabItemEPKcPbi(label: *const u8, p_open: *bool, flags: ImGuiTabItemFlags) bool;
    pub const EndTabItem = _ZN5ImGui10EndTabItemEv;
    extern fn _ZN5ImGui10EndTabItemEv() void;
    pub const TabItemButton = _ZN5ImGui13TabItemButtonEPKci;
    extern fn _ZN5ImGui13TabItemButtonEPKci(label: *const u8, flags: ImGuiTabItemFlags) bool;
    pub const SetTabItemClosed = _ZN5ImGui16SetTabItemClosedEPKc;
    extern fn _ZN5ImGui16SetTabItemClosedEPKc(tab_or_docked_window_label: *const u8) void;
    pub const DockSpace = _ZN5ImGui9DockSpaceEjRK6ImVec2iPK16ImGuiWindowClass;
    extern fn _ZN5ImGui9DockSpaceEjRK6ImVec2iPK16ImGuiWindowClass(id: ImGuiID, size: *const ImVec2, flags: ImGuiDockNodeFlags, window_class: *const ImGuiWindowClass) ImGuiID;
    pub const DockSpaceOverViewport = _ZN5ImGui21DockSpaceOverViewportEPK13ImGuiViewportiPK16ImGuiWindowClass;
    extern fn _ZN5ImGui21DockSpaceOverViewportEPK13ImGuiViewportiPK16ImGuiWindowClass(viewport: *const ImGuiViewport, flags: ImGuiDockNodeFlags, window_class: *const ImGuiWindowClass) ImGuiID;
    pub const SetNextWindowDockID = _ZN5ImGui19SetNextWindowDockIDEji;
    extern fn _ZN5ImGui19SetNextWindowDockIDEji(dock_id: ImGuiID, cond: ImGuiCond) void;
    pub const SetNextWindowClass = _ZN5ImGui18SetNextWindowClassEPK16ImGuiWindowClass;
    extern fn _ZN5ImGui18SetNextWindowClassEPK16ImGuiWindowClass(window_class: *const ImGuiWindowClass) void;
    pub const GetWindowDockID = _ZN5ImGui15GetWindowDockIDEv;
    extern fn _ZN5ImGui15GetWindowDockIDEv() ImGuiID;
    pub const IsWindowDocked = _ZN5ImGui14IsWindowDockedEv;
    extern fn _ZN5ImGui14IsWindowDockedEv() bool;
    pub const LogToTTY = _ZN5ImGui8LogToTTYEi;
    extern fn _ZN5ImGui8LogToTTYEi(auto_open_depth: c_int) void;
    pub const LogToFile = _ZN5ImGui9LogToFileEiPKc;
    extern fn _ZN5ImGui9LogToFileEiPKc(auto_open_depth: c_int, filename: *const u8) void;
    pub const LogToClipboard = _ZN5ImGui14LogToClipboardEi;
    extern fn _ZN5ImGui14LogToClipboardEi(auto_open_depth: c_int) void;
    pub const LogFinish = _ZN5ImGui9LogFinishEv;
    extern fn _ZN5ImGui9LogFinishEv() void;
    pub const LogButtons = _ZN5ImGui10LogButtonsEv;
    extern fn _ZN5ImGui10LogButtonsEv() void;
    pub const LogText = _ZN5ImGui7LogTextEPKcz;
    extern fn _ZN5ImGui7LogTextEPKcz(fmt: *const u8, ...) callconv(.C) void;
    pub const LogTextV = _ZN5ImGui8LogTextVEPKcPc;
    extern fn _ZN5ImGui8LogTextVEPKcPc(fmt: *const u8, args: *u8) void;
    pub const BeginDragDropSource = _ZN5ImGui19BeginDragDropSourceEi;
    extern fn _ZN5ImGui19BeginDragDropSourceEi(flags: ImGuiDragDropFlags) bool;
    pub const SetDragDropPayload = _ZN5ImGui18SetDragDropPayloadEPKcPKvyi;
    extern fn _ZN5ImGui18SetDragDropPayloadEPKcPKvyi(type: *const u8, data: *const void, sz: usize, cond: ImGuiCond) bool;
    pub const EndDragDropSource = _ZN5ImGui17EndDragDropSourceEv;
    extern fn _ZN5ImGui17EndDragDropSourceEv() void;
    pub const BeginDragDropTarget = _ZN5ImGui19BeginDragDropTargetEv;
    extern fn _ZN5ImGui19BeginDragDropTargetEv() bool;
    pub const AcceptDragDropPayload = _ZN5ImGui21AcceptDragDropPayloadEPKci;
    extern fn _ZN5ImGui21AcceptDragDropPayloadEPKci(type: *const u8, flags: ImGuiDragDropFlags) *const ImGuiPayload;
    pub const EndDragDropTarget = _ZN5ImGui17EndDragDropTargetEv;
    extern fn _ZN5ImGui17EndDragDropTargetEv() void;
    pub const GetDragDropPayload = _ZN5ImGui18GetDragDropPayloadEv;
    extern fn _ZN5ImGui18GetDragDropPayloadEv() *const ImGuiPayload;
    pub const BeginDisabled = _ZN5ImGui13BeginDisabledEb;
    extern fn _ZN5ImGui13BeginDisabledEb(disabled: bool) void;
    pub const EndDisabled = _ZN5ImGui11EndDisabledEv;
    extern fn _ZN5ImGui11EndDisabledEv() void;
    pub const PushClipRect = _ZN5ImGui12PushClipRectERK6ImVec2S2_b;
    extern fn _ZN5ImGui12PushClipRectERK6ImVec2S2_b(clip_rect_min: *const ImVec2, clip_rect_max: *const ImVec2, intersect_with_current_clip_rect: bool) void;
    pub const PopClipRect = _ZN5ImGui11PopClipRectEv;
    extern fn _ZN5ImGui11PopClipRectEv() void;
    pub const SetItemDefaultFocus = _ZN5ImGui19SetItemDefaultFocusEv;
    extern fn _ZN5ImGui19SetItemDefaultFocusEv() void;
    pub const SetKeyboardFocusHere = _ZN5ImGui20SetKeyboardFocusHereEi;
    extern fn _ZN5ImGui20SetKeyboardFocusHereEi(offset: c_int) void;
    pub const IsItemHovered = _ZN5ImGui13IsItemHoveredEi;
    extern fn _ZN5ImGui13IsItemHoveredEi(flags: ImGuiHoveredFlags) bool;
    pub const IsItemActive = _ZN5ImGui12IsItemActiveEv;
    extern fn _ZN5ImGui12IsItemActiveEv() bool;
    pub const IsItemFocused = _ZN5ImGui13IsItemFocusedEv;
    extern fn _ZN5ImGui13IsItemFocusedEv() bool;
    pub const IsItemClicked = _ZN5ImGui13IsItemClickedEi;
    extern fn _ZN5ImGui13IsItemClickedEi(mouse_button: ImGuiMouseButton) bool;
    pub const IsItemVisible = _ZN5ImGui13IsItemVisibleEv;
    extern fn _ZN5ImGui13IsItemVisibleEv() bool;
    pub const IsItemEdited = _ZN5ImGui12IsItemEditedEv;
    extern fn _ZN5ImGui12IsItemEditedEv() bool;
    pub const IsItemActivated = _ZN5ImGui15IsItemActivatedEv;
    extern fn _ZN5ImGui15IsItemActivatedEv() bool;
    pub const IsItemDeactivated = _ZN5ImGui17IsItemDeactivatedEv;
    extern fn _ZN5ImGui17IsItemDeactivatedEv() bool;
    pub const IsItemDeactivatedAfterEdit = _ZN5ImGui26IsItemDeactivatedAfterEditEv;
    extern fn _ZN5ImGui26IsItemDeactivatedAfterEditEv() bool;
    pub const IsItemToggledOpen = _ZN5ImGui17IsItemToggledOpenEv;
    extern fn _ZN5ImGui17IsItemToggledOpenEv() bool;
    pub const IsAnyItemHovered = _ZN5ImGui16IsAnyItemHoveredEv;
    extern fn _ZN5ImGui16IsAnyItemHoveredEv() bool;
    pub const IsAnyItemActive = _ZN5ImGui15IsAnyItemActiveEv;
    extern fn _ZN5ImGui15IsAnyItemActiveEv() bool;
    pub const IsAnyItemFocused = _ZN5ImGui16IsAnyItemFocusedEv;
    extern fn _ZN5ImGui16IsAnyItemFocusedEv() bool;
    pub const GetItemID = _ZN5ImGui9GetItemIDEv;
    extern fn _ZN5ImGui9GetItemIDEv() ImGuiID;
    pub const GetItemRectMin = _ZN5ImGui14GetItemRectMinEv;
    extern fn _ZN5ImGui14GetItemRectMinEv() ImVec2;
    pub const GetItemRectMax = _ZN5ImGui14GetItemRectMaxEv;
    extern fn _ZN5ImGui14GetItemRectMaxEv() ImVec2;
    pub const GetItemRectSize = _ZN5ImGui15GetItemRectSizeEv;
    extern fn _ZN5ImGui15GetItemRectSizeEv() ImVec2;
    pub const SetItemAllowOverlap = _ZN5ImGui19SetItemAllowOverlapEv;
    extern fn _ZN5ImGui19SetItemAllowOverlapEv() void;
    pub const GetMainViewport = _ZN5ImGui15GetMainViewportEv;
    extern fn _ZN5ImGui15GetMainViewportEv() *ImGuiViewport;
    pub const GetBackgroundDrawList = _ZN5ImGui21GetBackgroundDrawListEv;
    extern fn _ZN5ImGui21GetBackgroundDrawListEv() *ImDrawList;
    pub const GetForegroundDrawList = _ZN5ImGui21GetForegroundDrawListEv;
    extern fn _ZN5ImGui21GetForegroundDrawListEv() *ImDrawList;
    pub const GetBackgroundDrawListFromViewport = _ZN5ImGui21GetBackgroundDrawListEP13ImGuiViewport;
    extern fn _ZN5ImGui21GetBackgroundDrawListEP13ImGuiViewport(viewport: *ImGuiViewport) *ImDrawList;
    pub const GetForegroundDrawListFromViewport = _ZN5ImGui21GetForegroundDrawListEP13ImGuiViewport;
    extern fn _ZN5ImGui21GetForegroundDrawListEP13ImGuiViewport(viewport: *ImGuiViewport) *ImDrawList;
    pub const IsRectVisible = _ZN5ImGui13IsRectVisibleERK6ImVec2;
    extern fn _ZN5ImGui13IsRectVisibleERK6ImVec2(size: *const ImVec2) bool;
    pub const IsRectVisibleMinMax = _ZN5ImGui13IsRectVisibleERK6ImVec2S2_;
    extern fn _ZN5ImGui13IsRectVisibleERK6ImVec2S2_(rect_min: *const ImVec2, rect_max: *const ImVec2) bool;
    pub const GetTime = _ZN5ImGui7GetTimeEv;
    extern fn _ZN5ImGui7GetTimeEv() f64;
    pub const GetFrameCount = _ZN5ImGui13GetFrameCountEv;
    extern fn _ZN5ImGui13GetFrameCountEv() c_int;
    pub const GetDrawListSharedData = _ZN5ImGui21GetDrawListSharedDataEv;
    extern fn _ZN5ImGui21GetDrawListSharedDataEv() *ImDrawListSharedData;
    pub const GetStyleColorName = _ZN5ImGui17GetStyleColorNameEi;
    extern fn _ZN5ImGui17GetStyleColorNameEi(idx: ImGuiCol) *const u8;
    pub const SetStateStorage = _ZN5ImGui15SetStateStorageEP12ImGuiStorage;
    extern fn _ZN5ImGui15SetStateStorageEP12ImGuiStorage(storage: *ImGuiStorage) void;
    pub const GetStateStorage = _ZN5ImGui15GetStateStorageEv;
    extern fn _ZN5ImGui15GetStateStorageEv() *ImGuiStorage;
    pub const BeginChildFrame = _ZN5ImGui15BeginChildFrameEjRK6ImVec2i;
    extern fn _ZN5ImGui15BeginChildFrameEjRK6ImVec2i(id: ImGuiID, size: *const ImVec2, flags: ImGuiWindowFlags) bool;
    pub const EndChildFrame = _ZN5ImGui13EndChildFrameEv;
    extern fn _ZN5ImGui13EndChildFrameEv() void;
    pub const CalcTextSize = _ZN5ImGui12CalcTextSizeEPKcS1_bf;
    extern fn _ZN5ImGui12CalcTextSizeEPKcS1_bf(text: *const u8, text_end: *const u8, hide_text_after_double_hash: bool, wrap_width: f32) ImVec2;
    pub const ColorConvertU32ToFloat4 = _ZN5ImGui23ColorConvertU32ToFloat4Ej;
    extern fn _ZN5ImGui23ColorConvertU32ToFloat4Ej(in: ImU32) ImVec4;
    pub const ColorConvertFloat4ToU32 = _ZN5ImGui23ColorConvertFloat4ToU32ERK6ImVec4;
    extern fn _ZN5ImGui23ColorConvertFloat4ToU32ERK6ImVec4(in: *const ImVec4) ImU32;
    pub const ColorConvertRGBtoHSV = _ZN5ImGui20ColorConvertRGBtoHSVEfffRfS0_S0_;
    extern fn _ZN5ImGui20ColorConvertRGBtoHSVEfffRfS0_S0_(r: f32, g: f32, b: f32, out_h: *f32, out_s: *f32, out_v: *f32) void;
    pub const ColorConvertHSVtoRGB = _ZN5ImGui20ColorConvertHSVtoRGBEfffRfS0_S0_;
    extern fn _ZN5ImGui20ColorConvertHSVtoRGBEfffRfS0_S0_(h: f32, s: f32, v: f32, out_r: *f32, out_g: *f32, out_b: *f32) void;
    pub const IsKeyDown = _ZN5ImGui9IsKeyDownE8ImGuiKey;
    extern fn _ZN5ImGui9IsKeyDownE8ImGuiKey(key: ImGuiKey) bool;
    pub const IsKeyPressed = _ZN5ImGui12IsKeyPressedE8ImGuiKeyb;
    extern fn _ZN5ImGui12IsKeyPressedE8ImGuiKeyb(key: ImGuiKey, repeat: bool) bool;
    pub const IsKeyReleased = _ZN5ImGui13IsKeyReleasedE8ImGuiKey;
    extern fn _ZN5ImGui13IsKeyReleasedE8ImGuiKey(key: ImGuiKey) bool;
    pub const GetKeyPressedAmount = _ZN5ImGui19GetKeyPressedAmountE8ImGuiKeyff;
    extern fn _ZN5ImGui19GetKeyPressedAmountE8ImGuiKeyff(key: ImGuiKey, repeat_delay: f32, rate: f32) c_int;
    pub const GetKeyName = _ZN5ImGui10GetKeyNameE8ImGuiKey;
    extern fn _ZN5ImGui10GetKeyNameE8ImGuiKey(key: ImGuiKey) *const u8;
    pub const SetNextFrameWantCaptureKeyboard = _ZN5ImGui31SetNextFrameWantCaptureKeyboardEb;
    extern fn _ZN5ImGui31SetNextFrameWantCaptureKeyboardEb(want_capture_keyboard: bool) void;
    pub const IsMouseDown = _ZN5ImGui11IsMouseDownEi;
    extern fn _ZN5ImGui11IsMouseDownEi(button: ImGuiMouseButton) bool;
    pub const IsMouseClicked = _ZN5ImGui14IsMouseClickedEib;
    extern fn _ZN5ImGui14IsMouseClickedEib(button: ImGuiMouseButton, repeat: bool) bool;
    pub const IsMouseReleased = _ZN5ImGui15IsMouseReleasedEi;
    extern fn _ZN5ImGui15IsMouseReleasedEi(button: ImGuiMouseButton) bool;
    pub const IsMouseDoubleClicked = _ZN5ImGui20IsMouseDoubleClickedEi;
    extern fn _ZN5ImGui20IsMouseDoubleClickedEi(button: ImGuiMouseButton) bool;
    pub const GetMouseClickedCount = _ZN5ImGui20GetMouseClickedCountEi;
    extern fn _ZN5ImGui20GetMouseClickedCountEi(button: ImGuiMouseButton) c_int;
    pub const IsMouseHoveringRect = _ZN5ImGui19IsMouseHoveringRectERK6ImVec2S2_b;
    extern fn _ZN5ImGui19IsMouseHoveringRectERK6ImVec2S2_b(r_min: *const ImVec2, r_max: *const ImVec2, clip: bool) bool;
    pub const IsMousePosValid = _ZN5ImGui15IsMousePosValidEPK6ImVec2;
    extern fn _ZN5ImGui15IsMousePosValidEPK6ImVec2(mouse_pos: *const ImVec2) bool;
    pub const IsAnyMouseDown = _ZN5ImGui14IsAnyMouseDownEv;
    extern fn _ZN5ImGui14IsAnyMouseDownEv() bool;
    pub const GetMousePos = _ZN5ImGui11GetMousePosEv;
    extern fn _ZN5ImGui11GetMousePosEv() ImVec2;
    pub const GetMousePosOnOpeningCurrentPopup = _ZN5ImGui32GetMousePosOnOpeningCurrentPopupEv;
    extern fn _ZN5ImGui32GetMousePosOnOpeningCurrentPopupEv() ImVec2;
    pub const IsMouseDragging = _ZN5ImGui15IsMouseDraggingEif;
    extern fn _ZN5ImGui15IsMouseDraggingEif(button: ImGuiMouseButton, lock_threshold: f32) bool;
    pub const GetMouseDragDelta = _ZN5ImGui17GetMouseDragDeltaEif;
    extern fn _ZN5ImGui17GetMouseDragDeltaEif(button: ImGuiMouseButton, lock_threshold: f32) ImVec2;
    pub const ResetMouseDragDelta = _ZN5ImGui19ResetMouseDragDeltaEi;
    extern fn _ZN5ImGui19ResetMouseDragDeltaEi(button: ImGuiMouseButton) void;
    pub const GetMouseCursor = _ZN5ImGui14GetMouseCursorEv;
    extern fn _ZN5ImGui14GetMouseCursorEv() ImGuiMouseCursor;
    pub const SetMouseCursor = _ZN5ImGui14SetMouseCursorEi;
    extern fn _ZN5ImGui14SetMouseCursorEi(cursor_type: ImGuiMouseCursor) void;
    pub const SetNextFrameWantCaptureMouse = _ZN5ImGui28SetNextFrameWantCaptureMouseEb;
    extern fn _ZN5ImGui28SetNextFrameWantCaptureMouseEb(want_capture_mouse: bool) void;
    pub const GetClipboardText = _ZN5ImGui16GetClipboardTextEv;
    extern fn _ZN5ImGui16GetClipboardTextEv() *const u8;
    pub const SetClipboardText = _ZN5ImGui16SetClipboardTextEPKc;
    extern fn _ZN5ImGui16SetClipboardTextEPKc(text: *const u8) void;
    pub const LoadIniSettingsFromDisk = _ZN5ImGui23LoadIniSettingsFromDiskEPKc;
    extern fn _ZN5ImGui23LoadIniSettingsFromDiskEPKc(ini_filename: *const u8) void;
    pub const LoadIniSettingsFromMemory = _ZN5ImGui25LoadIniSettingsFromMemoryEPKcy;
    extern fn _ZN5ImGui25LoadIniSettingsFromMemoryEPKcy(ini_data: *const u8, ini_size: usize) void;
    pub const SaveIniSettingsToDisk = _ZN5ImGui21SaveIniSettingsToDiskEPKc;
    extern fn _ZN5ImGui21SaveIniSettingsToDiskEPKc(ini_filename: *const u8) void;
    pub const SaveIniSettingsToMemory = _ZN5ImGui23SaveIniSettingsToMemoryEPy;
    extern fn _ZN5ImGui23SaveIniSettingsToMemoryEPy(out_ini_size: *usize) *const u8;
    pub const DebugTextEncoding = _ZN5ImGui17DebugTextEncodingEPKc;
    extern fn _ZN5ImGui17DebugTextEncodingEPKc(text: *const u8) void;
    pub const DebugCheckVersionAndDataLayout = _ZN5ImGui30DebugCheckVersionAndDataLayoutEPKcyyyyyy;
    extern fn _ZN5ImGui30DebugCheckVersionAndDataLayoutEPKcyyyyyy(version_str: *const u8, sz_io: usize, sz_style: usize, sz_vec2: usize, sz_vec4: usize, sz_drawvert: usize, sz_drawidx: usize) bool;
    pub const SetAllocatorFunctions = _ZN5ImGui21SetAllocatorFunctionsEPFPvyS0_EPFvS0_S0_ES0_;
    extern fn _ZN5ImGui21SetAllocatorFunctionsEPFPvyS0_EPFvS0_S0_ES0_(alloc_func: ImGuiMemAllocFunc, free_func: ImGuiMemFreeFunc, user_data: *void) void;
    pub const GetAllocatorFunctions = _ZN5ImGui21GetAllocatorFunctionsEPPFPvyS0_EPPFvS0_S0_EPS0_;
    extern fn _ZN5ImGui21GetAllocatorFunctionsEPPFPvyS0_EPPFvS0_S0_EPS0_(p_alloc_func: *ImGuiMemAllocFunc, p_free_func: *ImGuiMemFreeFunc, p_user_data: **void) void;
    pub const MemAlloc = _ZN5ImGui8MemAllocEy;
    extern fn _ZN5ImGui8MemAllocEy(size: usize) *void;
    pub const MemFree = _ZN5ImGui7MemFreeEPv;
    extern fn _ZN5ImGui7MemFreeEPv(ptr: *void) void;
    pub const GetPlatformIO = _ZN5ImGui13GetPlatformIOEv;
    extern fn _ZN5ImGui13GetPlatformIOEv() *ImGuiPlatformIO;
    pub const UpdatePlatformWindows = _ZN5ImGui21UpdatePlatformWindowsEv;
    extern fn _ZN5ImGui21UpdatePlatformWindowsEv() void;
    pub const RenderPlatformWindowsDefault = _ZN5ImGui28RenderPlatformWindowsDefaultEPvS0_;
    extern fn _ZN5ImGui28RenderPlatformWindowsDefaultEPvS0_(platform_render_arg: *void, renderer_render_arg: *void) void;
    pub const DestroyPlatformWindows = _ZN5ImGui22DestroyPlatformWindowsEv;
    extern fn _ZN5ImGui22DestroyPlatformWindowsEv() void;
    pub const FindViewportByID = _ZN5ImGui16FindViewportByIDEj;
    extern fn _ZN5ImGui16FindViewportByIDEj(id: ImGuiID) *ImGuiViewport;
    pub const FindViewportByPlatformHandle = _ZN5ImGui28FindViewportByPlatformHandleEPv;
    extern fn _ZN5ImGui28FindViewportByPlatformHandleEPv(platform_handle: *void) *ImGuiViewport;

    pub const GetKeyIndex = _ZN5ImGui11GetKeyIndexE8ImGuiKey;
    extern fn _ZN5ImGui11GetKeyIndexE8ImGuiKey(key: ImGuiKey) ImGuiKey;
};

pub const ImGuiWindowFlags_ = enum {
    None,
    NoTitleBar,
    NoResize,
    NoMove,
    NoScrollbar,
    NoScrollWithMouse,
    NoCollapse,
    AlwaysAutoResize,
    NoBackground,
    NoSavedSettings,
    NoMouseInputs,
    MenuBar,
    HorizontalScrollbar,
    NoFocusOnAppearing,
    NoBringToFrontOnFocus,
    AlwaysVerticalScrollbar,
    AlwaysHorizontalScrollbar,
    AlwaysUseWindowPadding,
    NoNavInputs,
    NoNavFocus,
    UnsavedDocument,
    NoDocking,
    NoNav,
    NoDecoration,
    NoInputs,
    NavFlattened,
    ChildWindow,
    Tooltip,
    Popup,
    Modal,
    ChildMenu,
    DockNodeHost,
};

pub const ImGuiInputTextFlags_ = enum {
    None,
    CharsDecimal,
    CharsHexadecimal,
    CharsUppercase,
    CharsNoBlank,
    AutoSelectAll,
    EnterReturnsTrue,
    CallbackCompletion,
    CallbackHistory,
    CallbackAlways,
    CallbackCharFilter,
    AllowTabInput,
    CtrlEnterForNewLine,
    NoHorizontalScroll,
    AlwaysOverwrite,
    ReadOnly,
    Password,
    NoUndoRedo,
    CharsScientific,
    CallbackResize,
    CallbackEdit,
    EscapeClearsAll,
};

pub const ImGuiTreeNodeFlags_ = enum {
    None,
    Selected,
    Framed,
    AllowItemOverlap,
    NoTreePushOnOpen,
    NoAutoOpenOnLog,
    DefaultOpen,
    OpenOnDoubleClick,
    OpenOnArrow,
    Leaf,
    Bullet,
    FramePadding,
    SpanAvailWidth,
    SpanFullWidth,
    NavLeftJumpsBackHere,
    CollapsingHeader,
};

pub const ImGuiPopupFlags_ = enum {
    None,
    MouseButtonLeft,
    MouseButtonRight,
    MouseButtonMiddle,
    MouseButtonMask_,
    MouseButtonDefault_,
    NoOpenOverExistingPopup,
    NoOpenOverItems,
    AnyPopupId,
    AnyPopupLevel,
    AnyPopup,
};

pub const ImGuiSelectableFlags_ = enum {
    None,
    DontClosePopups,
    SpanAllColumns,
    AllowDoubleClick,
    Disabled,
    AllowItemOverlap,
};

pub const ImGuiComboFlags_ = enum {
    None,
    PopupAlignLeft,
    HeightSmall,
    HeightRegular,
    HeightLarge,
    HeightLargest,
    NoArrowButton,
    NoPreview,
    HeightMask_,
};

pub const ImGuiTabBarFlags_ = enum {
    None,
    Reorderable,
    AutoSelectNewTabs,
    TabListPopupButton,
    NoCloseWithMiddleMouseButton,
    NoTabListScrollingButtons,
    NoTooltip,
    FittingPolicyResizeDown,
    FittingPolicyScroll,
    FittingPolicyMask_,
    FittingPolicyDefault_,
};

pub const ImGuiTabItemFlags_ = enum {
    None,
    UnsavedDocument,
    SetSelected,
    NoCloseWithMiddleMouseButton,
    NoPushId,
    NoTooltip,
    NoReorder,
    Leading,
    Trailing,
};

pub const ImGuiTableFlags_ = enum {
    None,
    Resizable,
    Reorderable,
    Hideable,
    Sortable,
    NoSavedSettings,
    ContextMenuInBody,
    RowBg,
    BordersInnerH,
    BordersOuterH,
    BordersInnerV,
    BordersOuterV,
    BordersH,
    BordersV,
    BordersInner,
    BordersOuter,
    Borders,
    NoBordersInBody,
    NoBordersInBodyUntilResize,
    SizingFixedFit,
    SizingFixedSame,
    SizingStretchProp,
    SizingStretchSame,
    NoHostExtendX,
    NoHostExtendY,
    NoKeepColumnsVisible,
    PreciseWidths,
    NoClip,
    PadOuterX,
    NoPadOuterX,
    NoPadInnerX,
    ScrollX,
    ScrollY,
    SortMulti,
    SortTristate,
    SizingMask_,
};

pub const ImGuiTableColumnFlags_ = enum {
    None,
    Disabled,
    DefaultHide,
    DefaultSort,
    WidthStretch,
    WidthFixed,
    NoResize,
    NoReorder,
    NoHide,
    NoClip,
    NoSort,
    NoSortAscending,
    NoSortDescending,
    NoHeaderLabel,
    NoHeaderWidth,
    PreferSortAscending,
    PreferSortDescending,
    IndentEnable,
    IndentDisable,
    IsEnabled,
    IsVisible,
    IsSorted,
    IsHovered,
    WidthMask_,
    IndentMask_,
    StatusMask_,
    NoDirectResize_,
};

pub const ImGuiTableRowFlags_ = enum {
    None,
    Headers,
};

pub const ImGuiTableBgTarget_ = enum {
    None,
    RowBg0,
    RowBg1,
    CellBg,
};

pub const ImGuiFocusedFlags_ = enum {
    None,
    ChildWindows,
    RootWindow,
    AnyWindow,
    NoPopupHierarchy,
    DockHierarchy,
    RootAndChildWindows,
};

pub const ImGuiHoveredFlags_ = enum {
    None,
    ChildWindows,
    RootWindow,
    AnyWindow,
    NoPopupHierarchy,
    DockHierarchy,
    AllowWhenBlockedByPopup,
    AllowWhenBlockedByActiveItem,
    AllowWhenOverlapped,
    AllowWhenDisabled,
    NoNavOverride,
    RectOnly,
    RootAndChildWindows,
    DelayNormal,
    DelayShort,
    NoSharedDelay,
};

pub const ImGuiDockNodeFlags_ = enum {
    None,
    KeepAliveOnly,
    NoDockingInCentralNode,
    PassthruCentralNode,
    NoSplit,
    NoResize,
    AutoHideTabBar,
};

pub const ImGuiDragDropFlags_ = enum {
    None,
    SourceNoPreviewTooltip,
    SourceNoDisableHover,
    SourceNoHoldToOpenOthers,
    SourceAllowNullID,
    SourceExtern,
    SourceAutoExpirePayload,
    AcceptBeforeDelivery,
    AcceptNoDrawDefaultRect,
    AcceptNoPreviewTooltip,
    AcceptPeekOnly,
};

pub const ImGuiDataType_ = enum {
    S8,
    U8,
    S16,
    U16,
    S32,
    U32,
    S64,
    U64,
    Float,
    Double,
    COUNT,
};

pub const ImGuiDir_ = enum {
    None,
    Left,
    Right,
    Up,
    Down,
    COUNT,
};

pub const ImGuiSortDirection_ = enum {
    None,
    Ascending,
    Descending,
};

pub const ImGuiKey = enum {
    _None,
    _Tab,
    _LeftArrow,
    _RightArrow,
    _UpArrow,
    _DownArrow,
    _PageUp,
    _PageDown,
    _Home,
    _End,
    _Insert,
    _Delete,
    _Backspace,
    _Space,
    _Enter,
    _Escape,
    _LeftCtrl,
    _LeftShift,
    _LeftAlt,
    _LeftSuper,
    _RightCtrl,
    _RightShift,
    _RightAlt,
    _RightSuper,
    _Menu,
    _0,
    _1,
    _2,
    _3,
    _4,
    _5,
    _6,
    _7,
    _8,
    _9,
    _A,
    _B,
    _C,
    _D,
    _E,
    _F,
    _G,
    _H,
    _I,
    _J,
    _K,
    _L,
    _M,
    _N,
    _O,
    _P,
    _Q,
    _R,
    _S,
    _T,
    _U,
    _V,
    _W,
    _X,
    _Y,
    _Z,
    _F1,
    _F2,
    _F3,
    _F4,
    _F5,
    _F6,
    _F7,
    _F8,
    _F9,
    _F10,
    _F11,
    _F12,
    _Apostrophe,
    _Comma,
    _Minus,
    _Period,
    _Slash,
    _Semicolon,
    _Equal,
    _LeftBracket,
    _Backslash,
    _RightBracket,
    _GraveAccent,
    _CapsLock,
    _ScrollLock,
    _NumLock,
    _PrintScreen,
    _Pause,
    _Keypad0,
    _Keypad1,
    _Keypad2,
    _Keypad3,
    _Keypad4,
    _Keypad5,
    _Keypad6,
    _Keypad7,
    _Keypad8,
    _Keypad9,
    _KeypadDecimal,
    _KeypadDivide,
    _KeypadMultiply,
    _KeypadSubtract,
    _KeypadAdd,
    _KeypadEnter,
    _KeypadEqual,
    _GamepadStart,
    _GamepadBack,
    _GamepadFaceLeft,
    _GamepadFaceRight,
    _GamepadFaceUp,
    _GamepadFaceDown,
    _GamepadDpadLeft,
    _GamepadDpadRight,
    _GamepadDpadUp,
    _GamepadDpadDown,
    _GamepadL1,
    _GamepadR1,
    _GamepadL2,
    _GamepadR2,
    _GamepadL3,
    _GamepadR3,
    _GamepadLStickLeft,
    _GamepadLStickRight,
    _GamepadLStickUp,
    _GamepadLStickDown,
    _GamepadRStickLeft,
    _GamepadRStickRight,
    _GamepadRStickUp,
    _GamepadRStickDown,
    _MouseLeft,
    _MouseRight,
    _MouseMiddle,
    _MouseX1,
    _MouseX2,
    _MouseWheelX,
    _MouseWheelY,
    _ReservedForModCtrl,
    _ReservedForModShift,
    _ReservedForModAlt,
    _ReservedForModSuper,
    _COUNT,
    ImGuiMod_None,
    ImGuiMod_Ctrl,
    ImGuiMod_Shift,
    ImGuiMod_Alt,
    ImGuiMod_Super,
    ImGuiMod_Shortcut,
    ImGuiMod_Mask_,
    _NamedKey_BEGIN,
    _NamedKey_END,
    _NamedKey_COUNT,
    _KeysData_SIZE,
    _KeysData_OFFSET,
    _ModCtrl,
    _ModShift,
    _ModAlt,
    _ModSuper,
    _KeyPadEnter,
};

pub const ImGuiNavInput = enum {
    _Activate,
    _Cancel,
    _Input,
    _Menu,
    _DpadLeft,
    _DpadRight,
    _DpadUp,
    _DpadDown,
    _LStickLeft,
    _LStickRight,
    _LStickUp,
    _LStickDown,
    _FocusPrev,
    _FocusNext,
    _TweakSlow,
    _TweakFast,
    _COUNT,
};

pub const ImGuiConfigFlags_ = enum {
    None,
    NavEnableKeyboard,
    NavEnableGamepad,
    NavEnableSetMousePos,
    NavNoCaptureKeyboard,
    NoMouse,
    NoMouseCursorChange,
    DockingEnable,
    ViewportsEnable,
    DpiEnableScaleViewports,
    DpiEnableScaleFonts,
    IsSRGB,
    IsTouchScreen,
};

pub const ImGuiBackendFlags_ = enum {
    None,
    HasGamepad,
    HasMouseCursors,
    HasSetMousePos,
    RendererHasVtxOffset,
    PlatformHasViewports,
    HasMouseHoveredViewport,
    RendererHasViewports,
};

pub const ImGuiCol_ = enum {
    Text,
    TextDisabled,
    WindowBg,
    ChildBg,
    PopupBg,
    Border,
    BorderShadow,
    FrameBg,
    FrameBgHovered,
    FrameBgActive,
    TitleBg,
    TitleBgActive,
    TitleBgCollapsed,
    MenuBarBg,
    ScrollbarBg,
    ScrollbarGrab,
    ScrollbarGrabHovered,
    ScrollbarGrabActive,
    CheckMark,
    SliderGrab,
    SliderGrabActive,
    Button,
    ButtonHovered,
    ButtonActive,
    Header,
    HeaderHovered,
    HeaderActive,
    Separator,
    SeparatorHovered,
    SeparatorActive,
    ResizeGrip,
    ResizeGripHovered,
    ResizeGripActive,
    Tab,
    TabHovered,
    TabActive,
    TabUnfocused,
    TabUnfocusedActive,
    DockingPreview,
    DockingEmptyBg,
    PlotLines,
    PlotLinesHovered,
    PlotHistogram,
    PlotHistogramHovered,
    TableHeaderBg,
    TableBorderStrong,
    TableBorderLight,
    TableRowBg,
    TableRowBgAlt,
    TextSelectedBg,
    DragDropTarget,
    NavHighlight,
    NavWindowingHighlight,
    NavWindowingDimBg,
    ModalWindowDimBg,
    COUNT,
};

pub const ImGuiStyleVar_ = enum {
    Alpha,
    DisabledAlpha,
    WindowPadding,
    WindowRounding,
    WindowBorderSize,
    WindowMinSize,
    WindowTitleAlign,
    ChildRounding,
    ChildBorderSize,
    PopupRounding,
    PopupBorderSize,
    FramePadding,
    FrameRounding,
    FrameBorderSize,
    ItemSpacing,
    ItemInnerSpacing,
    IndentSpacing,
    CellPadding,
    ScrollbarSize,
    ScrollbarRounding,
    GrabMinSize,
    GrabRounding,
    TabRounding,
    ButtonTextAlign,
    SelectableTextAlign,
    SeparatorTextBorderSize,
    SeparatorTextAlign,
    SeparatorTextPadding,
    COUNT,
};

pub const ImGuiButtonFlags_ = enum {
    None,
    MouseButtonLeft,
    MouseButtonRight,
    MouseButtonMiddle,
    MouseButtonMask_,
    MouseButtonDefault_,
};

pub const ImGuiColorEditFlags_ = enum {
    None,
    NoAlpha,
    NoPicker,
    NoOptions,
    NoSmallPreview,
    NoInputs,
    NoTooltip,
    NoLabel,
    NoSidePreview,
    NoDragDrop,
    NoBorder,
    AlphaBar,
    AlphaPreview,
    AlphaPreviewHalf,
    HDR,
    DisplayRGB,
    DisplayHSV,
    DisplayHex,
    Uint8,
    Float,
    PickerHueBar,
    PickerHueWheel,
    InputRGB,
    InputHSV,
    DefaultOptions_,
    DisplayMask_,
    DataTypeMask_,
    PickerMask_,
    InputMask_,
};

pub const ImGuiSliderFlags_ = enum {
    None,
    AlwaysClamp,
    Logarithmic,
    NoRoundToFormat,
    NoInput,
    InvalidMask_,
};

pub const ImGuiMouseButton_ = enum {
    Left,
    Right,
    Middle,
    COUNT,
};

pub const ImGuiMouseCursor_ = enum {
    None,
    Arrow,
    TextInput,
    ResizeAll,
    ResizeNS,
    ResizeEW,
    ResizeNESW,
    ResizeNWSE,
    Hand,
    NotAllowed,
    COUNT,
};

pub const ImGuiMouseSource = enum {
    _Mouse,
    _TouchScreen,
    _Pen,
    _COUNT,
};

pub const ImGuiCond_ = enum {
    None,
    Always,
    Once,
    FirstUseEver,
    Appearing,
};

pub const ImNewWrapper = extern struct {};

pub fn ImVector(comptime T: type) type {
    return extern struct {
        Size: c_int,
        Capacity: c_int,
        Data: *T,
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

    pub const ScaleAllSizes = _ZN10ImGuiStyle13ScaleAllSizesEf;
    extern fn _ZN10ImGuiStyle13ScaleAllSizesEf(self: *ImGuiStyle, scale_factor: f32) void;
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
    IniFilename: *const u8,
    LogFilename: *const u8,
    MouseDoubleClickTime: f32,
    MouseDoubleClickMaxDist: f32,
    MouseDragThreshold: f32,
    KeyRepeatDelay: f32,
    KeyRepeatRate: f32,
    HoverDelayNormal: f32,
    HoverDelayShort: f32,
    UserData: *void,
    Fonts: *ImFontAtlas,
    FontGlobalScale: f32,
    FontAllowUserScaling: bool,
    FontDefault: *ImFont,
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
    BackendPlatformName: *const u8,
    BackendRendererName: *const u8,
    BackendPlatformUserData: *void,
    BackendRendererUserData: *void,
    BackendLanguageUserData: *void,
    GetClipboardTextFn: *const fn () *const u8,
    SetClipboardTextFn: *const fn (
        *void,
    ) void,
    ClipboardUserData: *void,
    SetPlatformImeDataFn: *const fn (
        *ImGuiViewport,
    ) void,
    ImeWindowHandle: *void,
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
    KeyMap: [652]c_int,
    KeysDown: [652]bool,
    NavInputs: [16]f32,
    Ctx: *ImGuiContext,
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
    KeysData: [652]ImGuiKeyData,
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

    pub const AddKeyEvent = _ZN7ImGuiIO11AddKeyEventE8ImGuiKeyb;
    extern fn _ZN7ImGuiIO11AddKeyEventE8ImGuiKeyb(self: *ImGuiIO, key: ImGuiKey, down: bool) void;
    pub const AddKeyAnalogEvent = _ZN7ImGuiIO17AddKeyAnalogEventE8ImGuiKeybf;
    extern fn _ZN7ImGuiIO17AddKeyAnalogEventE8ImGuiKeybf(self: *ImGuiIO, key: ImGuiKey, down: bool, v: f32) void;
    pub const AddMousePosEvent = _ZN7ImGuiIO16AddMousePosEventEff;
    extern fn _ZN7ImGuiIO16AddMousePosEventEff(self: *ImGuiIO, x: f32, y: f32) void;
    pub const AddMouseButtonEvent = _ZN7ImGuiIO19AddMouseButtonEventEib;
    extern fn _ZN7ImGuiIO19AddMouseButtonEventEib(self: *ImGuiIO, button: c_int, down: bool) void;
    pub const AddMouseWheelEvent = _ZN7ImGuiIO18AddMouseWheelEventEff;
    extern fn _ZN7ImGuiIO18AddMouseWheelEventEff(self: *ImGuiIO, wheel_x: f32, wheel_y: f32) void;
    pub const AddMouseSourceEvent = _ZN7ImGuiIO19AddMouseSourceEventE16ImGuiMouseSource;
    extern fn _ZN7ImGuiIO19AddMouseSourceEventE16ImGuiMouseSource(self: *ImGuiIO, source: ImGuiMouseSource) void;
    pub const AddMouseViewportEvent = _ZN7ImGuiIO21AddMouseViewportEventEj;
    extern fn _ZN7ImGuiIO21AddMouseViewportEventEj(self: *ImGuiIO, id: ImGuiID) void;
    pub const AddFocusEvent = _ZN7ImGuiIO13AddFocusEventEb;
    extern fn _ZN7ImGuiIO13AddFocusEventEb(self: *ImGuiIO, focused: bool) void;
    pub const AddInputCharacter = _ZN7ImGuiIO17AddInputCharacterEj;
    extern fn _ZN7ImGuiIO17AddInputCharacterEj(self: *ImGuiIO, c: c_uint) void;
    pub const AddInputCharacterUTF16 = _ZN7ImGuiIO22AddInputCharacterUTF16Et;
    extern fn _ZN7ImGuiIO22AddInputCharacterUTF16Et(self: *ImGuiIO, c: ImWchar16) void;
    pub const AddInputCharactersUTF8 = _ZN7ImGuiIO22AddInputCharactersUTF8EPKc;
    extern fn _ZN7ImGuiIO22AddInputCharactersUTF8EPKc(self: *ImGuiIO, str: *const u8) void;
    pub const SetKeyEventNativeData = _ZN7ImGuiIO21SetKeyEventNativeDataE8ImGuiKeyiii;
    extern fn _ZN7ImGuiIO21SetKeyEventNativeDataE8ImGuiKeyiii(self: *ImGuiIO, key: ImGuiKey, native_keycode: c_int, native_scancode: c_int, native_legacy_index: c_int) void;
    pub const SetAppAcceptingEvents = _ZN7ImGuiIO21SetAppAcceptingEventsEb;
    extern fn _ZN7ImGuiIO21SetAppAcceptingEventsEb(self: *ImGuiIO, accepting_events: bool) void;
    pub const ClearInputCharacters = _ZN7ImGuiIO20ClearInputCharactersEv;
    extern fn _ZN7ImGuiIO20ClearInputCharactersEv(self: *ImGuiIO) void;
    pub const ClearInputKeys = _ZN7ImGuiIO14ClearInputKeysEv;
    extern fn _ZN7ImGuiIO14ClearInputKeysEv(self: *ImGuiIO) void;
};

pub const ImGuiInputTextCallbackData = extern struct {
    Ctx: *ImGuiContext,
    EventFlag: ImGuiInputTextFlags,
    Flags: ImGuiInputTextFlags,
    UserData: *void,
    EventChar: ImWchar,
    EventKey: ImGuiKey,
    Buf: *u8,
    BufTextLen: c_int,
    BufSize: c_int,
    BufDirty: bool,
    CursorPos: c_int,
    SelectionStart: c_int,
    SelectionEnd: c_int,

    pub const DeleteChars = _ZN26ImGuiInputTextCallbackData11DeleteCharsEii;
    extern fn _ZN26ImGuiInputTextCallbackData11DeleteCharsEii(self: *ImGuiInputTextCallbackData, pos: c_int, bytes_count: c_int) void;
    pub const InsertChars = _ZN26ImGuiInputTextCallbackData11InsertCharsEiPKcS1_;
    extern fn _ZN26ImGuiInputTextCallbackData11InsertCharsEiPKcS1_(self: *ImGuiInputTextCallbackData, pos: c_int, text: *const u8, text_end: *const u8) void;
    pub const SelectAll = _ZN26ImGuiInputTextCallbackData9SelectAllEv;
    extern fn _ZN26ImGuiInputTextCallbackData9SelectAllEv(self: *ImGuiInputTextCallbackData) void;
    pub const ClearSelection = _ZN26ImGuiInputTextCallbackData14ClearSelectionEv;
    extern fn _ZN26ImGuiInputTextCallbackData14ClearSelectionEv(self: *ImGuiInputTextCallbackData) void;
    pub const HasSelection = _ZNK26ImGuiInputTextCallbackData12HasSelectionEv;
    extern fn _ZNK26ImGuiInputTextCallbackData12HasSelectionEv(self: *const ImGuiInputTextCallbackData) bool;
};

pub const ImGuiSizeCallbackData = extern struct {
    UserData: *void,
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
};

pub const ImGuiPayload = extern struct {
    Data: *void,
    DataSize: c_int,
    SourceId: ImGuiID,
    SourceParentId: ImGuiID,
    DataFrameCount: c_int,
    DataType: [33]u8,
    Preview: bool,
    Delivery: bool,

    pub const Clear = _ZN12ImGuiPayload5ClearEv;
    extern fn _ZN12ImGuiPayload5ClearEv(self: *ImGuiPayload) void;
    pub const IsDataType = _ZNK12ImGuiPayload10IsDataTypeEPKc;
    extern fn _ZNK12ImGuiPayload10IsDataTypeEPKc(self: *const ImGuiPayload, type: *const u8) bool;
    pub const IsPreview = _ZNK12ImGuiPayload9IsPreviewEv;
    extern fn _ZNK12ImGuiPayload9IsPreviewEv(self: *const ImGuiPayload) bool;
    pub const IsDelivery = _ZNK12ImGuiPayload10IsDeliveryEv;
    extern fn _ZNK12ImGuiPayload10IsDeliveryEv(self: *const ImGuiPayload) bool;
};

pub const ImGuiTableColumnSortSpecs = extern struct {
    ColumnUserID: ImGuiID,
    ColumnIndex: ImS16,
    SortOrder: ImS16,
    SortDirection: ImGuiSortDirection,
};

pub const ImGuiTableSortSpecs = extern struct {
    Specs: *const ImGuiTableColumnSortSpecs,
    SpecsCount: c_int,
    SpecsDirty: bool,
};

pub const ImGuiOnceUponAFrame = extern struct {
    RefFrame: c_int,
};

pub const ImGuiTextFilter = extern struct {
    pub const ImGuiTextRange = extern struct {
        b: *const u8,
        e: *const u8,

        pub const empty = _ZNK15ImGuiTextFilter14ImGuiTextRange5emptyEv;
        extern fn _ZNK15ImGuiTextFilter14ImGuiTextRange5emptyEv(self: *const ImGuiTextRange) bool;
        pub const split = _ZNK15ImGuiTextFilter14ImGuiTextRange5splitEcP8ImVectorIS0_E;
        extern fn _ZNK15ImGuiTextFilter14ImGuiTextRange5splitEcP8ImVectorIS0_E(self: *const ImGuiTextRange, separator: u8, out: *ImVector(ImGuiTextRange)) void;
    };

    InputBuf: [256]u8,
    Filters: ImVector(ImGuiTextRange),
    CountGrep: c_int,

    pub const Draw = _ZN15ImGuiTextFilter4DrawEPKcf;
    extern fn _ZN15ImGuiTextFilter4DrawEPKcf(self: *ImGuiTextFilter, label: *const u8, width: f32) bool;
    pub const PassFilter = _ZNK15ImGuiTextFilter10PassFilterEPKcS1_;
    extern fn _ZNK15ImGuiTextFilter10PassFilterEPKcS1_(self: *const ImGuiTextFilter, text: *const u8, text_end: *const u8) bool;
    pub const Build = _ZN15ImGuiTextFilter5BuildEv;
    extern fn _ZN15ImGuiTextFilter5BuildEv(self: *ImGuiTextFilter) void;
    pub const Clear = _ZN15ImGuiTextFilter5ClearEv;
    extern fn _ZN15ImGuiTextFilter5ClearEv(self: *ImGuiTextFilter) void;
    pub const IsActive = _ZNK15ImGuiTextFilter8IsActiveEv;
    extern fn _ZNK15ImGuiTextFilter8IsActiveEv(self: *const ImGuiTextFilter) bool;
};

pub const ImGuiTextBuffer = extern struct {
    Buf: ImVector(u8),

    pub const begin = _ZNK15ImGuiTextBuffer5beginEv;
    extern fn _ZNK15ImGuiTextBuffer5beginEv(self: *const ImGuiTextBuffer) *const u8;
    pub const end = _ZNK15ImGuiTextBuffer3endEv;
    extern fn _ZNK15ImGuiTextBuffer3endEv(self: *const ImGuiTextBuffer) *const u8;
    pub const size = _ZNK15ImGuiTextBuffer4sizeEv;
    extern fn _ZNK15ImGuiTextBuffer4sizeEv(self: *const ImGuiTextBuffer) c_int;
    pub const empty = _ZNK15ImGuiTextBuffer5emptyEv;
    extern fn _ZNK15ImGuiTextBuffer5emptyEv(self: *const ImGuiTextBuffer) bool;
    pub const clear = _ZN15ImGuiTextBuffer5clearEv;
    extern fn _ZN15ImGuiTextBuffer5clearEv(self: *ImGuiTextBuffer) void;
    pub const reserve = _ZN15ImGuiTextBuffer7reserveEi;
    extern fn _ZN15ImGuiTextBuffer7reserveEi(self: *ImGuiTextBuffer, capacity: c_int) void;
    pub const c_str = _ZNK15ImGuiTextBuffer5c_strEv;
    extern fn _ZNK15ImGuiTextBuffer5c_strEv(self: *const ImGuiTextBuffer) *const u8;
    pub const append = _ZN15ImGuiTextBuffer6appendEPKcS1_;
    extern fn _ZN15ImGuiTextBuffer6appendEPKcS1_(self: *ImGuiTextBuffer, str: *const u8, str_end: *const u8) void;
    pub const appendf = _ZN15ImGuiTextBuffer7appendfEPKcz;
    extern fn _ZN15ImGuiTextBuffer7appendfEPKcz(self: *ImGuiTextBuffer, fmt: *const u8) void;
    pub const appendfv = _ZN15ImGuiTextBuffer8appendfvEPKcPc;
    extern fn _ZN15ImGuiTextBuffer8appendfvEPKcPc(self: *ImGuiTextBuffer, fmt: *const u8, args: *u8) void;
};

pub const ImGuiStorage = extern struct {
    pub const ImGuiStoragePair = extern struct {
        key: ImGuiID,
    };

    Data: ImVector(ImGuiStoragePair),

    pub const Clear = _ZN12ImGuiStorage5ClearEv;
    extern fn _ZN12ImGuiStorage5ClearEv(self: *ImGuiStorage) void;
    pub const GetInt = _ZNK12ImGuiStorage6GetIntEji;
    extern fn _ZNK12ImGuiStorage6GetIntEji(self: *const ImGuiStorage, key: ImGuiID, default_val: c_int) c_int;
    pub const SetInt = _ZN12ImGuiStorage6SetIntEji;
    extern fn _ZN12ImGuiStorage6SetIntEji(self: *ImGuiStorage, key: ImGuiID, val: c_int) void;
    pub const GetBool = _ZNK12ImGuiStorage7GetBoolEjb;
    extern fn _ZNK12ImGuiStorage7GetBoolEjb(self: *const ImGuiStorage, key: ImGuiID, default_val: bool) bool;
    pub const SetBool = _ZN12ImGuiStorage7SetBoolEjb;
    extern fn _ZN12ImGuiStorage7SetBoolEjb(self: *ImGuiStorage, key: ImGuiID, val: bool) void;
    pub const GetFloat = _ZNK12ImGuiStorage8GetFloatEjf;
    extern fn _ZNK12ImGuiStorage8GetFloatEjf(self: *const ImGuiStorage, key: ImGuiID, default_val: f32) f32;
    pub const SetFloat = _ZN12ImGuiStorage8SetFloatEjf;
    extern fn _ZN12ImGuiStorage8SetFloatEjf(self: *ImGuiStorage, key: ImGuiID, val: f32) void;
    pub const GetVoidPtr = _ZNK12ImGuiStorage10GetVoidPtrEj;
    extern fn _ZNK12ImGuiStorage10GetVoidPtrEj(self: *const ImGuiStorage, key: ImGuiID) *void;
    pub const SetVoidPtr = _ZN12ImGuiStorage10SetVoidPtrEjPv;
    extern fn _ZN12ImGuiStorage10SetVoidPtrEjPv(self: *ImGuiStorage, key: ImGuiID, val: *void) void;
    pub const GetIntRef = _ZN12ImGuiStorage9GetIntRefEji;
    extern fn _ZN12ImGuiStorage9GetIntRefEji(self: *ImGuiStorage, key: ImGuiID, default_val: c_int) *c_int;
    pub const GetBoolRef = _ZN12ImGuiStorage10GetBoolRefEjb;
    extern fn _ZN12ImGuiStorage10GetBoolRefEjb(self: *ImGuiStorage, key: ImGuiID, default_val: bool) *bool;
    pub const GetFloatRef = _ZN12ImGuiStorage11GetFloatRefEjf;
    extern fn _ZN12ImGuiStorage11GetFloatRefEjf(self: *ImGuiStorage, key: ImGuiID, default_val: f32) *f32;
    pub const GetVoidPtrRef = _ZN12ImGuiStorage13GetVoidPtrRefEjPv;
    extern fn _ZN12ImGuiStorage13GetVoidPtrRefEjPv(self: *ImGuiStorage, key: ImGuiID, default_val: *void) **void;
    pub const SetAllInt = _ZN12ImGuiStorage9SetAllIntEi;
    extern fn _ZN12ImGuiStorage9SetAllIntEi(self: *ImGuiStorage, val: c_int) void;
    pub const BuildSortByKey = _ZN12ImGuiStorage14BuildSortByKeyEv;
    extern fn _ZN12ImGuiStorage14BuildSortByKeyEv(self: *ImGuiStorage) void;
};

pub const ImGuiListClipper = extern struct {
    Ctx: *ImGuiContext,
    DisplayStart: c_int,
    DisplayEnd: c_int,
    ItemsCount: c_int,
    ItemsHeight: f32,
    StartPosY: f32,
    TempData: *void,

    pub const Begin = _ZN16ImGuiListClipper5BeginEif;
    extern fn _ZN16ImGuiListClipper5BeginEif(self: *ImGuiListClipper, items_count: c_int, items_height: f32) void;
    pub const End = _ZN16ImGuiListClipper3EndEv;
    extern fn _ZN16ImGuiListClipper3EndEv(self: *ImGuiListClipper) void;
    pub const Step = _ZN16ImGuiListClipper4StepEv;
    extern fn _ZN16ImGuiListClipper4StepEv(self: *ImGuiListClipper) bool;
    pub const ForceDisplayRangeByIndices = _ZN16ImGuiListClipper26ForceDisplayRangeByIndicesEii;
    extern fn _ZN16ImGuiListClipper26ForceDisplayRangeByIndicesEii(self: *ImGuiListClipper, item_min: c_int, item_max: c_int) void;
};

pub const ImColor = extern struct {
    Value: ImVec4,

    pub const SetHSV = _ZN7ImColor6SetHSVEffff;
    extern fn _ZN7ImColor6SetHSVEffff(self: *ImColor, h: f32, s: f32, v: f32, a: f32) void;
    pub const HSV = _ZN7ImColor3HSVEffff;
    extern fn _ZN7ImColor3HSVEffff(self: *ImColor, h: f32, s: f32, v: f32, a: f32) ImColor;
};

pub const ImDrawCallback = *const fn (
    *const ImDrawList,
) void;
pub const ImDrawCmd = extern struct {
    ClipRect: ImVec4,
    TextureId: ImTextureID,
    VtxOffset: c_uint,
    IdxOffset: c_uint,
    ElemCount: c_uint,
    UserCallback: ImDrawCallback,
    UserCallbackData: *void,

    pub const GetTexID = _ZNK9ImDrawCmd8GetTexIDEv;
    extern fn _ZNK9ImDrawCmd8GetTexIDEv(self: *const ImDrawCmd) ImTextureID;
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

    pub const Clear = _ZN18ImDrawListSplitter5ClearEv;
    extern fn _ZN18ImDrawListSplitter5ClearEv(self: *ImDrawListSplitter) void;
    pub const ClearFreeMemory = _ZN18ImDrawListSplitter15ClearFreeMemoryEv;
    extern fn _ZN18ImDrawListSplitter15ClearFreeMemoryEv(self: *ImDrawListSplitter) void;
    pub const Split = _ZN18ImDrawListSplitter5SplitEP10ImDrawListi;
    extern fn _ZN18ImDrawListSplitter5SplitEP10ImDrawListi(self: *ImDrawListSplitter, draw_list: *ImDrawList, count: c_int) void;
    pub const Merge = _ZN18ImDrawListSplitter5MergeEP10ImDrawList;
    extern fn _ZN18ImDrawListSplitter5MergeEP10ImDrawList(self: *ImDrawListSplitter, draw_list: *ImDrawList) void;
    pub const SetCurrentChannel = _ZN18ImDrawListSplitter17SetCurrentChannelEP10ImDrawListi;
    extern fn _ZN18ImDrawListSplitter17SetCurrentChannelEP10ImDrawListi(self: *ImDrawListSplitter, draw_list: *ImDrawList, channel_idx: c_int) void;
};

pub const ImDrawFlags_ = enum {
    None,
    Closed,
    RoundCornersTopLeft,
    RoundCornersTopRight,
    RoundCornersBottomLeft,
    RoundCornersBottomRight,
    RoundCornersNone,
    RoundCornersTop,
    RoundCornersBottom,
    RoundCornersLeft,
    RoundCornersRight,
    RoundCornersAll,
    RoundCornersDefault_,
    RoundCornersMask_,
};

pub const ImDrawListFlags_ = enum {
    None,
    AntiAliasedLines,
    AntiAliasedLinesUseTex,
    AntiAliasedFill,
    AllowVtxOffset,
};

pub const ImDrawList = extern struct {
    CmdBuffer: ImVector(ImDrawCmd),
    IdxBuffer: ImVector(ImDrawIdx),
    VtxBuffer: ImVector(ImDrawVert),
    Flags: ImDrawListFlags,
    _VtxCurrentIdx: c_uint,
    _Data: *ImDrawListSharedData,
    _OwnerName: *const u8,
    _VtxWritePtr: *ImDrawVert,
    _IdxWritePtr: *ImDrawIdx,
    _ClipRectStack: ImVector(ImVec4),
    _TextureIdStack: ImVector(ImTextureID),
    _Path: ImVector(ImVec2),
    _CmdHeader: ImDrawCmdHeader,
    _Splitter: ImDrawListSplitter,
    _FringeScale: f32,

    pub const PushClipRect = _ZN10ImDrawList12PushClipRectERK6ImVec2S2_b;
    extern fn _ZN10ImDrawList12PushClipRectERK6ImVec2S2_b(self: *ImDrawList, clip_rect_min: *const ImVec2, clip_rect_max: *const ImVec2, intersect_with_current_clip_rect: bool) void;
    pub const PushClipRectFullScreen = _ZN10ImDrawList22PushClipRectFullScreenEv;
    extern fn _ZN10ImDrawList22PushClipRectFullScreenEv(self: *ImDrawList) void;
    pub const PopClipRect = _ZN10ImDrawList11PopClipRectEv;
    extern fn _ZN10ImDrawList11PopClipRectEv(self: *ImDrawList) void;
    pub const PushTextureID = _ZN10ImDrawList13PushTextureIDEPv;
    extern fn _ZN10ImDrawList13PushTextureIDEPv(self: *ImDrawList, texture_id: ImTextureID) void;
    pub const PopTextureID = _ZN10ImDrawList12PopTextureIDEv;
    extern fn _ZN10ImDrawList12PopTextureIDEv(self: *ImDrawList) void;
    pub const GetClipRectMin = _ZNK10ImDrawList14GetClipRectMinEv;
    extern fn _ZNK10ImDrawList14GetClipRectMinEv(self: *const ImDrawList) ImVec2;
    pub const GetClipRectMax = _ZNK10ImDrawList14GetClipRectMaxEv;
    extern fn _ZNK10ImDrawList14GetClipRectMaxEv(self: *const ImDrawList) ImVec2;
    pub const AddLine = _ZN10ImDrawList7AddLineERK6ImVec2S2_jf;
    extern fn _ZN10ImDrawList7AddLineERK6ImVec2S2_jf(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, col: ImU32, thickness: f32) void;
    pub const AddRect = _ZN10ImDrawList7AddRectERK6ImVec2S2_jfif;
    extern fn _ZN10ImDrawList7AddRectERK6ImVec2S2_jfif(self: *ImDrawList, p_min: *const ImVec2, p_max: *const ImVec2, col: ImU32, rounding: f32, flags: ImDrawFlags, thickness: f32) void;
    pub const AddRectFilled = _ZN10ImDrawList13AddRectFilledERK6ImVec2S2_jfi;
    extern fn _ZN10ImDrawList13AddRectFilledERK6ImVec2S2_jfi(self: *ImDrawList, p_min: *const ImVec2, p_max: *const ImVec2, col: ImU32, rounding: f32, flags: ImDrawFlags) void;
    pub const AddRectFilledMultiColor = _ZN10ImDrawList23AddRectFilledMultiColorERK6ImVec2S2_jjjj;
    extern fn _ZN10ImDrawList23AddRectFilledMultiColorERK6ImVec2S2_jjjj(self: *ImDrawList, p_min: *const ImVec2, p_max: *const ImVec2, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32) void;
    pub const AddQuad = _ZN10ImDrawList7AddQuadERK6ImVec2S2_S2_S2_jf;
    extern fn _ZN10ImDrawList7AddQuadERK6ImVec2S2_S2_S2_jf(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, p4: *const ImVec2, col: ImU32, thickness: f32) void;
    pub const AddQuadFilled = _ZN10ImDrawList13AddQuadFilledERK6ImVec2S2_S2_S2_j;
    extern fn _ZN10ImDrawList13AddQuadFilledERK6ImVec2S2_S2_S2_j(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, p4: *const ImVec2, col: ImU32) void;
    pub const AddTriangle = _ZN10ImDrawList11AddTriangleERK6ImVec2S2_S2_jf;
    extern fn _ZN10ImDrawList11AddTriangleERK6ImVec2S2_S2_jf(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, col: ImU32, thickness: f32) void;
    pub const AddTriangleFilled = _ZN10ImDrawList17AddTriangleFilledERK6ImVec2S2_S2_j;
    extern fn _ZN10ImDrawList17AddTriangleFilledERK6ImVec2S2_S2_j(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, col: ImU32) void;
    pub const AddCircle = _ZN10ImDrawList9AddCircleERK6ImVec2fjif;
    extern fn _ZN10ImDrawList9AddCircleERK6ImVec2fjif(self: *ImDrawList, center: *const ImVec2, radius: f32, col: ImU32, num_segments: c_int, thickness: f32) void;
    pub const AddCircleFilled = _ZN10ImDrawList15AddCircleFilledERK6ImVec2fji;
    extern fn _ZN10ImDrawList15AddCircleFilledERK6ImVec2fji(self: *ImDrawList, center: *const ImVec2, radius: f32, col: ImU32, num_segments: c_int) void;
    pub const AddNgon = _ZN10ImDrawList7AddNgonERK6ImVec2fjif;
    extern fn _ZN10ImDrawList7AddNgonERK6ImVec2fjif(self: *ImDrawList, center: *const ImVec2, radius: f32, col: ImU32, num_segments: c_int, thickness: f32) void;
    pub const AddNgonFilled = _ZN10ImDrawList13AddNgonFilledERK6ImVec2fji;
    extern fn _ZN10ImDrawList13AddNgonFilledERK6ImVec2fji(self: *ImDrawList, center: *const ImVec2, radius: f32, col: ImU32, num_segments: c_int) void;
    pub const AddText = _ZN10ImDrawList7AddTextERK6ImVec2jPKcS4_;
    extern fn _ZN10ImDrawList7AddTextERK6ImVec2jPKcS4_(self: *ImDrawList, pos: *const ImVec2, col: ImU32, text_begin: *const u8, text_end: *const u8) void;
    pub const AddTextWithArgs = _ZN10ImDrawList7AddTextEPK6ImFontfRK6ImVec2jPKcS7_fPK6ImVec4;
    extern fn _ZN10ImDrawList7AddTextEPK6ImFontfRK6ImVec2jPKcS7_fPK6ImVec4(self: *ImDrawList, font: *const ImFont, font_size: f32, pos: *const ImVec2, col: ImU32, text_begin: *const u8, text_end: *const u8, wrap_width: f32, cpu_fine_clip_rect: *const ImVec4) void;
    pub const AddPolyline = _ZN10ImDrawList11AddPolylineEPK6ImVec2ijif;
    extern fn _ZN10ImDrawList11AddPolylineEPK6ImVec2ijif(self: *ImDrawList, points: *const ImVec2, num_points: c_int, col: ImU32, flags: ImDrawFlags, thickness: f32) void;
    pub const AddConvexPolyFilled = _ZN10ImDrawList19AddConvexPolyFilledEPK6ImVec2ij;
    extern fn _ZN10ImDrawList19AddConvexPolyFilledEPK6ImVec2ij(self: *ImDrawList, points: *const ImVec2, num_points: c_int, col: ImU32) void;
    pub const AddBezierCubic = _ZN10ImDrawList14AddBezierCubicERK6ImVec2S2_S2_S2_jfi;
    extern fn _ZN10ImDrawList14AddBezierCubicERK6ImVec2S2_S2_S2_jfi(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, p4: *const ImVec2, col: ImU32, thickness: f32, num_segments: c_int) void;
    pub const AddBezierQuadratic = _ZN10ImDrawList18AddBezierQuadraticERK6ImVec2S2_S2_jfi;
    extern fn _ZN10ImDrawList18AddBezierQuadraticERK6ImVec2S2_S2_jfi(self: *ImDrawList, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, col: ImU32, thickness: f32, num_segments: c_int) void;
    pub const AddImage = _ZN10ImDrawList8AddImageEPvRK6ImVec2S3_S3_S3_j;
    extern fn _ZN10ImDrawList8AddImageEPvRK6ImVec2S3_S3_S3_j(self: *ImDrawList, user_texture_id: ImTextureID, p_min: *const ImVec2, p_max: *const ImVec2, uv_min: *const ImVec2, uv_max: *const ImVec2, col: ImU32) void;
    pub const AddImageQuad = _ZN10ImDrawList12AddImageQuadEPvRK6ImVec2S3_S3_S3_S3_S3_S3_S3_j;
    extern fn _ZN10ImDrawList12AddImageQuadEPvRK6ImVec2S3_S3_S3_S3_S3_S3_S3_j(self: *ImDrawList, user_texture_id: ImTextureID, p1: *const ImVec2, p2: *const ImVec2, p3: *const ImVec2, p4: *const ImVec2, uv1: *const ImVec2, uv2: *const ImVec2, uv3: *const ImVec2, uv4: *const ImVec2, col: ImU32) void;
    pub const AddImageRounded = _ZN10ImDrawList15AddImageRoundedEPvRK6ImVec2S3_S3_S3_jfi;
    extern fn _ZN10ImDrawList15AddImageRoundedEPvRK6ImVec2S3_S3_S3_jfi(self: *ImDrawList, user_texture_id: ImTextureID, p_min: *const ImVec2, p_max: *const ImVec2, uv_min: *const ImVec2, uv_max: *const ImVec2, col: ImU32, rounding: f32, flags: ImDrawFlags) void;
    pub const PathClear = _ZN10ImDrawList9PathClearEv;
    extern fn _ZN10ImDrawList9PathClearEv(self: *ImDrawList) void;
    pub const PathLineTo = _ZN10ImDrawList10PathLineToERK6ImVec2;
    extern fn _ZN10ImDrawList10PathLineToERK6ImVec2(self: *ImDrawList, pos: *const ImVec2) void;
    pub const PathLineToMergeDuplicate = _ZN10ImDrawList24PathLineToMergeDuplicateERK6ImVec2;
    extern fn _ZN10ImDrawList24PathLineToMergeDuplicateERK6ImVec2(self: *ImDrawList, pos: *const ImVec2) void;
    pub const PathFillConvex = _ZN10ImDrawList14PathFillConvexEj;
    extern fn _ZN10ImDrawList14PathFillConvexEj(self: *ImDrawList, col: ImU32) void;
    pub const PathStroke = _ZN10ImDrawList10PathStrokeEjif;
    extern fn _ZN10ImDrawList10PathStrokeEjif(self: *ImDrawList, col: ImU32, flags: ImDrawFlags, thickness: f32) void;
    pub const PathArcTo = _ZN10ImDrawList9PathArcToERK6ImVec2fffi;
    extern fn _ZN10ImDrawList9PathArcToERK6ImVec2fffi(self: *ImDrawList, center: *const ImVec2, radius: f32, a_min: f32, a_max: f32, num_segments: c_int) void;
    pub const PathArcToFast = _ZN10ImDrawList13PathArcToFastERK6ImVec2fii;
    extern fn _ZN10ImDrawList13PathArcToFastERK6ImVec2fii(self: *ImDrawList, center: *const ImVec2, radius: f32, a_min_of_12: c_int, a_max_of_12: c_int) void;
    pub const PathBezierCubicCurveTo = _ZN10ImDrawList22PathBezierCubicCurveToERK6ImVec2S2_S2_i;
    extern fn _ZN10ImDrawList22PathBezierCubicCurveToERK6ImVec2S2_S2_i(self: *ImDrawList, p2: *const ImVec2, p3: *const ImVec2, p4: *const ImVec2, num_segments: c_int) void;
    pub const PathBezierQuadraticCurveTo = _ZN10ImDrawList26PathBezierQuadraticCurveToERK6ImVec2S2_i;
    extern fn _ZN10ImDrawList26PathBezierQuadraticCurveToERK6ImVec2S2_i(self: *ImDrawList, p2: *const ImVec2, p3: *const ImVec2, num_segments: c_int) void;
    pub const PathRect = _ZN10ImDrawList8PathRectERK6ImVec2S2_fi;
    extern fn _ZN10ImDrawList8PathRectERK6ImVec2S2_fi(self: *ImDrawList, rect_min: *const ImVec2, rect_max: *const ImVec2, rounding: f32, flags: ImDrawFlags) void;
    pub const AddCallback = _ZN10ImDrawList11AddCallbackEPFvPKS_PK9ImDrawCmdEPv;
    extern fn _ZN10ImDrawList11AddCallbackEPFvPKS_PK9ImDrawCmdEPv(self: *ImDrawList, callback: ImDrawCallback, callback_data: *void) void;
    pub const AddDrawCmd = _ZN10ImDrawList10AddDrawCmdEv;
    extern fn _ZN10ImDrawList10AddDrawCmdEv(self: *ImDrawList) void;
    pub const CloneOutput = _ZNK10ImDrawList11CloneOutputEv;
    extern fn _ZNK10ImDrawList11CloneOutputEv(self: *const ImDrawList) *ImDrawList;
    pub const ChannelsSplit = _ZN10ImDrawList13ChannelsSplitEi;
    extern fn _ZN10ImDrawList13ChannelsSplitEi(self: *ImDrawList, count: c_int) void;
    pub const ChannelsMerge = _ZN10ImDrawList13ChannelsMergeEv;
    extern fn _ZN10ImDrawList13ChannelsMergeEv(self: *ImDrawList) void;
    pub const ChannelsSetCurrent = _ZN10ImDrawList18ChannelsSetCurrentEi;
    extern fn _ZN10ImDrawList18ChannelsSetCurrentEi(self: *ImDrawList, n: c_int) void;
    pub const PrimReserve = _ZN10ImDrawList11PrimReserveEii;
    extern fn _ZN10ImDrawList11PrimReserveEii(self: *ImDrawList, idx_count: c_int, vtx_count: c_int) void;
    pub const PrimUnreserve = _ZN10ImDrawList13PrimUnreserveEii;
    extern fn _ZN10ImDrawList13PrimUnreserveEii(self: *ImDrawList, idx_count: c_int, vtx_count: c_int) void;
    pub const PrimRect = _ZN10ImDrawList8PrimRectERK6ImVec2S2_j;
    extern fn _ZN10ImDrawList8PrimRectERK6ImVec2S2_j(self: *ImDrawList, a: *const ImVec2, b: *const ImVec2, col: ImU32) void;
    pub const PrimRectUV = _ZN10ImDrawList10PrimRectUVERK6ImVec2S2_S2_S2_j;
    extern fn _ZN10ImDrawList10PrimRectUVERK6ImVec2S2_S2_S2_j(self: *ImDrawList, a: *const ImVec2, b: *const ImVec2, uv_a: *const ImVec2, uv_b: *const ImVec2, col: ImU32) void;
    pub const PrimQuadUV = _ZN10ImDrawList10PrimQuadUVERK6ImVec2S2_S2_S2_S2_S2_S2_S2_j;
    extern fn _ZN10ImDrawList10PrimQuadUVERK6ImVec2S2_S2_S2_S2_S2_S2_S2_j(self: *ImDrawList, a: *const ImVec2, b: *const ImVec2, c: *const ImVec2, d: *const ImVec2, uv_a: *const ImVec2, uv_b: *const ImVec2, uv_c: *const ImVec2, uv_d: *const ImVec2, col: ImU32) void;
    pub const PrimWriteVtx = _ZN10ImDrawList12PrimWriteVtxERK6ImVec2S2_j;
    extern fn _ZN10ImDrawList12PrimWriteVtxERK6ImVec2S2_j(self: *ImDrawList, pos: *const ImVec2, uv: *const ImVec2, col: ImU32) void;
    pub const PrimWriteIdx = _ZN10ImDrawList12PrimWriteIdxEt;
    extern fn _ZN10ImDrawList12PrimWriteIdxEt(self: *ImDrawList, idx: ImDrawIdx) void;
    pub const PrimVtx = _ZN10ImDrawList7PrimVtxERK6ImVec2S2_j;
    extern fn _ZN10ImDrawList7PrimVtxERK6ImVec2S2_j(self: *ImDrawList, pos: *const ImVec2, uv: *const ImVec2, col: ImU32) void;
    pub const _ResetForNewFrame = _ZN10ImDrawList17_ResetForNewFrameEv;
    extern fn _ZN10ImDrawList17_ResetForNewFrameEv(self: *ImDrawList) void;
    pub const _ClearFreeMemory = _ZN10ImDrawList16_ClearFreeMemoryEv;
    extern fn _ZN10ImDrawList16_ClearFreeMemoryEv(self: *ImDrawList) void;
    pub const _PopUnusedDrawCmd = _ZN10ImDrawList17_PopUnusedDrawCmdEv;
    extern fn _ZN10ImDrawList17_PopUnusedDrawCmdEv(self: *ImDrawList) void;
    pub const _TryMergeDrawCmds = _ZN10ImDrawList17_TryMergeDrawCmdsEv;
    extern fn _ZN10ImDrawList17_TryMergeDrawCmdsEv(self: *ImDrawList) void;
    pub const _OnChangedClipRect = _ZN10ImDrawList18_OnChangedClipRectEv;
    extern fn _ZN10ImDrawList18_OnChangedClipRectEv(self: *ImDrawList) void;
    pub const _OnChangedTextureID = _ZN10ImDrawList19_OnChangedTextureIDEv;
    extern fn _ZN10ImDrawList19_OnChangedTextureIDEv(self: *ImDrawList) void;
    pub const _OnChangedVtxOffset = _ZN10ImDrawList19_OnChangedVtxOffsetEv;
    extern fn _ZN10ImDrawList19_OnChangedVtxOffsetEv(self: *ImDrawList) void;
    pub const _CalcCircleAutoSegmentCount = _ZNK10ImDrawList27_CalcCircleAutoSegmentCountEf;
    extern fn _ZNK10ImDrawList27_CalcCircleAutoSegmentCountEf(self: *const ImDrawList, radius: f32) c_int;
    pub const _PathArcToFastEx = _ZN10ImDrawList16_PathArcToFastExERK6ImVec2fiii;
    extern fn _ZN10ImDrawList16_PathArcToFastExERK6ImVec2fiii(self: *ImDrawList, center: *const ImVec2, radius: f32, a_min_sample: c_int, a_max_sample: c_int, a_step: c_int) void;
    pub const _PathArcToN = _ZN10ImDrawList11_PathArcToNERK6ImVec2fffi;
    extern fn _ZN10ImDrawList11_PathArcToNERK6ImVec2fffi(self: *ImDrawList, center: *const ImVec2, radius: f32, a_min: f32, a_max: f32, num_segments: c_int) void;
};

pub const ImDrawData = extern struct {
    Valid: bool,
    CmdListsCount: c_int,
    TotalIdxCount: c_int,
    TotalVtxCount: c_int,
    CmdLists: **ImDrawList,
    DisplayPos: ImVec2,
    DisplaySize: ImVec2,
    FramebufferScale: ImVec2,
    OwnerViewport: *ImGuiViewport,

    pub const Clear = _ZN10ImDrawData5ClearEv;
    extern fn _ZN10ImDrawData5ClearEv(self: *ImDrawData) void;
    pub const DeIndexAllBuffers = _ZN10ImDrawData17DeIndexAllBuffersEv;
    extern fn _ZN10ImDrawData17DeIndexAllBuffersEv(self: *ImDrawData) void;
    pub const ScaleClipRects = _ZN10ImDrawData14ScaleClipRectsERK6ImVec2;
    extern fn _ZN10ImDrawData14ScaleClipRectsERK6ImVec2(self: *ImDrawData, fb_scale: *const ImVec2) void;
};

pub const ImFontConfig = extern struct {
    FontData: *void,
    FontDataSize: c_int,
    FontDataOwnedByAtlas: bool,
    FontNo: c_int,
    SizePixels: f32,
    OversampleH: c_int,
    OversampleV: c_int,
    PixelSnapH: bool,
    GlyphExtraSpacing: ImVec2,
    GlyphOffset: ImVec2,
    GlyphRanges: *const ImWchar,
    GlyphMinAdvanceX: f32,
    GlyphMaxAdvanceX: f32,
    MergeMode: bool,
    FontBuilderFlags: c_uint,
    RasterizerMultiply: f32,
    EllipsisChar: ImWchar,
    Name: [40]u8,
    DstFont: *ImFont,
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

    pub const Clear = _ZN24ImFontGlyphRangesBuilder5ClearEv;
    extern fn _ZN24ImFontGlyphRangesBuilder5ClearEv(self: *ImFontGlyphRangesBuilder) void;
    pub const GetBit = _ZNK24ImFontGlyphRangesBuilder6GetBitEy;
    extern fn _ZNK24ImFontGlyphRangesBuilder6GetBitEy(self: *const ImFontGlyphRangesBuilder, n: usize) bool;
    pub const SetBit = _ZN24ImFontGlyphRangesBuilder6SetBitEy;
    extern fn _ZN24ImFontGlyphRangesBuilder6SetBitEy(self: *ImFontGlyphRangesBuilder, n: usize) void;
    pub const AddChar = _ZN24ImFontGlyphRangesBuilder7AddCharEt;
    extern fn _ZN24ImFontGlyphRangesBuilder7AddCharEt(self: *ImFontGlyphRangesBuilder, c: ImWchar) void;
    pub const AddText = _ZN24ImFontGlyphRangesBuilder7AddTextEPKcS1_;
    extern fn _ZN24ImFontGlyphRangesBuilder7AddTextEPKcS1_(self: *ImFontGlyphRangesBuilder, text: *const u8, text_end: *const u8) void;
    pub const AddRanges = _ZN24ImFontGlyphRangesBuilder9AddRangesEPKt;
    extern fn _ZN24ImFontGlyphRangesBuilder9AddRangesEPKt(self: *ImFontGlyphRangesBuilder, ranges: *const ImWchar) void;
    pub const BuildRanges = _ZN24ImFontGlyphRangesBuilder11BuildRangesEP8ImVectorItE;
    extern fn _ZN24ImFontGlyphRangesBuilder11BuildRangesEP8ImVectorItE(self: *ImFontGlyphRangesBuilder, out_ranges: *ImVector(ImWchar)) void;
};

pub const ImFontAtlasCustomRect = extern struct {
    Width: c_ushort,
    Height: c_ushort,
    X: c_ushort,
    Y: c_ushort,
    GlyphID: c_uint,
    GlyphAdvanceX: f32,
    GlyphOffset: ImVec2,
    Font: *ImFont,

    pub const IsPacked = _ZNK21ImFontAtlasCustomRect8IsPackedEv;
    extern fn _ZNK21ImFontAtlasCustomRect8IsPackedEv(self: *const ImFontAtlasCustomRect) bool;
};

pub const ImFontAtlasFlags_ = enum {
    None,
    NoPowerOfTwoHeight,
    NoMouseCursors,
    NoBakedLines,
};

pub const ImFontAtlas = extern struct {
    Flags: ImFontAtlasFlags,
    TexID: ImTextureID,
    TexDesiredWidth: c_int,
    TexGlyphPadding: c_int,
    Locked: bool,
    UserData: *void,
    TexReady: bool,
    TexPixelsUseColors: bool,
    TexPixelsAlpha8: *u8,
    TexPixelsRGBA32: *c_uint,
    TexWidth: c_int,
    TexHeight: c_int,
    TexUvScale: ImVec2,
    TexUvWhitePixel: ImVec2,
    Fonts: ImVector(*ImFont),
    CustomRects: ImVector(ImFontAtlasCustomRect),
    ConfigData: ImVector(ImFontConfig),
    TexUvLines: [64]ImVec4,
    FontBuilderIO: *const ImFontBuilderIO,
    FontBuilderFlags: c_uint,
    PackIdMouseCursors: c_int,
    PackIdLines: c_int,

    pub const AddFont = _ZN11ImFontAtlas7AddFontEPK12ImFontConfig;
    extern fn _ZN11ImFontAtlas7AddFontEPK12ImFontConfig(self: *ImFontAtlas, font_cfg: *const ImFontConfig) *ImFont;
    pub const AddFontDefault = _ZN11ImFontAtlas14AddFontDefaultEPK12ImFontConfig;
    extern fn _ZN11ImFontAtlas14AddFontDefaultEPK12ImFontConfig(self: *ImFontAtlas, font_cfg: *const ImFontConfig) *ImFont;
    pub const AddFontFromFileTTF = _ZN11ImFontAtlas18AddFontFromFileTTFEPKcfPK12ImFontConfigPKt;
    extern fn _ZN11ImFontAtlas18AddFontFromFileTTFEPKcfPK12ImFontConfigPKt(self: *ImFontAtlas, filename: *const u8, size_pixels: f32, font_cfg: *const ImFontConfig, glyph_ranges: *const ImWchar) *ImFont;
    pub const AddFontFromMemoryTTF = _ZN11ImFontAtlas20AddFontFromMemoryTTFEPvifPK12ImFontConfigPKt;
    extern fn _ZN11ImFontAtlas20AddFontFromMemoryTTFEPvifPK12ImFontConfigPKt(self: *ImFontAtlas, font_data: *void, font_size: c_int, size_pixels: f32, font_cfg: *const ImFontConfig, glyph_ranges: *const ImWchar) *ImFont;
    pub const AddFontFromMemoryCompressedTTF = _ZN11ImFontAtlas30AddFontFromMemoryCompressedTTFEPKvifPK12ImFontConfigPKt;
    extern fn _ZN11ImFontAtlas30AddFontFromMemoryCompressedTTFEPKvifPK12ImFontConfigPKt(self: *ImFontAtlas, compressed_font_data: *const void, compressed_font_size: c_int, size_pixels: f32, font_cfg: *const ImFontConfig, glyph_ranges: *const ImWchar) *ImFont;
    pub const AddFontFromMemoryCompressedBase85TTF = _ZN11ImFontAtlas36AddFontFromMemoryCompressedBase85TTFEPKcfPK12ImFontConfigPKt;
    extern fn _ZN11ImFontAtlas36AddFontFromMemoryCompressedBase85TTFEPKcfPK12ImFontConfigPKt(self: *ImFontAtlas, compressed_font_data_base85: *const u8, size_pixels: f32, font_cfg: *const ImFontConfig, glyph_ranges: *const ImWchar) *ImFont;
    pub const ClearInputData = _ZN11ImFontAtlas14ClearInputDataEv;
    extern fn _ZN11ImFontAtlas14ClearInputDataEv(self: *ImFontAtlas) void;
    pub const ClearTexData = _ZN11ImFontAtlas12ClearTexDataEv;
    extern fn _ZN11ImFontAtlas12ClearTexDataEv(self: *ImFontAtlas) void;
    pub const ClearFonts = _ZN11ImFontAtlas10ClearFontsEv;
    extern fn _ZN11ImFontAtlas10ClearFontsEv(self: *ImFontAtlas) void;
    pub const Clear = _ZN11ImFontAtlas5ClearEv;
    extern fn _ZN11ImFontAtlas5ClearEv(self: *ImFontAtlas) void;
    pub const Build = _ZN11ImFontAtlas5BuildEv;
    extern fn _ZN11ImFontAtlas5BuildEv(self: *ImFontAtlas) bool;
    pub const GetTexDataAsAlpha8 = _ZN11ImFontAtlas18GetTexDataAsAlpha8EPPhPiS2_S2_;
    extern fn _ZN11ImFontAtlas18GetTexDataAsAlpha8EPPhPiS2_S2_(self: *ImFontAtlas, out_pixels: **u8, out_width: *c_int, out_height: *c_int, out_bytes_per_pixel: *c_int) void;
    pub const GetTexDataAsRGBA32 = _ZN11ImFontAtlas18GetTexDataAsRGBA32EPPhPiS2_S2_;
    extern fn _ZN11ImFontAtlas18GetTexDataAsRGBA32EPPhPiS2_S2_(self: *ImFontAtlas, out_pixels: **u8, out_width: *c_int, out_height: *c_int, out_bytes_per_pixel: *c_int) void;
    pub const IsBuilt = _ZNK11ImFontAtlas7IsBuiltEv;
    extern fn _ZNK11ImFontAtlas7IsBuiltEv(self: *const ImFontAtlas) bool;
    pub const SetTexID = _ZN11ImFontAtlas8SetTexIDEPv;
    extern fn _ZN11ImFontAtlas8SetTexIDEPv(self: *ImFontAtlas, id: ImTextureID) void;
    pub const GetGlyphRangesDefault = _ZN11ImFontAtlas21GetGlyphRangesDefaultEv;
    extern fn _ZN11ImFontAtlas21GetGlyphRangesDefaultEv(self: *ImFontAtlas) *const ImWchar;
    pub const GetGlyphRangesGreek = _ZN11ImFontAtlas19GetGlyphRangesGreekEv;
    extern fn _ZN11ImFontAtlas19GetGlyphRangesGreekEv(self: *ImFontAtlas) *const ImWchar;
    pub const GetGlyphRangesKorean = _ZN11ImFontAtlas20GetGlyphRangesKoreanEv;
    extern fn _ZN11ImFontAtlas20GetGlyphRangesKoreanEv(self: *ImFontAtlas) *const ImWchar;
    pub const GetGlyphRangesJapanese = _ZN11ImFontAtlas22GetGlyphRangesJapaneseEv;
    extern fn _ZN11ImFontAtlas22GetGlyphRangesJapaneseEv(self: *ImFontAtlas) *const ImWchar;
    pub const GetGlyphRangesChineseFull = _ZN11ImFontAtlas25GetGlyphRangesChineseFullEv;
    extern fn _ZN11ImFontAtlas25GetGlyphRangesChineseFullEv(self: *ImFontAtlas) *const ImWchar;
    pub const GetGlyphRangesChineseSimplifiedCommon = _ZN11ImFontAtlas37GetGlyphRangesChineseSimplifiedCommonEv;
    extern fn _ZN11ImFontAtlas37GetGlyphRangesChineseSimplifiedCommonEv(self: *ImFontAtlas) *const ImWchar;
    pub const GetGlyphRangesCyrillic = _ZN11ImFontAtlas22GetGlyphRangesCyrillicEv;
    extern fn _ZN11ImFontAtlas22GetGlyphRangesCyrillicEv(self: *ImFontAtlas) *const ImWchar;
    pub const GetGlyphRangesThai = _ZN11ImFontAtlas18GetGlyphRangesThaiEv;
    extern fn _ZN11ImFontAtlas18GetGlyphRangesThaiEv(self: *ImFontAtlas) *const ImWchar;
    pub const GetGlyphRangesVietnamese = _ZN11ImFontAtlas24GetGlyphRangesVietnameseEv;
    extern fn _ZN11ImFontAtlas24GetGlyphRangesVietnameseEv(self: *ImFontAtlas) *const ImWchar;
    pub const AddCustomRectRegular = _ZN11ImFontAtlas20AddCustomRectRegularEii;
    extern fn _ZN11ImFontAtlas20AddCustomRectRegularEii(self: *ImFontAtlas, width: c_int, height: c_int) c_int;
    pub const AddCustomRectFontGlyph = _ZN11ImFontAtlas22AddCustomRectFontGlyphEP6ImFonttiifRK6ImVec2;
    extern fn _ZN11ImFontAtlas22AddCustomRectFontGlyphEP6ImFonttiifRK6ImVec2(self: *ImFontAtlas, font: *ImFont, id: ImWchar, width: c_int, height: c_int, advance_x: f32, offset: *const ImVec2) c_int;
    pub const GetCustomRectByIndex = _ZN11ImFontAtlas20GetCustomRectByIndexEi;
    extern fn _ZN11ImFontAtlas20GetCustomRectByIndexEi(self: *ImFontAtlas, index: c_int) *ImFontAtlasCustomRect;
    pub const CalcCustomRectUV = _ZNK11ImFontAtlas16CalcCustomRectUVEPK21ImFontAtlasCustomRectP6ImVec2S4_;
    extern fn _ZNK11ImFontAtlas16CalcCustomRectUVEPK21ImFontAtlasCustomRectP6ImVec2S4_(self: *const ImFontAtlas, rect: *const ImFontAtlasCustomRect, out_uv_min: *ImVec2, out_uv_max: *ImVec2) void;
    pub const GetMouseCursorTexData = _ZN11ImFontAtlas21GetMouseCursorTexDataEiP6ImVec2S1_S1_S1_;
    extern fn _ZN11ImFontAtlas21GetMouseCursorTexDataEiP6ImVec2S1_S1_S1_(self: *ImFontAtlas, cursor: ImGuiMouseCursor, out_offset: *ImVec2, out_size: *ImVec2, out_uv_border: *ImVec2, out_uv_fill: *ImVec2) bool;
};

pub const ImFont = extern struct {
    IndexAdvanceX: ImVector(f32),
    FallbackAdvanceX: f32,
    FontSize: f32,
    IndexLookup: ImVector(ImWchar),
    Glyphs: ImVector(ImFontGlyph),
    FallbackGlyph: *const ImFontGlyph,
    ContainerAtlas: *ImFontAtlas,
    ConfigData: *const ImFontConfig,
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

    pub const FindGlyph = _ZNK6ImFont9FindGlyphEt;
    extern fn _ZNK6ImFont9FindGlyphEt(self: *const ImFont, c: ImWchar) *const ImFontGlyph;
    pub const FindGlyphNoFallback = _ZNK6ImFont19FindGlyphNoFallbackEt;
    extern fn _ZNK6ImFont19FindGlyphNoFallbackEt(self: *const ImFont, c: ImWchar) *const ImFontGlyph;
    pub const GetCharAdvance = _ZNK6ImFont14GetCharAdvanceEt;
    extern fn _ZNK6ImFont14GetCharAdvanceEt(self: *const ImFont, c: ImWchar) f32;
    pub const IsLoaded = _ZNK6ImFont8IsLoadedEv;
    extern fn _ZNK6ImFont8IsLoadedEv(self: *const ImFont) bool;
    pub const GetDebugName = _ZNK6ImFont12GetDebugNameEv;
    extern fn _ZNK6ImFont12GetDebugNameEv(self: *const ImFont) *const u8;
    pub const CalcTextSizeA = _ZNK6ImFont13CalcTextSizeAEfffPKcS1_PS1_;
    extern fn _ZNK6ImFont13CalcTextSizeAEfffPKcS1_PS1_(self: *const ImFont, size: f32, max_width: f32, wrap_width: f32, text_begin: *const u8, text_end: *const u8, remaining: *const *u8) ImVec2;
    pub const CalcWordWrapPositionA = _ZNK6ImFont21CalcWordWrapPositionAEfPKcS1_f;
    extern fn _ZNK6ImFont21CalcWordWrapPositionAEfPKcS1_f(self: *const ImFont, scale: f32, text: *const u8, text_end: *const u8, wrap_width: f32) *const u8;
    pub const RenderChar = _ZNK6ImFont10RenderCharEP10ImDrawListfRK6ImVec2jt;
    extern fn _ZNK6ImFont10RenderCharEP10ImDrawListfRK6ImVec2jt(self: *const ImFont, draw_list: *ImDrawList, size: f32, pos: *const ImVec2, col: ImU32, c: ImWchar) void;
    pub const RenderText = _ZNK6ImFont10RenderTextEP10ImDrawListfRK6ImVec2jRK6ImVec4PKcS9_fb;
    extern fn _ZNK6ImFont10RenderTextEP10ImDrawListfRK6ImVec2jRK6ImVec4PKcS9_fb(self: *const ImFont, draw_list: *ImDrawList, size: f32, pos: *const ImVec2, col: ImU32, clip_rect: *const ImVec4, text_begin: *const u8, text_end: *const u8, wrap_width: f32, cpu_fine_clip: bool) void;
    pub const BuildLookupTable = _ZN6ImFont16BuildLookupTableEv;
    extern fn _ZN6ImFont16BuildLookupTableEv(self: *ImFont) void;
    pub const ClearOutputData = _ZN6ImFont15ClearOutputDataEv;
    extern fn _ZN6ImFont15ClearOutputDataEv(self: *ImFont) void;
    pub const GrowIndex = _ZN6ImFont9GrowIndexEi;
    extern fn _ZN6ImFont9GrowIndexEi(self: *ImFont, new_size: c_int) void;
    pub const AddGlyph = _ZN6ImFont8AddGlyphEPK12ImFontConfigtfffffffff;
    extern fn _ZN6ImFont8AddGlyphEPK12ImFontConfigtfffffffff(self: *ImFont, src_cfg: *const ImFontConfig, c: ImWchar, x0: f32, y0: f32, x1: f32, y1: f32, u0: f32, v0: f32, u1: f32, v1: f32, advance_x: f32) void;
    pub const AddRemapChar = _ZN6ImFont12AddRemapCharEttb;
    extern fn _ZN6ImFont12AddRemapCharEttb(self: *ImFont, dst: ImWchar, src: ImWchar, overwrite_dst: bool) void;
    pub const SetGlyphVisible = _ZN6ImFont15SetGlyphVisibleEtb;
    extern fn _ZN6ImFont15SetGlyphVisibleEtb(self: *ImFont, c: ImWchar, visible: bool) void;
    pub const IsGlyphRangeUnused = _ZN6ImFont18IsGlyphRangeUnusedEjj;
    extern fn _ZN6ImFont18IsGlyphRangeUnusedEjj(self: *ImFont, c_begin: c_uint, c_last: c_uint) bool;
};

pub const ImGuiViewportFlags_ = enum {
    None,
    IsPlatformWindow,
    IsPlatformMonitor,
    OwnedByApp,
    NoDecoration,
    NoTaskBarIcon,
    NoFocusOnAppearing,
    NoFocusOnClick,
    NoInputs,
    NoRendererClear,
    NoAutoMerge,
    TopMost,
    CanHostOtherWindows,
    IsMinimized,
    IsFocused,
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
    DrawData: *ImDrawData,
    RendererUserData: *void,
    PlatformUserData: *void,
    PlatformHandle: *void,
    PlatformHandleRaw: *void,
    PlatformWindowCreated: bool,
    PlatformRequestMove: bool,
    PlatformRequestResize: bool,
    PlatformRequestClose: bool,

    pub const GetCenter = _ZNK13ImGuiViewport9GetCenterEv;
    extern fn _ZNK13ImGuiViewport9GetCenterEv(self: *const ImGuiViewport) ImVec2;
    pub const GetWorkCenter = _ZNK13ImGuiViewport13GetWorkCenterEv;
    extern fn _ZNK13ImGuiViewport13GetWorkCenterEv(self: *const ImGuiViewport) ImVec2;
};

pub const ImGuiPlatformIO = extern struct {
    Platform_CreateWindow: *const fn () void,
    Platform_DestroyWindow: *const fn () void,
    Platform_ShowWindow: *const fn () void,
    Platform_SetWindowPos: *const fn (
        *ImGuiViewport,
    ) void,
    Platform_GetWindowPos: *const fn () ImVec2,
    Platform_SetWindowSize: *const fn (
        *ImGuiViewport,
    ) void,
    Platform_GetWindowSize: *const fn () ImVec2,
    Platform_SetWindowFocus: *const fn () void,
    Platform_GetWindowFocus: *const fn () bool,
    Platform_GetWindowMinimized: *const fn () bool,
    Platform_SetWindowTitle: *const fn (
        *ImGuiViewport,
    ) void,
    Platform_SetWindowAlpha: *const fn (
        *ImGuiViewport,
    ) void,
    Platform_UpdateWindow: *const fn () void,
    Platform_RenderWindow: *const fn (
        *ImGuiViewport,
    ) void,
    Platform_SwapBuffers: *const fn (
        *ImGuiViewport,
    ) void,
    Platform_GetWindowDpiScale: *const fn () f32,
    Platform_OnChangedViewport: *const fn () void,
    Platform_CreateVkSurface: *const fn (
        *ImGuiViewport,
        ImU64,
        *const void,
    ) c_int,
    Renderer_CreateWindow: *const fn () void,
    Renderer_DestroyWindow: *const fn () void,
    Renderer_SetWindowSize: *const fn (
        *ImGuiViewport,
    ) void,
    Renderer_RenderWindow: *const fn (
        *ImGuiViewport,
    ) void,
    Renderer_SwapBuffers: *const fn (
        *ImGuiViewport,
    ) void,
    Monitors: ImVector(ImGuiPlatformMonitor),
    Viewports: ImVector(*ImGuiViewport),
};

pub const ImGuiPlatformMonitor = extern struct {
    MainPos: ImVec2,
    MainSize: ImVec2,
    WorkPos: ImVec2,
    WorkSize: ImVec2,
    DpiScale: f32,
};

pub const ImGuiPlatformImeData = extern struct {
    WantVisible: bool,
    InputPos: ImVec2,
    InputLineHeight: f32,
};

pub const ImDrawCornerFlags = ImDrawFlags;
pub const ImDrawCornerFlags_ = enum {
    None,
    TopLeft,
    TopRight,
    BotLeft,
    BotRight,
    All,
    Top,
    Bot,
    Left,
    Right,
};

pub const ImGuiModFlags = ImGuiKeyChord;
pub const ImGuiModFlags_ = enum {
    None,
    Ctrl,
    Shift,
    Alt,
    Super,
};
