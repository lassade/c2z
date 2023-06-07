const SDL_Event = anyopaque;
const SDL_Window = anyopaque;
//const SDL_Renderer = anyopaque;

const ImDrawData = @import("imgui.zig").ImDrawData;

pub const sdl2 = struct {
    // pub const init = _Z19ImGui_ImplSDL2_InitP10SDL_WindowP12SDL_RendererPv;
    // extern fn _Z19ImGui_ImplSDL2_InitP10SDL_WindowP12SDL_RendererPv(window: *SDL_Window, renderer: *SDL_Renderer, sdl_gl_context: *void) c_int;
    pub const initForOpenGL = _Z28ImGui_ImplSDL2_InitForOpenGLP10SDL_WindowPv;
    extern fn _Z28ImGui_ImplSDL2_InitForOpenGLP10SDL_WindowPv(window: ?*SDL_Window, sdl_gl_context: ?*anyopaque) c_int;
    // pub const initForVulkan = _Z28ImGui_ImplSDL2_InitForVulkanP10SDL_Window;
    // extern fn _Z28ImGui_ImplSDL2_InitForVulkanP10SDL_Window(window: *SDL_Window) c_int;
    // pub const initForD3D = _Z25ImGui_ImplSDL2_InitForD3DP10SDL_Window;
    // extern fn _Z25ImGui_ImplSDL2_InitForD3DP10SDL_Window(window: *SDL_Window) c_int;
    // pub const initForMetal = _Z27ImGui_ImplSDL2_InitForMetalP10SDL_Window;
    // extern fn _Z27ImGui_ImplSDL2_InitForMetalP10SDL_Window(window: *SDL_Window) c_int;
    // pub const initForSDLRenderer = _Z33ImGui_ImplSDL2_InitForSDLRendererP10SDL_WindowP12SDL_Renderer;
    // extern fn _Z33ImGui_ImplSDL2_InitForSDLRendererP10SDL_WindowP12SDL_Renderer(window: *SDL_Window, renderer: *SDL_Renderer) c_int;
    pub const shutdown = _Z23ImGui_ImplSDL2_Shutdownv;
    extern fn _Z23ImGui_ImplSDL2_Shutdownv() c_int;
    pub const newFrame = _Z23ImGui_ImplSDL2_NewFramev;
    extern fn _Z23ImGui_ImplSDL2_NewFramev() c_int;
    pub const processEvent = _Z27ImGui_ImplSDL2_ProcessEventPK9SDL_Event;
    extern fn _Z27ImGui_ImplSDL2_ProcessEventPK9SDL_Event(event: *const SDL_Event) c_int;
};

pub const opengl3 = struct {
    pub const init = _Z22ImGui_ImplOpenGL3_InitPKc;
    extern fn _Z22ImGui_ImplOpenGL3_InitPKc(glsl_version: ?*const u8) c_int;
    pub const shutdown = _Z26ImGui_ImplOpenGL3_Shutdownv;
    extern fn _Z26ImGui_ImplOpenGL3_Shutdownv() c_int;
    pub const newFrame = _Z26ImGui_ImplOpenGL3_NewFramev;
    extern fn _Z26ImGui_ImplOpenGL3_NewFramev() c_int;
    pub const renderDrawData = _Z32ImGui_ImplOpenGL3_RenderDrawDataP10ImDrawData;
    extern fn _Z32ImGui_ImplOpenGL3_RenderDrawDataP10ImDrawData(draw_data: *ImDrawData) c_int;
    // pub const createFontsTexture = _Z36ImGui_ImplOpenGL3_CreateFontsTexturev;
    // extern fn _Z36ImGui_ImplOpenGL3_CreateFontsTexturev() c_int;
    // pub const destroyFontsTexture = _Z37ImGui_ImplOpenGL3_DestroyFontsTexturev;
    // extern fn _Z37ImGui_ImplOpenGL3_DestroyFontsTexturev() c_int;
    // pub const createDeviceObjects = _Z37ImGui_ImplOpenGL3_CreateDeviceObjectsv;
    // extern fn _Z37ImGui_ImplOpenGL3_CreateDeviceObjectsv() c_int;
    // pub const destroyDeviceObjects = _Z38ImGui_ImplOpenGL3_DestroyDeviceObjectsv;
    // extern fn _Z38ImGui_ImplOpenGL3_DestroyDeviceObjectsv() c_int;
};
