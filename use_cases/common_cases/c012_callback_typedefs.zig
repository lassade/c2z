const std = @import("std");

pub const ImGuiInputTextCallback = ?*const fn ([*c]ImGuiInputTextCallbackData) callconv(.C) c_int;

pub const ImGuiSizeCallback = ?*const fn ([*c]ImGuiSizeCallbackData) callconv(.C) void;

pub const ImGuiMemAllocFunc = ?*const fn (c_int, ?*anyopaque) callconv(.C) ?*anyopaque;

pub const ImGuiMemFreeFunc = ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void;
