const std = @import("std");

pub const NoArgsCallback = ?*const fn () callconv(.C) c_int;

pub const SingleLetterCallback = ?*const fn (a) callconv(.C) c_int;

pub const NamedParam = ?*const fn ([*c]const SomeStruct) callconv(.C) void;

pub const ImGuiInputTextCallback = ?*const fn ([*c]ImGuiInputTextCallbackData) callconv(.C) c_int;

pub const ImGuiSizeCallback = ?*const fn ([*c]ImGuiSizeCallbackData) callconv(.C) void;

pub const ImGuiMemAllocFunc = ?*const fn (usize, ?*anyopaque) callconv(.C) ?*anyopaque;

pub const ImGuiMemFreeFunc = ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void;

// opaques
const a = anyopaque;
const SomeStruct = anyopaque;
const ImGuiInputTextCallbackData = anyopaque;
const ImGuiSizeCallbackData = anyopaque;
