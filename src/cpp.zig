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

/// basic std::vector
pub fn Vector(comptime T: type) type {
    return VectorAlloc(T, Allocator(T));
}

/// basic std::vector with a custom allocator type
pub fn VectorAlloc(
    comptime T: type,
    comptime Alloc: type,
) type {
    // todo: custom allocator
    return extern struct {
        const Self = @This();

        head: ?*T = null,
        tail: ?*T = null,
        end: ?*T = null,

        allocator: Alloc,

        pub fn init(allocator: Alloc) Self {
            return .{ .allocator = allocator };
        }

        pub inline fn size(self: *const Self) usize {
            return (@ptrToInt(self.tail) - @ptrToInt(self.head));
        }

        pub inline fn capacity(self: *const Self) usize {
            return (@ptrToInt(self.end) - @ptrToInt(self.head));
        }

        pub inline fn values(self: *Self) []T {
            return if (self.head) |head| @ptrCast([*]T, head)[0..self.size()] else &[_]T{};
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

// just use `[N]T`
pub fn Array(
    comptime T: type,
    comptime N: comptime_int,
) type {
    return @Type([N]T);
}

// todo: UniquePtr, SharedPtr, String
