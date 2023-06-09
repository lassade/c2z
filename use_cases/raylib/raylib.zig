pub const Vector2 = extern struct {
    x: f32,
    y: f32,
};

pub const Vector3 = extern struct {
    x: f32,
    y: f32,
    z: f32,
};

pub const Vector4 = extern struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,
};

pub const Quaternion = Vector4;

pub const Matrix = extern struct {
    m0: f32,
    m4: f32,
    m8: f32,
    m12: f32,
    m1: f32,
    m5: f32,
    m9: f32,
    m13: f32,
    m2: f32,
    m6: f32,
    m10: f32,
    m14: f32,
    m3: f32,
    m7: f32,
    m11: f32,
    m15: f32,
};

pub const Color = extern struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
};

pub const Rectangle = extern struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,
};

pub const Image = extern struct {
    data: ?*void,
    width: c_int,
    height: c_int,
    mipmaps: c_int,
    format: c_int,
};

pub const Texture = extern struct {
    id: c_uint,
    width: c_int,
    height: c_int,
    mipmaps: c_int,
    format: c_int,
};

pub const Texture2D = Texture;

pub const TextureCubemap = Texture;

pub const RenderTexture = extern struct {
    id: c_uint,
    texture: Texture,
    depth: Texture,
};

pub const RenderTexture2D = RenderTexture;

pub const NPatchInfo = extern struct {
    source: Rectangle,
    left: c_int,
    top: c_int,
    right: c_int,
    bottom: c_int,
    layout: c_int,
};

pub const GlyphInfo = extern struct {
    value: c_int,
    offsetX: c_int,
    offsetY: c_int,
    advanceX: c_int,
    image: Image,
};

pub const Font = extern struct {
    baseSize: c_int,
    glyphCount: c_int,
    glyphPadding: c_int,
    texture: Texture2D,
    recs: ?*Rectangle,
    glyphs: ?*GlyphInfo,
};

pub const Camera3D = extern struct {
    position: Vector3,
    target: Vector3,
    up: Vector3,
    fovy: f32,
    projection: c_int,
};

pub const Camera = Camera3D;

pub const Camera2D = extern struct {
    offset: Vector2,
    target: Vector2,
    rotation: f32,
    zoom: f32,
};

pub const Mesh = extern struct {
    vertexCount: c_int,
    triangleCount: c_int,
    vertices: ?*f32,
    texcoords: ?*f32,
    texcoords2: ?*f32,
    normals: ?*f32,
    tangents: ?*f32,
    colors: ?*u8,
    indices: ?*c_ushort,
    animVertices: ?*f32,
    animNormals: ?*f32,
    boneIds: ?*u8,
    boneWeights: ?*f32,
    vaoId: c_uint,
    vboId: ?*c_uint,
};

pub const Shader = extern struct {
    id: c_uint,
    locs: ?*c_int,
};

pub const MaterialMap = extern struct {
    texture: Texture2D,
    color: Color,
    value: f32,
};

pub const Material = extern struct {
    shader: Shader,
    maps: ?*MaterialMap,
    params: [4]f32,
};

pub const Transform = extern struct {
    translation: Vector3,
    rotation: Quaternion,
    scale: Vector3,
};

pub const BoneInfo = extern struct {
    name: [32]u8,
    parent: c_int,
};

pub const Model = extern struct {
    transform: Matrix,
    meshCount: c_int,
    materialCount: c_int,
    meshes: ?*Mesh,
    materials: ?*Material,
    meshMaterial: ?*c_int,
    boneCount: c_int,
    bones: ?*BoneInfo,
    bindPose: ?*Transform,
};

pub const ModelAnimation = extern struct {
    boneCount: c_int,
    frameCount: c_int,
    bones: ?*BoneInfo,
    framePoses: ?*?*Transform,
};

pub const Ray = extern struct {
    position: Vector3,
    direction: Vector3,
};

pub const RayCollision = extern struct {
    hit: bool,
    distance: f32,
    point: Vector3,
    normal: Vector3,
};

pub const BoundingBox = extern struct {
    min: Vector3,
    max: Vector3,
};

pub const Wave = extern struct {
    frameCount: c_uint,
    sampleRate: c_uint,
    sampleSize: c_uint,
    channels: c_uint,
    data: ?*void,
};

pub const AudioStream = extern struct {
    buffer: ?*rAudioBuffer,
    processor: ?*rAudioProcessor,
    sampleRate: c_uint,
    sampleSize: c_uint,
    channels: c_uint,
};

pub const Sound = extern struct {
    stream: AudioStream,
    frameCount: c_uint,
};

pub const Music = extern struct {
    stream: AudioStream,
    frameCount: c_uint,
    looping: bool,
    ctxType: c_int,
    ctxData: ?*void,
};

pub const VrDeviceInfo = extern struct {
    hResolution: c_int,
    vResolution: c_int,
    hScreenSize: f32,
    vScreenSize: f32,
    vScreenCenter: f32,
    eyeToScreenDistance: f32,
    lensSeparationDistance: f32,
    interpupillaryDistance: f32,
    lensDistortionValues: [4]f32,
    chromaAbCorrection: [4]f32,
};

pub const VrStereoConfig = extern struct {
    projection: [2]Matrix,
    viewOffset: [2]Matrix,
    leftLensCenter: [2]f32,
    rightLensCenter: [2]f32,
    leftScreenCenter: [2]f32,
    rightScreenCenter: [2]f32,
    scale: [2]f32,
    scaleIn: [2]f32,
};

pub const FilePathList = extern struct {
    capacity: c_uint,
    count: c_uint,
    paths: ?*?*u8,
};

