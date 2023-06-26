//! zig c++ interop types

const std = @import("std");

/// optional c enumeration extension functions
pub fn FlagsMixin(comptime FlagsType: type) type {
    return struct {
        pub const IntType = @typeInfo(FlagsType).Struct.fields[0].type;
        pub inline fn init(flags: IntType) FlagsType {
            return .{ .bits = flags };
        }
        pub inline fn merge(lhs: FlagsType, rhs: FlagsType) FlagsType {
            return init(lhs.bits | rhs.bits);
        }
        pub inline fn intersect(lhs: FlagsType, rhs: FlagsType) FlagsType {
            return init(lhs.bits & rhs.bits);
        }
        pub inline fn complement(self: FlagsType) FlagsType {
            return init(~self.bits);
        }
        pub inline fn subtract(lhs: FlagsType, rhs: FlagsType) FlagsType {
            return init(lhs.bits & rhs.complement().bits);
        }
        pub inline fn contains(lhs: FlagsType, rhs: FlagsType) bool {
            return intersect(lhs, rhs).bits == rhs.bits;
        }
    };
}

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

/// basic std::vector compatible type, it doesn't free items
pub fn Vector(comptime T: type) type {
    return VectorAlloc(T, Allocator(T));
}

/// basic std::vector with a custom allocator type, it doesn't free items
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
            return @as(usize, self.tail.?.* - self.head.?.*);
        }

        pub inline fn capacity(self: *const Self) usize {
            return @as(usize, self.end.?.* - self.head.?.*);
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
