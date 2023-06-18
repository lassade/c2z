const std = @import("std");

// auto generated

// pub const ConfigFlags = enum(c_int) {
//     FLAG_VSYNC_HINT = @intCast(c_uint, 64),
//     FLAG_FULLSCREEN_MODE = @intCast(c_uint, 2),
//     FLAG_WINDOW_RESIZABLE = @intCast(c_uint, 4),
//     FLAG_WINDOW_UNDECORATED = @intCast(c_uint, 8),
//     FLAG_WINDOW_HIDDEN = @intCast(c_uint, 128),
//     FLAG_WINDOW_MINIMIZED = @intCast(c_uint, 512),
//     FLAG_WINDOW_MAXIMIZED = @intCast(c_uint, 1024),
//     FLAG_WINDOW_UNFOCUSED = @intCast(c_uint, 2048),
//     FLAG_WINDOW_TOPMOST = @intCast(c_uint, 4096),
//     FLAG_WINDOW_ALWAYS_RUN = @intCast(c_uint, 256),
//     FLAG_WINDOW_TRANSPARENT = @intCast(c_uint, 16),
//     FLAG_WINDOW_HIGHDPI = @intCast(c_uint, 8192),
//     FLAG_WINDOW_MOUSE_PASSTHROUGH = @intCast(c_uint, 16384),
//     FLAG_MSAA_4X_HINT = @intCast(c_uint, 32),
//     FLAG_INTERLACED_HINT = @intCast(c_uint, 65536),
// };

// pub const ImGuiWindowFlags_ = enum(c_int) {
//     None = @intCast(c_uint, 0),
//     NoTitleBar = @intCast(c_uint, 1 << 0),
//     NoResize = @intCast(c_uint, 1 << 1),
//     NoMove = @intCast(c_uint, 1 << 2),
//     NoScrollbar = @intCast(c_uint, 1 << 3),
//     NoScrollWithMouse = @intCast(c_uint, 1 << 4),
//     NoCollapse = @intCast(c_uint, 1 << 5),
//     AlwaysAutoResize = @intCast(c_uint, 1 << 6),
//     NoBackground = @intCast(c_uint, 1 << 7),
//     NoSavedSettings = @intCast(c_uint, 1 << 8),
//     NoMouseInputs = @intCast(c_uint, 1 << 9),
//     MenuBar = @intCast(c_uint, 1 << 10),
//     HorizontalScrollbar = @intCast(c_uint, 1 << 11),
//     NoFocusOnAppearing = @intCast(c_uint, 1 << 12),
//     NoBringToFrontOnFocus = @intCast(c_uint, 1 << 13),
//     AlwaysVerticalScrollbar = @intCast(c_uint, 1 << 14),
//     AlwaysHorizontalScrollbar = @intCast(c_uint, 1 << 15),
//     AlwaysUseWindowPadding = @intCast(c_uint, 1 << 16),
//     NoNavInputs = @intCast(c_uint, 1 << 18),
//     NoNavFocus = @intCast(c_uint, 1 << 19),
//     UnsavedDocument = @intCast(c_uint, 1 << 20),
//     NoDocking = @intCast(c_uint, 1 << 21),
//     NoNav = @intCast(c_uint, ImGuiWindowFlags_.NoNavInputs | ImGuiWindowFlags_.NoNavFocus),
//     NoDecoration = @intCast(c_uint, ImGuiWindowFlags_.NoTitleBar | ImGuiWindowFlags_.NoResize | ImGuiWindowFlags_.NoScrollbar | ImGuiWindowFlags_.NoCollapse),
//     NoInputs = @intCast(c_uint, ImGuiWindowFlags_.NoMouseInputs | ImGuiWindowFlags_.NoNavInputs | ImGuiWindowFlags_.NoNavFocus),
//     NavFlattened = @intCast(c_uint, 1 << 23),
//     ChildWindow = @intCast(c_uint, 1 << 24),
//     Tooltip = @intCast(c_uint, 1 << 25),
//     Popup = @intCast(c_uint, 1 << 26),
//     Modal = @intCast(c_uint, 1 << 27),
//     ChildMenu = @intCast(c_uint, 1 << 28),
//     DockNodeHost = @intCast(c_uint, 1 << 29),
// };

// man made

