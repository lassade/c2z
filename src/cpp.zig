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

extern fn malloc(usize) ?*anyopaque;
extern fn free(?*anyopaque) void;

/// default stateless allocator, uses `malloc` and `free` internally
pub fn Allocator(comptime T: type) type {
    return extern struct {
        const Self = @This();

        pub fn allocate(self: *Self, size: usize) !*T {
            _ = self;
            if (@ptrCast(?*T, malloc(@sizeOf(T) * size))) |ptr| {
                return ptr;
            } else {
                return std.mem.Allocator.Error.OutOfMemory;
            }
        }

        pub fn deallocate(self: *Self, ptr: *T, size: usize) void {
            _ = self;
            _ = size;
            free(ptr);
        }
    };
}

pub const native = switch (builtin.abi) {
    .msvc => msvc,
    else => gnu,
};

pub const msvc = struct {
    /// MSVC `_Container_base12`, it might be used in debug builds to invalidate iterators
    const Container =
        if (builtin.mode == .Debug)
        extern struct {
            const Self = @This();

            const Iter = extern struct {
                proxy: ?*const ContainerProxy = null,
                next: ?*Iter = null,
            };

            const ContainerProxy = extern struct {
                cont: ?*const Self = null,
                iter: ?*Iter = null,
            };

            proxy: ?*ContainerProxy,

            pub fn init() Self {
                var proxy = @ptrCast(?*ContainerProxy, @alignCast(8, malloc(@sizeOf(ContainerProxy))));
                proxy.?.* = .{};
                return .{ .proxy = proxy };
            }

            pub fn deinit(self: *Self) void {
                _ = self;
                // todo: to free it you must walk the linked list
                // todo: can't use `free(self.proxy);` on String
                // todo: test if will leak memory when passing containers between ffi bounds
            }
        }
    else
        extern struct {
            const Self = @This();

            pub fn init() Self {
                return .{};
            }
            pub fn deinit(_: *Self) void {}
        };

    /// basic `std::vector` compatible type, it doesn't free items
    pub fn Vector(comptime T: type) type {
        return msvc.VectorRaw(T, Allocator(T));
    }

    /// base type for any `std::vector` derived type  with a custom allocator type and other configurations, it doesn't free items
    pub fn VectorRaw(comptime T: type, comptime Alloc: type) type {
        return extern struct {
            const Self = @This();

            __proxy: Container,
            allocator: Alloc,
            head: ?*T = null,
            tail: ?*T = null,
            limit: ?*T = null,

            pub fn init(allocator: Alloc) Self {
                return .{
                    .__proxy = Container.init(),
                    .allocator = allocator,
                };
            }

            pub inline fn size(self: *const Self) usize {
                return (@ptrToInt(self.tail) - @ptrToInt(self.head));
            }

            pub inline fn capacity(self: *const Self) usize {
                return (@ptrToInt(self.limit) - @ptrToInt(self.head));
            }

            pub inline fn values(self: Self) []T {
                return if (self.head) |head| @ptrCast([*]T, head)[0..self.size()] else &[_]T{};
            }

            pub fn deinit(self: *Self) void {
                if (self.head) |head| {
                    self.allocator.deallocate(head, self.size());

                    self.head = null;
                    self.tail = null;
                    self.limit = null;
                }
                self.__proxy.deinit();
            }
        };
    }

    /// drop-in replacement for `std::string`
    pub const String = msvc.StringRaw(Allocator(u8));

    /// similar to `std::basic_string<char, std::char_traits<char>, Alloc>`
    pub fn StringRaw(comptime Alloc: type) type {
        const Heap = extern struct {
            ptr: [*]u8,
            __payload: usize,
        };

        const Data = extern union {
            in_place: [@sizeOf(Heap)]u8,
            heap: Heap,
        };

        return extern struct {
            const Self = @This();

            __proxy: Container,
            allocator: Alloc,
            data: Data,
            len: usize,
            cap: usize,

            pub fn init(allocator: Alloc) Self {
                return .{
                    .__proxy = Container.init(),
                    .allocator = allocator,
                    .data = undefined,
                    .len = 0,
                    .cap = @sizeOf(Heap) - 1,
                };
            }

            inline fn inHeap(self: *const Self) bool {
                return self.cap > (@sizeOf(Heap) - 1);
            }

            pub inline fn size(self: *const Self) usize {
                return self.len;
            }

            pub inline fn capacity(self: *const Self) usize {
                return self.cap;
            }

            pub inline fn values(self: *Self) []u8 {
                return if (self.inHeap())
                    self.data.heap.ptr[0..self.len]
                else
                    self.data.in_place[0..self.len];
            }

            pub fn deinit(self: *Self) void {
                if (self.inHeap()) {
                    self.allocator.deallocate(@ptrCast(*u8, self.data.heap.ptr), self.cap);
                    self.data.in_place[0] = 0;
                }
                self.__proxy.deinit();
            }
        };
    }
};