pub extern fn InitWindow(width: c_int, height: c_int, title: ?*const u8) void;
pub extern fn WindowShouldClose() bool;
pub extern fn CloseWindow() void;
pub extern fn IsWindowReady() bool;
pub extern fn IsWindowFullscreen() bool;
pub extern fn IsWindowHidden() bool;
pub extern fn IsWindowMinimized() bool;
pub extern fn IsWindowMaximized() bool;
pub extern fn IsWindowFocused() bool;
pub extern fn IsWindowResized() bool;
pub extern fn IsWindowState(flag: c_uint) bool;
pub extern fn SetWindowState(flags: c_uint) void;
pub extern fn ClearWindowState(flags: c_uint) void;
pub extern fn ToggleFullscreen() void;
pub extern fn MaximizeWindow() void;
pub extern fn MinimizeWindow() void;
pub extern fn RestoreWindow() void;
pub extern fn SetWindowIcon(image: Image) void;
pub extern fn SetWindowIcons(images: ?*Image, count: c_int) void;
pub extern fn SetWindowTitle(title: ?*const u8) void;
pub extern fn SetWindowPosition(x: c_int, y: c_int) void;
pub extern fn SetWindowMonitor(monitor: c_int) void;
pub extern fn SetWindowMinSize(width: c_int, height: c_int) void;
pub extern fn SetWindowSize(width: c_int, height: c_int) void;
pub extern fn SetWindowOpacity(opacity: f32) void;
pub extern fn GetWindowHandle() ?*void;
pub extern fn GetScreenWidth() c_int;
pub extern fn GetScreenHeight() c_int;
pub extern fn GetRenderWidth() c_int;
pub extern fn GetRenderHeight() c_int;
pub extern fn GetMonitorCount() c_int;
pub extern fn GetCurrentMonitor() c_int;
pub extern fn GetMonitorPosition(monitor: c_int) Vector2;
pub extern fn GetMonitorWidth(monitor: c_int) c_int;
pub extern fn GetMonitorHeight(monitor: c_int) c_int;
pub extern fn GetMonitorPhysicalWidth(monitor: c_int) c_int;
pub extern fn GetMonitorPhysicalHeight(monitor: c_int) c_int;
pub extern fn GetMonitorRefreshRate(monitor: c_int) c_int;
pub extern fn GetWindowPosition() Vector2;
pub extern fn GetWindowScaleDPI() Vector2;
pub extern fn GetMonitorName(monitor: c_int) ?*const u8;
pub extern fn SetClipboardText(text: ?*const u8) void;
pub extern fn GetClipboardText() ?*const u8;
pub extern fn EnableEventWaiting() void;
pub extern fn DisableEventWaiting() void;
pub extern fn SwapScreenBuffer() void;
pub extern fn PollInputEvents() void;
pub extern fn WaitTime(seconds: f64) void;
pub extern fn ShowCursor() void;
pub extern fn HideCursor() void;
pub extern fn IsCursorHidden() bool;
pub extern fn EnableCursor() void;
pub extern fn DisableCursor() void;
pub extern fn IsCursorOnScreen() bool;
pub extern fn ClearBackground(color: Color) void;
pub extern fn BeginDrawing() void;
pub extern fn EndDrawing() void;
pub extern fn BeginMode2D(camera: Camera2D) void;
pub extern fn EndMode2D() void;
pub extern fn BeginMode3D(camera: Camera3D) void;
pub extern fn EndMode3D() void;
pub extern fn BeginTextureMode(target: RenderTexture2D) void;
pub extern fn EndTextureMode() void;
pub extern fn BeginShaderMode(shader: Shader) void;
pub extern fn EndShaderMode() void;
pub extern fn BeginBlendMode(mode: c_int) void;
pub extern fn EndBlendMode() void;
pub extern fn BeginScissorMode(x: c_int, y: c_int, width: c_int, height: c_int) void;
pub extern fn EndScissorMode() void;
pub extern fn BeginVrStereoMode(config: VrStereoConfig) void;
pub extern fn EndVrStereoMode() void;
pub extern fn LoadVrStereoConfig(device: VrDeviceInfo) VrStereoConfig;
pub extern fn UnloadVrStereoConfig(config: VrStereoConfig) void;
pub extern fn LoadShader(vsFileName: ?*const u8, fsFileName: ?*const u8) Shader;
pub extern fn LoadShaderFromMemory(vsCode: ?*const u8, fsCode: ?*const u8) Shader;
pub extern fn IsShaderReady(shader: Shader) bool;
pub extern fn GetShaderLocation(shader: Shader, uniformName: ?*const u8) c_int;
pub extern fn GetShaderLocationAttrib(shader: Shader, attribName: ?*const u8) c_int;
pub extern fn SetShaderValue(shader: Shader, locIndex: c_int, value: ?*const void, uniformType: c_int) void;
pub extern fn SetShaderValueV(shader: Shader, locIndex: c_int, value: ?*const void, uniformType: c_int, count: c_int) void;
pub extern fn SetShaderValueMatrix(shader: Shader, locIndex: c_int, mat: Matrix) void;
pub extern fn SetShaderValueTexture(shader: Shader, locIndex: c_int, texture: Texture2D) void;
pub extern fn UnloadShader(shader: Shader) void;
pub extern fn GetMouseRay(mousePosition: Vector2, camera: Camera) Ray;
pub extern fn GetCameraMatrix(camera: Camera) Matrix;
pub extern fn GetCameraMatrix2D(camera: Camera2D) Matrix;
pub extern fn GetWorldToScreen(position: Vector3, camera: Camera) Vector2;
pub extern fn GetScreenToWorld2D(position: Vector2, camera: Camera2D) Vector2;
pub extern fn GetWorldToScreenEx(position: Vector3, camera: Camera, width: c_int, height: c_int) Vector2;
pub extern fn GetWorldToScreen2D(position: Vector2, camera: Camera2D) Vector2;
pub extern fn SetTargetFPS(fps: c_int) void;
pub extern fn GetFPS() c_int;
pub extern fn GetFrameTime() f32;
pub extern fn GetTime() f64;
pub extern fn GetRandomValue(min: c_int, max: c_int) c_int;
pub extern fn SetRandomSeed(seed: c_uint) void;
pub extern fn TakeScreenshot(fileName: ?*const u8) void;
pub extern fn SetConfigFlags(flags: c_uint) void;
pub extern fn TraceLog(logLevel: c_int, text: ?*const u8) void;
pub extern fn SetTraceLogLevel(logLevel: c_int) void;
pub extern fn MemAlloc(size: c_uint) ?*void;
pub extern fn MemRealloc(ptr: ?*void, size: c_uint) ?*void;
pub extern fn MemFree(ptr: ?*void) void;
pub extern fn OpenURL(url: ?*const u8) void;
pub extern fn SetTraceLogCallback(callback: TraceLogCallback) void;
pub extern fn SetLoadFileDataCallback(callback: LoadFileDataCallback) void;
pub extern fn SetSaveFileDataCallback(callback: SaveFileDataCallback) void;
pub extern fn SetLoadFileTextCallback(callback: LoadFileTextCallback) void;
pub extern fn SetSaveFileTextCallback(callback: SaveFileTextCallback) void;
pub extern fn LoadFileData(fileName: ?*const u8, bytesRead: ?*c_uint) ?*u8;
pub extern fn UnloadFileData(data: ?*u8) void;
pub extern fn SaveFileData(fileName: ?*const u8, data: ?*void, bytesToWrite: c_uint) bool;
pub extern fn ExportDataAsCode(data: ?*const u8, size: c_uint, fileName: ?*const u8) bool;
pub extern fn LoadFileText(fileName: ?*const u8) ?*u8;
pub extern fn UnloadFileText(text: ?*u8) void;
pub extern fn SaveFileText(fileName: ?*const u8, text: ?*u8) bool;
pub extern fn FileExists(fileName: ?*const u8) bool;
pub extern fn DirectoryExists(dirPath: ?*const u8) bool;
pub extern fn IsFileExtension(fileName: ?*const u8, ext: ?*const u8) bool;
pub extern fn GetFileLength(fileName: ?*const u8) c_int;
pub extern fn GetFileExtension(fileName: ?*const u8) ?*const u8;
pub extern fn GetFileName(filePath: ?*const u8) ?*const u8;
pub extern fn GetFileNameWithoutExt(filePath: ?*const u8) ?*const u8;
pub extern fn GetDirectoryPath(filePath: ?*const u8) ?*const u8;
pub extern fn GetPrevDirectoryPath(dirPath: ?*const u8) ?*const u8;
pub extern fn GetWorkingDirectory() ?*const u8;
pub extern fn GetApplicationDirectory() ?*const u8;
pub extern fn ChangeDirectory(dir: ?*const u8) bool;
pub extern fn IsPathFile(path: ?*const u8) bool;
pub extern fn LoadDirectoryFiles(dirPath: ?*const u8) FilePathList;
pub extern fn LoadDirectoryFilesEx(basePath: ?*const u8, filter: ?*const u8, scanSubdirs: bool) FilePathList;
pub extern fn UnloadDirectoryFiles(files: FilePathList) void;
pub extern fn IsFileDropped() bool;
pub extern fn LoadDroppedFiles() FilePathList;
pub extern fn UnloadDroppedFiles(files: FilePathList) void;
pub extern fn GetFileModTime(fileName: ?*const u8) c_long;
pub extern fn CompressData(data: ?*const u8, dataSize: c_int, compDataSize: ?*c_int) ?*u8;
pub extern fn DecompressData(compData: ?*const u8, compDataSize: c_int, dataSize: ?*c_int) ?*u8;
pub extern fn EncodeDataBase64(data: ?*const u8, dataSize: c_int, outputSize: ?*c_int) ?*u8;
pub extern fn DecodeDataBase64(data: ?*const u8, outputSize: ?*c_int) ?*u8;
pub extern fn IsKeyPressed(key: c_int) bool;
pub extern fn IsKeyDown(key: c_int) bool;
pub extern fn IsKeyReleased(key: c_int) bool;
pub extern fn IsKeyUp(key: c_int) bool;
pub extern fn SetExitKey(key: c_int) void;
pub extern fn GetKeyPressed() c_int;
pub extern fn GetCharPressed() c_int;
pub extern fn IsGamepadAvailable(gamepad: c_int) bool;
pub extern fn GetGamepadName(gamepad: c_int) ?*const u8;
pub extern fn IsGamepadButtonPressed(gamepad: c_int, button: c_int) bool;
pub extern fn IsGamepadButtonDown(gamepad: c_int, button: c_int) bool;
pub extern fn IsGamepadButtonReleased(gamepad: c_int, button: c_int) bool;
pub extern fn IsGamepadButtonUp(gamepad: c_int, button: c_int) bool;
pub extern fn GetGamepadButtonPressed() c_int;
pub extern fn GetGamepadAxisCount(gamepad: c_int) c_int;
pub extern fn GetGamepadAxisMovement(gamepad: c_int, axis: c_int) f32;
pub extern fn SetGamepadMappings(mappings: ?*const u8) c_int;
pub extern fn IsMouseButtonPressed(button: c_int) bool;
pub extern fn IsMouseButtonDown(button: c_int) bool;
pub extern fn IsMouseButtonReleased(button: c_int) bool;
pub extern fn IsMouseButtonUp(button: c_int) bool;
pub extern fn GetMouseX() c_int;
pub extern fn GetMouseY() c_int;
pub extern fn GetMousePosition() Vector2;
pub extern fn GetMouseDelta() Vector2;
pub extern fn SetMousePosition(x: c_int, y: c_int) void;
pub extern fn SetMouseOffset(offsetX: c_int, offsetY: c_int) void;
pub extern fn SetMouseScale(scaleX: f32, scaleY: f32) void;
pub extern fn GetMouseWheelMove() f32;
pub extern fn GetMouseWheelMoveV() Vector2;
pub extern fn SetMouseCursor(cursor: c_int) void;
pub extern fn GetTouchX() c_int;
pub extern fn GetTouchY() c_int;
pub extern fn GetTouchPosition(index: c_int) Vector2;
pub extern fn GetTouchPointId(index: c_int) c_int;
pub extern fn GetTouchPointCount() c_int;
pub extern fn SetGesturesEnabled(flags: c_uint) void;
pub extern fn IsGestureDetected(gesture: c_int) bool;
pub extern fn GetGestureDetected() c_int;
pub extern fn GetGestureHoldDuration() f32;
pub extern fn GetGestureDragVector() Vector2;
pub extern fn GetGestureDragAngle() f32;
pub extern fn GetGesturePinchVector() Vector2;
pub extern fn GetGesturePinchAngle() f32;
pub extern fn UpdateCamera(camera: ?*Camera, mode: c_int) void;
pub extern fn UpdateCameraPro(camera: ?*Camera, movement: Vector3, rotation: Vector3, zoom: f32) void;
pub extern fn SetShapesTexture(texture: Texture2D, source: Rectangle) void;
pub extern fn DrawPixel(posX: c_int, posY: c_int, color: Color) void;
pub extern fn DrawPixelV(position: Vector2, color: Color) void;
pub extern fn DrawLine(startPosX: c_int, startPosY: c_int, endPosX: c_int, endPosY: c_int, color: Color) void;
pub extern fn DrawLineV(startPos: Vector2, endPos: Vector2, color: Color) void;
pub extern fn DrawLineEx(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void;
pub extern fn DrawLineBezier(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void;
pub extern fn DrawLineBezierQuad(startPos: Vector2, endPos: Vector2, controlPos: Vector2, thick: f32, color: Color) void;
pub extern fn DrawLineBezierCubic(startPos: Vector2, endPos: Vector2, startControlPos: Vector2, endControlPos: Vector2, thick: f32, color: Color) void;
pub extern fn DrawLineStrip(points: ?*Vector2, pointCount: c_int, color: Color) void;
pub extern fn DrawCircle(centerX: c_int, centerY: c_int, radius: f32, color: Color) void;
pub extern fn DrawCircleSector(center: Vector2, radius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void;
pub extern fn DrawCircleSectorLines(center: Vector2, radius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void;
pub extern fn DrawCircleGradient(centerX: c_int, centerY: c_int, radius: f32, color1: Color, color2: Color) void;
pub extern fn DrawCircleV(center: Vector2, radius: f32, color: Color) void;
pub extern fn DrawCircleLines(centerX: c_int, centerY: c_int, radius: f32, color: Color) void;
pub extern fn DrawEllipse(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: Color) void;
pub extern fn DrawEllipseLines(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: Color) void;
pub extern fn DrawRing(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void;
pub extern fn DrawRingLines(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void;
pub extern fn DrawRectangle(posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void;
pub extern fn DrawRectangleV(position: Vector2, size: Vector2, color: Color) void;
pub extern fn DrawRectangleRec(rec: Rectangle, color: Color) void;
pub extern fn DrawRectanglePro(rec: Rectangle, origin: Vector2, rotation: f32, color: Color) void;
pub extern fn DrawRectangleGradientV(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: Color, color2: Color) void;
pub extern fn DrawRectangleGradientH(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: Color, color2: Color) void;
pub extern fn DrawRectangleGradientEx(rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color) void;
pub extern fn DrawRectangleLines(posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void;
pub extern fn DrawRectangleLinesEx(rec: Rectangle, lineThick: f32, color: Color) void;
pub extern fn DrawRectangleRounded(rec: Rectangle, roundness: f32, segments: c_int, color: Color) void;
pub extern fn DrawRectangleRoundedLines(rec: Rectangle, roundness: f32, segments: c_int, lineThick: f32, color: Color) void;
pub extern fn DrawTriangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void;
pub extern fn DrawTriangleLines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void;
pub extern fn DrawTriangleFan(points: ?*Vector2, pointCount: c_int, color: Color) void;
pub extern fn DrawTriangleStrip(points: ?*Vector2, pointCount: c_int, color: Color) void;
pub extern fn DrawPoly(center: Vector2, sides: c_int, radius: f32, rotation: f32, color: Color) void;
pub extern fn DrawPolyLines(center: Vector2, sides: c_int, radius: f32, rotation: f32, color: Color) void;
pub extern fn DrawPolyLinesEx(center: Vector2, sides: c_int, radius: f32, rotation: f32, lineThick: f32, color: Color) void;
pub extern fn CheckCollisionRecs(rec1: Rectangle, rec2: Rectangle) bool;
pub extern fn CheckCollisionCircles(center1: Vector2, radius1: f32, center2: Vector2, radius2: f32) bool;
pub extern fn CheckCollisionCircleRec(center: Vector2, radius: f32, rec: Rectangle) bool;
pub extern fn CheckCollisionPointRec(point: Vector2, rec: Rectangle) bool;
pub extern fn CheckCollisionPointCircle(point: Vector2, center: Vector2, radius: f32) bool;
pub extern fn CheckCollisionPointTriangle(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2) bool;
pub extern fn CheckCollisionPointPoly(point: Vector2, points: ?*Vector2, pointCount: c_int) bool;
pub extern fn CheckCollisionLines(startPos1: Vector2, endPos1: Vector2, startPos2: Vector2, endPos2: Vector2, collisionPoint: ?*Vector2) bool;
pub extern fn CheckCollisionPointLine(point: Vector2, p1: Vector2, p2: Vector2, threshold: c_int) bool;
pub extern fn GetCollisionRec(rec1: Rectangle, rec2: Rectangle) Rectangle;
pub extern fn LoadImage(fileName: ?*const u8) Image;
pub extern fn LoadImageRaw(fileName: ?*const u8, width: c_int, height: c_int, format: c_int, headerSize: c_int) Image;
pub extern fn LoadImageAnim(fileName: ?*const u8, frames: ?*c_int) Image;
pub extern fn LoadImageFromMemory(fileType: ?*const u8, fileData: ?*const u8, dataSize: c_int) Image;
pub extern fn LoadImageFromTexture(texture: Texture2D) Image;
pub extern fn LoadImageFromScreen() Image;
pub extern fn IsImageReady(image: Image) bool;
pub extern fn UnloadImage(image: Image) void;
pub extern fn ExportImage(image: Image, fileName: ?*const u8) bool;
pub extern fn ExportImageAsCode(image: Image, fileName: ?*const u8) bool;
pub extern fn GenImageColor(width: c_int, height: c_int, color: Color) Image;
pub extern fn GenImageGradientV(width: c_int, height: c_int, top: Color, bottom: Color) Image;
pub extern fn GenImageGradientH(width: c_int, height: c_int, left: Color, right: Color) Image;
pub extern fn GenImageGradientRadial(width: c_int, height: c_int, density: f32, inner: Color, outer: Color) Image;
pub extern fn GenImageChecked(width: c_int, height: c_int, checksX: c_int, checksY: c_int, col1: Color, col2: Color) Image;
pub extern fn GenImageWhiteNoise(width: c_int, height: c_int, factor: f32) Image;
pub extern fn GenImagePerlinNoise(width: c_int, height: c_int, offsetX: c_int, offsetY: c_int, scale: f32) Image;
pub extern fn GenImageCellular(width: c_int, height: c_int, tileSize: c_int) Image;
pub extern fn GenImageText(width: c_int, height: c_int, text: ?*const u8) Image;
pub extern fn ImageCopy(image: Image) Image;
pub extern fn ImageFromImage(image: Image, rec: Rectangle) Image;
pub extern fn ImageText(text: ?*const u8, fontSize: c_int, color: Color) Image;
pub extern fn ImageTextEx(font: Font, text: ?*const u8, fontSize: f32, spacing: f32, tint: Color) Image;
pub extern fn ImageFormat(image: ?*Image, newFormat: c_int) void;
pub extern fn ImageToPOT(image: ?*Image, fill: Color) void;
pub extern fn ImageCrop(image: ?*Image, crop: Rectangle) void;
pub extern fn ImageAlphaCrop(image: ?*Image, threshold: f32) void;
pub extern fn ImageAlphaClear(image: ?*Image, color: Color, threshold: f32) void;
pub extern fn ImageAlphaMask(image: ?*Image, alphaMask: Image) void;
pub extern fn ImageAlphaPremultiply(image: ?*Image) void;
pub extern fn ImageBlurGaussian(image: ?*Image, blurSize: c_int) void;
pub extern fn ImageResize(image: ?*Image, newWidth: c_int, newHeight: c_int) void;
pub extern fn ImageResizeNN(image: ?*Image, newWidth: c_int, newHeight: c_int) void;
pub extern fn ImageResizeCanvas(image: ?*Image, newWidth: c_int, newHeight: c_int, offsetX: c_int, offsetY: c_int, fill: Color) void;
pub extern fn ImageMipmaps(image: ?*Image) void;
pub extern fn ImageDither(image: ?*Image, rBpp: c_int, gBpp: c_int, bBpp: c_int, aBpp: c_int) void;
pub extern fn ImageFlipVertical(image: ?*Image) void;
pub extern fn ImageFlipHorizontal(image: ?*Image) void;
pub extern fn ImageRotateCW(image: ?*Image) void;
pub extern fn ImageRotateCCW(image: ?*Image) void;
pub extern fn ImageColorTint(image: ?*Image, color: Color) void;
pub extern fn ImageColorInvert(image: ?*Image) void;
pub extern fn ImageColorGrayscale(image: ?*Image) void;
pub extern fn ImageColorContrast(image: ?*Image, contrast: f32) void;
pub extern fn ImageColorBrightness(image: ?*Image, brightness: c_int) void;
pub extern fn ImageColorReplace(image: ?*Image, color: Color, replace: Color) void;
pub extern fn LoadImageColors(image: Image) ?*Color;
pub extern fn LoadImagePalette(image: Image, maxPaletteSize: c_int, colorCount: ?*c_int) ?*Color;
pub extern fn UnloadImageColors(colors: ?*Color) void;
pub extern fn UnloadImagePalette(colors: ?*Color) void;
pub extern fn GetImageAlphaBorder(image: Image, threshold: f32) Rectangle;
pub extern fn GetImageColor(image: Image, x: c_int, y: c_int) Color;
pub extern fn ImageClearBackground(dst: ?*Image, color: Color) void;
pub extern fn ImageDrawPixel(dst: ?*Image, posX: c_int, posY: c_int, color: Color) void;
pub extern fn ImageDrawPixelV(dst: ?*Image, position: Vector2, color: Color) void;
pub extern fn ImageDrawLine(dst: ?*Image, startPosX: c_int, startPosY: c_int, endPosX: c_int, endPosY: c_int, color: Color) void;
pub extern fn ImageDrawLineV(dst: ?*Image, start: Vector2, end: Vector2, color: Color) void;
pub extern fn ImageDrawCircle(dst: ?*Image, centerX: c_int, centerY: c_int, radius: c_int, color: Color) void;
pub extern fn ImageDrawCircleV(dst: ?*Image, center: Vector2, radius: c_int, color: Color) void;
pub extern fn ImageDrawCircleLines(dst: ?*Image, centerX: c_int, centerY: c_int, radius: c_int, color: Color) void;
pub extern fn ImageDrawCircleLinesV(dst: ?*Image, center: Vector2, radius: c_int, color: Color) void;
pub extern fn ImageDrawRectangle(dst: ?*Image, posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void;
pub extern fn ImageDrawRectangleV(dst: ?*Image, position: Vector2, size: Vector2, color: Color) void;
pub extern fn ImageDrawRectangleRec(dst: ?*Image, rec: Rectangle, color: Color) void;
pub extern fn ImageDrawRectangleLines(dst: ?*Image, rec: Rectangle, thick: c_int, color: Color) void;
pub extern fn ImageDraw(dst: ?*Image, src: Image, srcRec: Rectangle, dstRec: Rectangle, tint: Color) void;
pub extern fn ImageDrawText(dst: ?*Image, text: ?*const u8, posX: c_int, posY: c_int, fontSize: c_int, color: Color) void;
pub extern fn ImageDrawTextEx(dst: ?*Image, font: Font, text: ?*const u8, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void;
pub extern fn LoadTexture(fileName: ?*const u8) Texture2D;
pub extern fn LoadTextureFromImage(image: Image) Texture2D;
pub extern fn LoadTextureCubemap(image: Image, layout: c_int) TextureCubemap;
pub extern fn LoadRenderTexture(width: c_int, height: c_int) RenderTexture2D;
pub extern fn IsTextureReady(texture: Texture2D) bool;
pub extern fn UnloadTexture(texture: Texture2D) void;
pub extern fn IsRenderTextureReady(target: RenderTexture2D) bool;
pub extern fn UnloadRenderTexture(target: RenderTexture2D) void;
pub extern fn UpdateTexture(texture: Texture2D, pixels: ?*const void) void;
pub extern fn UpdateTextureRec(texture: Texture2D, rec: Rectangle, pixels: ?*const void) void;
pub extern fn GenTextureMipmaps(texture: ?*Texture2D) void;
pub extern fn SetTextureFilter(texture: Texture2D, filter: c_int) void;
pub extern fn SetTextureWrap(texture: Texture2D, wrap: c_int) void;
pub extern fn DrawTexture(texture: Texture2D, posX: c_int, posY: c_int, tint: Color) void;
pub extern fn DrawTextureV(texture: Texture2D, position: Vector2, tint: Color) void;
pub extern fn DrawTextureEx(texture: Texture2D, position: Vector2, rotation: f32, scale: f32, tint: Color) void;
pub extern fn DrawTextureRec(texture: Texture2D, source: Rectangle, position: Vector2, tint: Color) void;
pub extern fn DrawTexturePro(texture: Texture2D, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void;
pub extern fn DrawTextureNPatch(texture: Texture2D, nPatchInfo: NPatchInfo, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void;
pub extern fn Fade(color: Color, alpha: f32) Color;
pub extern fn ColorToInt(color: Color) c_int;
pub extern fn ColorNormalize(color: Color) Vector4;
pub extern fn ColorFromNormalized(normalized: Vector4) Color;
pub extern fn ColorToHSV(color: Color) Vector3;
pub extern fn ColorFromHSV(hue: f32, saturation: f32, value: f32) Color;
pub extern fn ColorTint(color: Color, tint: Color) Color;
pub extern fn ColorBrightness(color: Color, factor: f32) Color;
pub extern fn ColorContrast(color: Color, contrast: f32) Color;
pub extern fn ColorAlpha(color: Color, alpha: f32) Color;
pub extern fn ColorAlphaBlend(dst: Color, src: Color, tint: Color) Color;
pub extern fn GetColor(hexValue: c_uint) Color;
pub extern fn GetPixelColor(srcPtr: ?*void, format: c_int) Color;
pub extern fn SetPixelColor(dstPtr: ?*void, color: Color, format: c_int) void;
pub extern fn GetPixelDataSize(width: c_int, height: c_int, format: c_int) c_int;
pub extern fn GetFontDefault() Font;
pub extern fn LoadFont(fileName: ?*const u8) Font;
pub extern fn LoadFontEx(fileName: ?*const u8, fontSize: c_int, fontChars: ?*c_int, glyphCount: c_int) Font;
pub extern fn LoadFontFromImage(image: Image, key: Color, firstChar: c_int) Font;
pub extern fn LoadFontFromMemory(fileType: ?*const u8, fileData: ?*const u8, dataSize: c_int, fontSize: c_int, fontChars: ?*c_int, glyphCount: c_int) Font;
pub extern fn IsFontReady(font: Font) bool;
pub extern fn LoadFontData(fileData: ?*const u8, dataSize: c_int, fontSize: c_int, fontChars: ?*c_int, glyphCount: c_int, type: c_int) ?*GlyphInfo;
pub extern fn GenImageFontAtlas(chars: ?*const GlyphInfo, recs: ?*?*Rectangle, glyphCount: c_int, fontSize: c_int, padding: c_int, packMethod: c_int) Image;
pub extern fn UnloadFontData(chars: ?*GlyphInfo, glyphCount: c_int) void;
pub extern fn UnloadFont(font: Font) void;
pub extern fn ExportFontAsCode(font: Font, fileName: ?*const u8) bool;
pub extern fn DrawFPS(posX: c_int, posY: c_int) void;
pub extern fn DrawText(text: ?*const u8, posX: c_int, posY: c_int, fontSize: c_int, color: Color) void;
pub extern fn DrawTextEx(font: Font, text: ?*const u8, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void;
pub extern fn DrawTextPro(font: Font, text: ?*const u8, position: Vector2, origin: Vector2, rotation: f32, fontSize: f32, spacing: f32, tint: Color) void;
pub extern fn DrawTextCodepoint(font: Font, codepoint: c_int, position: Vector2, fontSize: f32, tint: Color) void;
pub extern fn DrawTextCodepoints(font: Font, codepoints: ?*const c_int, count: c_int, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void;
pub extern fn MeasureText(text: ?*const u8, fontSize: c_int) c_int;
pub extern fn MeasureTextEx(font: Font, text: ?*const u8, fontSize: f32, spacing: f32) Vector2;
pub extern fn GetGlyphIndex(font: Font, codepoint: c_int) c_int;
pub extern fn GetGlyphInfo(font: Font, codepoint: c_int) GlyphInfo;
pub extern fn GetGlyphAtlasRec(font: Font, codepoint: c_int) Rectangle;
pub extern fn LoadUTF8(codepoints: ?*const c_int, length: c_int) ?*u8;
pub extern fn UnloadUTF8(text: ?*u8) void;
pub extern fn LoadCodepoints(text: ?*const u8, count: ?*c_int) ?*c_int;
pub extern fn UnloadCodepoints(codepoints: ?*c_int) void;
pub extern fn GetCodepointCount(text: ?*const u8) c_int;
pub extern fn GetCodepoint(text: ?*const u8, codepointSize: ?*c_int) c_int;
pub extern fn GetCodepointNext(text: ?*const u8, codepointSize: ?*c_int) c_int;
pub extern fn GetCodepointPrevious(text: ?*const u8, codepointSize: ?*c_int) c_int;
pub extern fn CodepointToUTF8(codepoint: c_int, utf8Size: ?*c_int) ?*const u8;
pub extern fn TextCopy(dst: ?*u8, src: ?*const u8) c_int;
pub extern fn TextIsEqual(text1: ?*const u8, text2: ?*const u8) bool;
pub extern fn TextLength(text: ?*const u8) c_uint;
pub extern fn TextFormat(text: ?*const u8) ?*const u8;
pub extern fn TextSubtext(text: ?*const u8, position: c_int, length: c_int) ?*const u8;
pub extern fn TextReplace(text: ?*u8, replace: ?*const u8, by: ?*const u8) ?*u8;
pub extern fn TextInsert(text: ?*const u8, insert: ?*const u8, position: c_int) ?*u8;
pub extern fn TextJoin(textList: ?*const ?*u8, count: c_int, delimiter: ?*const u8) ?*const u8;
pub extern fn TextSplit(text: ?*const u8, delimiter: u8, count: ?*c_int) ?*const ?*u8;
pub extern fn TextAppend(text: ?*u8, append: ?*const u8, position: ?*c_int) void;
pub extern fn TextFindIndex(text: ?*const u8, find: ?*const u8) c_int;
pub extern fn TextToUpper(text: ?*const u8) ?*const u8;
pub extern fn TextToLower(text: ?*const u8) ?*const u8;
pub extern fn TextToPascal(text: ?*const u8) ?*const u8;
pub extern fn TextToInteger(text: ?*const u8) c_int;
pub extern fn DrawLine3D(startPos: Vector3, endPos: Vector3, color: Color) void;
pub extern fn DrawPoint3D(position: Vector3, color: Color) void;
pub extern fn DrawCircle3D(center: Vector3, radius: f32, rotationAxis: Vector3, rotationAngle: f32, color: Color) void;
pub extern fn DrawTriangle3D(v1: Vector3, v2: Vector3, v3: Vector3, color: Color) void;
pub extern fn DrawTriangleStrip3D(points: ?*Vector3, pointCount: c_int, color: Color) void;
pub extern fn DrawCube(position: Vector3, width: f32, height: f32, length: f32, color: Color) void;
pub extern fn DrawCubeV(position: Vector3, size: Vector3, color: Color) void;
pub extern fn DrawCubeWires(position: Vector3, width: f32, height: f32, length: f32, color: Color) void;
pub extern fn DrawCubeWiresV(position: Vector3, size: Vector3, color: Color) void;
pub extern fn DrawSphere(centerPos: Vector3, radius: f32, color: Color) void;
pub extern fn DrawSphereEx(centerPos: Vector3, radius: f32, rings: c_int, slices: c_int, color: Color) void;
pub extern fn DrawSphereWires(centerPos: Vector3, radius: f32, rings: c_int, slices: c_int, color: Color) void;
pub extern fn DrawCylinder(position: Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: c_int, color: Color) void;
pub extern fn DrawCylinderEx(startPos: Vector3, endPos: Vector3, startRadius: f32, endRadius: f32, sides: c_int, color: Color) void;
pub extern fn DrawCylinderWires(position: Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: c_int, color: Color) void;
pub extern fn DrawCylinderWiresEx(startPos: Vector3, endPos: Vector3, startRadius: f32, endRadius: f32, sides: c_int, color: Color) void;
pub extern fn DrawCapsule(startPos: Vector3, endPos: Vector3, radius: f32, slices: c_int, rings: c_int, color: Color) void;
pub extern fn DrawCapsuleWires(startPos: Vector3, endPos: Vector3, radius: f32, slices: c_int, rings: c_int, color: Color) void;
pub extern fn DrawPlane(centerPos: Vector3, size: Vector2, color: Color) void;
pub extern fn DrawRay(ray: Ray, color: Color) void;
pub extern fn DrawGrid(slices: c_int, spacing: f32) void;
pub extern fn LoadModel(fileName: ?*const u8) Model;
pub extern fn LoadModelFromMesh(mesh: Mesh) Model;
pub extern fn IsModelReady(model: Model) bool;
pub extern fn UnloadModel(model: Model) void;
pub extern fn GetModelBoundingBox(model: Model) BoundingBox;
pub extern fn DrawModel(model: Model, position: Vector3, scale: f32, tint: Color) void;
pub extern fn DrawModelEx(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void;
pub extern fn DrawModelWires(model: Model, position: Vector3, scale: f32, tint: Color) void;
pub extern fn DrawModelWiresEx(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void;
pub extern fn DrawBoundingBox(box: BoundingBox, color: Color) void;
pub extern fn DrawBillboard(camera: Camera, texture: Texture2D, position: Vector3, size: f32, tint: Color) void;
pub extern fn DrawBillboardRec(camera: Camera, texture: Texture2D, source: Rectangle, position: Vector3, size: Vector2, tint: Color) void;
pub extern fn DrawBillboardPro(camera: Camera, texture: Texture2D, source: Rectangle, position: Vector3, up: Vector3, size: Vector2, origin: Vector2, rotation: f32, tint: Color) void;
pub extern fn UploadMesh(mesh: ?*Mesh, dynamic: bool) void;
pub extern fn UpdateMeshBuffer(mesh: Mesh, index: c_int, data: ?*const void, dataSize: c_int, offset: c_int) void;
pub extern fn UnloadMesh(mesh: Mesh) void;
pub extern fn DrawMesh(mesh: Mesh, material: Material, transform: Matrix) void;
pub extern fn DrawMeshInstanced(mesh: Mesh, material: Material, transforms: ?*const Matrix, instances: c_int) void;
pub extern fn ExportMesh(mesh: Mesh, fileName: ?*const u8) bool;
pub extern fn GetMeshBoundingBox(mesh: Mesh) BoundingBox;
pub extern fn GenMeshTangents(mesh: ?*Mesh) void;
pub extern fn GenMeshPoly(sides: c_int, radius: f32) Mesh;
pub extern fn GenMeshPlane(width: f32, length: f32, resX: c_int, resZ: c_int) Mesh;
pub extern fn GenMeshCube(width: f32, height: f32, length: f32) Mesh;
pub extern fn GenMeshSphere(radius: f32, rings: c_int, slices: c_int) Mesh;
pub extern fn GenMeshHemiSphere(radius: f32, rings: c_int, slices: c_int) Mesh;
pub extern fn GenMeshCylinder(radius: f32, height: f32, slices: c_int) Mesh;
pub extern fn GenMeshCone(radius: f32, height: f32, slices: c_int) Mesh;
pub extern fn GenMeshTorus(radius: f32, size: f32, radSeg: c_int, sides: c_int) Mesh;
pub extern fn GenMeshKnot(radius: f32, size: f32, radSeg: c_int, sides: c_int) Mesh;
pub extern fn GenMeshHeightmap(heightmap: Image, size: Vector3) Mesh;
pub extern fn GenMeshCubicmap(cubicmap: Image, cubeSize: Vector3) Mesh;
pub extern fn LoadMaterials(fileName: ?*const u8, materialCount: ?*c_int) ?*Material;
pub extern fn LoadMaterialDefault() Material;
pub extern fn IsMaterialReady(material: Material) bool;
pub extern fn UnloadMaterial(material: Material) void;
pub extern fn SetMaterialTexture(material: ?*Material, mapType: c_int, texture: Texture2D) void;
pub extern fn SetModelMeshMaterial(model: ?*Model, meshId: c_int, materialId: c_int) void;
pub extern fn LoadModelAnimations(fileName: ?*const u8, animCount: ?*c_uint) ?*ModelAnimation;
pub extern fn UpdateModelAnimation(model: Model, anim: ModelAnimation, frame: c_int) void;
pub extern fn UnloadModelAnimation(anim: ModelAnimation) void;
pub extern fn UnloadModelAnimations(animations: ?*ModelAnimation, count: c_uint) void;
pub extern fn IsModelAnimationValid(model: Model, anim: ModelAnimation) bool;
pub extern fn CheckCollisionSpheres(center1: Vector3, radius1: f32, center2: Vector3, radius2: f32) bool;
pub extern fn CheckCollisionBoxes(box1: BoundingBox, box2: BoundingBox) bool;
pub extern fn CheckCollisionBoxSphere(box: BoundingBox, center: Vector3, radius: f32) bool;
pub extern fn GetRayCollisionSphere(ray: Ray, center: Vector3, radius: f32) RayCollision;
pub extern fn GetRayCollisionBox(ray: Ray, box: BoundingBox) RayCollision;
pub extern fn GetRayCollisionMesh(ray: Ray, mesh: Mesh, transform: Matrix) RayCollision;
pub extern fn GetRayCollisionTriangle(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3) RayCollision;
pub extern fn GetRayCollisionQuad(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3, p4: Vector3) RayCollision;
pub extern fn InitAudioDevice() void;
pub extern fn CloseAudioDevice() void;
pub extern fn IsAudioDeviceReady() bool;
pub extern fn SetMasterVolume(volume: f32) void;
pub extern fn LoadWave(fileName: ?*const u8) Wave;
pub extern fn LoadWaveFromMemory(fileType: ?*const u8, fileData: ?*const u8, dataSize: c_int) Wave;
pub extern fn IsWaveReady(wave: Wave) bool;
pub extern fn LoadSound(fileName: ?*const u8) Sound;
pub extern fn LoadSoundFromWave(wave: Wave) Sound;
pub extern fn IsSoundReady(sound: Sound) bool;
pub extern fn UpdateSound(sound: Sound, data: ?*const void, sampleCount: c_int) void;
pub extern fn UnloadWave(wave: Wave) void;
pub extern fn UnloadSound(sound: Sound) void;
pub extern fn ExportWave(wave: Wave, fileName: ?*const u8) bool;
pub extern fn ExportWaveAsCode(wave: Wave, fileName: ?*const u8) bool;
pub extern fn PlaySound(sound: Sound) void;
pub extern fn StopSound(sound: Sound) void;
pub extern fn PauseSound(sound: Sound) void;
pub extern fn ResumeSound(sound: Sound) void;
pub extern fn IsSoundPlaying(sound: Sound) bool;
pub extern fn SetSoundVolume(sound: Sound, volume: f32) void;
pub extern fn SetSoundPitch(sound: Sound, pitch: f32) void;
pub extern fn SetSoundPan(sound: Sound, pan: f32) void;
pub extern fn WaveCopy(wave: Wave) Wave;
pub extern fn WaveCrop(wave: ?*Wave, initSample: c_int, finalSample: c_int) void;
pub extern fn WaveFormat(wave: ?*Wave, sampleRate: c_int, sampleSize: c_int, channels: c_int) void;
pub extern fn LoadWaveSamples(wave: Wave) ?*f32;
pub extern fn UnloadWaveSamples(samples: ?*f32) void;
pub extern fn LoadMusicStream(fileName: ?*const u8) Music;
pub extern fn LoadMusicStreamFromMemory(fileType: ?*const u8, data: ?*const u8, dataSize: c_int) Music;
pub extern fn IsMusicReady(music: Music) bool;
pub extern fn UnloadMusicStream(music: Music) void;
pub extern fn PlayMusicStream(music: Music) void;
pub extern fn IsMusicStreamPlaying(music: Music) bool;
pub extern fn UpdateMusicStream(music: Music) void;
pub extern fn StopMusicStream(music: Music) void;
pub extern fn PauseMusicStream(music: Music) void;
pub extern fn ResumeMusicStream(music: Music) void;
pub extern fn SeekMusicStream(music: Music, position: f32) void;
pub extern fn SetMusicVolume(music: Music, volume: f32) void;
pub extern fn SetMusicPitch(music: Music, pitch: f32) void;
pub extern fn SetMusicPan(music: Music, pan: f32) void;
pub extern fn GetMusicTimeLength(music: Music) f32;
pub extern fn GetMusicTimePlayed(music: Music) f32;
pub extern fn LoadAudioStream(sampleRate: c_uint, sampleSize: c_uint, channels: c_uint) AudioStream;
pub extern fn IsAudioStreamReady(stream: AudioStream) bool;
pub extern fn UnloadAudioStream(stream: AudioStream) void;
pub extern fn UpdateAudioStream(stream: AudioStream, data: ?*const void, frameCount: c_int) void;
pub extern fn IsAudioStreamProcessed(stream: AudioStream) bool;
pub extern fn PlayAudioStream(stream: AudioStream) void;
pub extern fn PauseAudioStream(stream: AudioStream) void;
pub extern fn ResumeAudioStream(stream: AudioStream) void;
pub extern fn IsAudioStreamPlaying(stream: AudioStream) bool;
pub extern fn StopAudioStream(stream: AudioStream) void;
pub extern fn SetAudioStreamVolume(stream: AudioStream, volume: f32) void;
pub extern fn SetAudioStreamPitch(stream: AudioStream, pitch: f32) void;
pub extern fn SetAudioStreamPan(stream: AudioStream, pan: f32) void;
pub extern fn SetAudioStreamBufferSizeDefault(size: c_int) void;
pub extern fn SetAudioStreamCallback(stream: AudioStream, callback: AudioCallback) void;
pub extern fn AttachAudioStreamProcessor(stream: AudioStream, processor: AudioCallback) void;
pub extern fn DetachAudioStreamProcessor(stream: AudioStream, processor: AudioCallback) void;
pub extern fn AttachAudioMixedProcessor(processor: AudioCallback) void;
pub extern fn DetachAudioMixedProcessor(processor: AudioCallback) void;