// copied from https://github.com/Snektron/vulkan-zig
pub fn FlagsMixin(comptime FlagsType: type) type {
    return struct {
        pub const IntType = @typeInfo(FlagsType).Struct.backing_integer.?;
        pub fn toInt(self: FlagsType) IntType {
            return @bitCast(IntType, self);
        }
        pub fn fromInt(flags: IntType) FlagsType {
            return @bitCast(FlagsType, flags);
        }
        pub fn merge(lhs: FlagsType, rhs: FlagsType) FlagsType {
            return fromInt(toInt(lhs) | toInt(rhs));
        }
        pub fn intersect(lhs: FlagsType, rhs: FlagsType) FlagsType {
            return fromInt(toInt(lhs) & toInt(rhs));
        }
        pub fn complement(self: FlagsType) FlagsType {
            return fromInt(~toInt(self));
        }
        pub fn subtract(lhs: FlagsType, rhs: FlagsType) FlagsType {
            return fromInt(toInt(lhs) & toInt(rhs.complement()));
        }
        pub fn contains(lhs: FlagsType, rhs: FlagsType) bool {
            return toInt(intersect(lhs, rhs)) == toInt(rhs);
        }
    };
}

pub const ConfigFlags = packed struct(c_uint) {
    _reserved_bit_0: bool = false,
    fullscreen_mode: bool = false, // = @intCast(c_uint, 2),
    window_resizable: bool = false, // = @intCast(c_uint, 4),
    window_undecorated: bool = false, // = @intCast(c_uint, 8),
    window_transparent: bool = false, // = @intCast(c_uint, 16),
    msaa_4x_hint: bool = false, // = @intCast(c_uint, 32),
    vsync_hint: bool = false, // = @intCast(c_uint, 64),
    window_hidden: bool = false, // = @intCast(c_uint, 128),
    window_always_run: bool = false, // = @intCast(c_uint, 256),
    window_minimized: bool = false, // = @intCast(c_uint, 512),
    window_maximized: bool = false, // = @intCast(c_uint, 1024),
    window_unfocused: bool = false, // = @intCast(c_uint, 2048),
    window_topmost: bool = false, // = @intCast(c_uint, 4096),
    window_highdpi: bool = false, // = @intCast(c_uint, 8192),
    window_mouse_passthrough: bool = false, // = @intCast(c_uint, 16384),
    _reserved_bit_15: bool = false,
    interlaced_hint: bool = false, // = @intCast(c_uint, 65536),

    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,

    pub usingnamespace FlagsMixin(ConfigFlags);
};

pub const ImGuiWindowFlags = packed struct(c_uint) {
    NoTitleBar: bool = false,
    NoResize: bool = false,
    NoMove: bool = false,
    NoScrollbar: bool = false,
    NoScrollWithMouse: bool = false,
    NoCollapse: bool = false,
    AlwaysAutoResize: bool = false,
    NoBackground: bool = false,
    NoSavedSettings: bool = false,
    NoMouseInputs: bool = false,
    MenuBar: bool = false,
    HorizontalScrollbar: bool = false,
    NoFocusOnAppearing: bool = false,
    NoBringToFrontOnFocus: bool = false,
    AlwaysVerticalScrollbar: bool = false,
    AlwaysHorizontalScrollbar: bool = false,
    AlwaysUseWindowPadding: bool = false,
    _reserved_bit_17: bool = false,
    NoNavInputs: bool = false,
    NoNavFocus: bool = false,
    UnsavedDocument: bool = false,
    NoDocking: bool = false,
    _reserved_bit_22: bool = false,
    NavFlattened: bool = false,
    ChildWindow: bool = false,
    Tooltip: bool = false,
    Popup: bool = false,
    Modal: bool = false,
    ChildMenu: bool = false,
    DockNodeHost: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,

    pub const None: ImGuiWindowFlags = .{};
    pub const NoNav: ImGuiWindowFlags = .{ .NoNavInputs = true, .NoNavFocus = true };
    pub const NoDecoration: ImGuiWindowFlags = .{ .NoTitleBar = true, .NoResize = true, .NoScrollbar = true, .NoCollapse = true };
    pub const NoInputs: ImGuiWindowFlags = .{ .NoMouseInputs = true, .NoNavInputs = true, .NoNavFocus = true };

    pub usingnamespace FlagsMixin(ImGuiWindowFlags);
};