pub const gnu = struct {
    /// basic `std::vector` compatible type, it doesn't free items
    pub fn Vector(comptime T: type) type {
        return gnu.VectorRaw(T, Allocator(T));
    }

    /// base type for any `std::vector` derived type  with a custom allocator type and other configurations, it doesn't free items
    pub fn VectorRaw(comptime T: type, comptime Alloc: type) type {
        return extern struct {
            const Self = @This();

            head: ?*T = null,
            tail: ?*T = null,
            limit: ?*T = null,
            allocator: Alloc,

            pub fn init(allocator: Alloc) Self {
                return .{ .allocator = allocator };
            }

            pub inline fn size(self: *const Self) usize {
                return (@ptrToInt(self.tail) - @ptrToInt(self.head));
            }

            pub inline fn capacity(self: *const Self) usize {
                return (@ptrToInt(self.limit) - @ptrToInt(self.head));
            }

            pub inline fn values(self: Self) []T {
                return if (self.head) |head| @ptrCast([*]T, head)[0..self.size()] else &[_]T{};
            }

            pub fn deinit(self: *Self) void {
                if (self.head) |head| {
                    self.allocator.deallocate(head, self.size());

                    self.head = null;
                    self.tail = null;
                    self.limit = null;
                }
            }
        };
    }

    /// drop-in replacement for `std::string`
    pub const String = gnu.StringRaw(Allocator(u8));

    /// similar to `std::basic_string<char, std::char_traits<char>, Alloc>`
    pub fn StringRaw(comptime Alloc: type) type {
        const Heap = extern struct {
            cap: usize,
            len: usize,
            ptr: [*]u8,
        };

        const Data = extern union {
            in_place: [@sizeOf(Heap)]u8,
            heap: Heap,
        };

        return extern struct {
            const Self = @This();

            data: Data,
            allocator: Alloc,

            pub fn init(allocator: Alloc) Self {
                return Self{
                    .data = Data{ .in_place = [_]u8{0} ** @sizeOf(Heap) },
                    .allocator = allocator,
                };
            }

            inline fn inHeap(self: *const Self) bool {
                return (self.data.in_place[0] & 1) != 0;
            }

            pub inline fn size(self: *const Self) usize {
                return if (self.inHeap()) self.data.heap.len else (self.data.in_place[0] >> 1);
            }

            pub inline fn capacity(self: *const Self) usize {
                return if (self.inHeap())
                    self.data.heap.cap
                else
                    // in_place[0] >> 1 == length and in_place[in_place.len - 1] == '\0'
                    @sizeOf(Heap) - 2;
            }

            pub inline fn values(self: *Self) []u8 {
                return if (self.inHeap())
                    self.data.heap.ptr[0..self.data.heap.len]
                else
                    self.data.in_place[1 .. (self.data.in_place[0] >> 1) + 1];
            }

            pub fn deinit(self: *Self) void {
                if (self.inHeap()) {
                    self.allocator.deallocate(@ptrCast(*u8, self.data.heap.ptr), self.data.heap.cap);
                    self.data.in_place[0] = 0;
                }
            }
        };
    }
};

// todo: try std::array in msvc, I think it works differently in debug
/// just use `[N]T`
pub fn Array(
    comptime T: type,
    comptime N: comptime_int,
) type {
    return @Type([N]T);
}

pub const Vector = native.Vector;
pub const VectorRaw = native.VectorRaw;

pub const String = native.String;
pub const StringRaw = native.StringRaw;

// todo: UniquePtr, SharedPtr
