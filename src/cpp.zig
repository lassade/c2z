//! zig c++ interop types and utilities

const std = @import("std");
const builtin = @import("builtin");

/// Switch by linux target triple, usage:
/// ```zig
/// const size_t = targetSwitch(type, .{
///     .{ "x86_64-windows-gnu", c_ulonglong },
///     .{ "x86_64-linux-gnu", c_ulong },
/// });
/// ```
pub fn targetSwitch(
    comptime T: type,
    comptime lookup: anytype,
) T {
    var buffer: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    var tuple = builtin.target.linuxTriple(fba.allocator()) catch unreachable;
    for (lookup) |entry| {
        if (std.mem.eql(u8, entry[0], tuple)) {
            return entry[1];
        }
    }

    @compileError("target `" ++ tuple ++ "` not listed");
}

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

/// basic `std::vector` compatible type, it doesn't free items
pub fn Vector(comptime T: type) type {
    return VectorAlloc(T, Allocator(T), .{});
}

/// base type for any `std::vector` derived type  with a custom allocator type and other configurations, it doesn't free items
pub fn VectorAlloc(
    comptime T: type,
    comptime Alloc: type,
    comptime config: struct {
        /// support `msvc`, requires at least `-O1` to work
        msvc: bool = builtin.abi == .msvc,
    },
) type {
    const Data = if (config.msvc)
        // requires at least -O1 to work
        extern struct { allocator: Alloc, head: ?*T = null, tail: ?*T = null, limit: ?*T = null }
    else
        extern struct { head: ?*T = null, tail: ?*T = null, limit: ?*T = null, allocator: Alloc };

    return extern struct {
        const Self = @This();

        data: Data,

        pub fn init(allocator: Alloc) Self {
            return .{ .data = .{ .allocator = allocator } };
        }

        pub inline fn size(self: *const Self) usize {
            return (@ptrToInt(self.data.tail) - @ptrToInt(self.data.head));
        }

        pub inline fn capacity(self: *const Self) usize {
            return (@ptrToInt(self.data.limit) - @ptrToInt(self.data.head));
        }

        pub inline fn values(self: *Self) []T {
            return if (self.data.head) |head| @ptrCast([*]T, head)[0..self.size()] else &[_]T{};
        }

        pub fn deinit(self: *Self) void {
            if (self.data.head) |head| {
                self.data.allocator.deallocate(head, self.size());

                self.data.head = null;
                self.data.tail = null;
                self.data.limit = null;
            }
        }
    };
}

/// just use `[N]T`
pub fn Array(
    comptime T: type,
    comptime N: comptime_int,
) type {
    return @Type([N]T);
}

/// drop-in replacement for `std::string`
pub fn String() type {
    return Vector(c_char);
}

/// similar to `std::basic_string<char, std::char_traits<char>, Alloc>`
pub fn StringAlloc(comptime Alloc: type) type {
    return VectorAlloc(c_char, Alloc, .{});
}

// todo: UniquePtr, SharedPtr
