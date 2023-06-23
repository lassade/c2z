//! zig c++ interop types

const std = @import("std");

/// default stateless allocator, uses `malloc` and `free` internally
pub fn Allocator(comptime T: type) type {
    return extern struct {
        const Self = @This();

        pub fn allocate(self: *Self, size: usize) !*T {
            _ = self;
            if (@ptrCast(?*T, std.c.malloc(@sizeOf(T) * size))) |ptr| {
                return ptr;
            } else {
                return std.mem.Allocator.Error.OutOfMemory;
            }
        }

        pub fn deallocate(self: *Self, ptr: *T, size: usize) void {
            _ = self;
            _ = size;
            std.c.free(ptr);
        }
    };
}

/// basic std::vector with the default allocator
pub fn AutoVector(comptime T: type) type {
    return Vector(T, Allocator(T));
}

/// basic std::vector
pub fn Vector(
    comptime T: type,
    comptime Alloc: type,
) type {
    // todo: custom allocator
    return extern struct {
        const Self = @This();

        head: ?*T = null,
        tail: ?*T = null,
        end: ?*T = null,

        allocator: Alloc = .{},

        pub fn init() Self {
            return .{};
        }

        pub inline fn size(self: *const Self) usize {
            return (@ptrToInt(self.tail) - @ptrToInt(self.head));
        }

        pub inline fn capacity(self: *const Self) usize {
            return (@ptrToInt(self.end) - @ptrToInt(self.head));
        }

        pub inline fn values(self: *Self) []T {
            if (self.head) |head| {
                return @ptrCast([*]T, head)[0..self.size()];
            } else {
                return &[_]T{};
            }
        }

        pub fn deinit(self: *Self) void {
            if (self.head) |head| {
                self.allocator.deallocate(head, self.size());

                self.head = null;
                self.tail = null;
                self.end = null;
            }
        }
    };
}
