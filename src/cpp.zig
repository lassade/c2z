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

/// MSVC proxy iterator, my guess is that is used in debug builds to invalidate iterators, look for `_MyProxy` in `xmemory`
const ProxyIter = 
    if (builtin.mode == .Debug)
        extern struct {
            const Self = @This();

            const ContainerProxy = struct {
                cont: ?*const anyopaque = null,
                first_iter: ?*anyopaque = null,
            };

            container: ?*ContainerProxy = null,
            
            pub fn init() Self {
                var container = @ptrCast(?*ContainerProxy, @alignCast(8, malloc(@sizeOf(ContainerProxy))));
                container.?.* = .{};
                return .{ .container = container };
            }

            pub fn deinit(self: *Self) void { 
                // todo: test if will leak memory when passing containers between ffi bounds
                free(self.container);
            }
        }
    else
        extern struct {
            const Self = @This();

            pub fn init() Self { return .{}; }
            pub fn deinit(_: *Self) void {}
        };

/// basic `std::vector` compatible type, it doesn't free items
pub fn Vector(comptime T: type) type {
    return VectorRaw(T, Allocator(T), .{});
}

/// base type for any `std::vector` derived type  with a custom allocator type and other configurations, it doesn't free items
pub fn VectorRaw(
    comptime T: type,
    comptime Alloc: type,
    comptime config: struct {
        /// support `msvc`, requires at least `-O1` to work
        msvc: bool = builtin.abi == .msvc,
    },
) type {
    const Data = if (config.msvc)
        extern struct { __proxy: ProxyIter, allocator: Alloc, head: ?*T = null, tail: ?*T = null, limit: ?*T = null, }
    else
        extern struct { head: ?*T = null, tail: ?*T = null, limit: ?*T = null, allocator: Alloc, };

    return extern struct {
        const Self = @This();

        data: Data,

        pub fn init(allocator: Alloc) Self {
            var self: Self = undefined;
            if (config.msvc) self.data.__proxy = ProxyIter.init();
            self.data.allocator = allocator;
            self.data.head = null;
            self.data.tail = null;
            self.data.limit = null;
            return self;
        }

        pub inline fn size(self: *const Self) usize {
            return (@ptrToInt(self.data.tail) - @ptrToInt(self.data.head));
        }

        pub inline fn capacity(self: *const Self) usize {
            return (@ptrToInt(self.data.limit) - @ptrToInt(self.data.head));
        }

        pub inline fn values(self: Self) []T {
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

// todo: cpp.String uses a inline string

/// drop-in replacement for `std::string`
pub const String = StringRaw(Allocator(u8), .{});

/// similar to `std::basic_string<char, std::char_traits<char>, Alloc>`
pub fn StringRaw(
    comptime Alloc: type,
    comptime config: struct {
        /// support `msvc`, requires at least `-O1` to work
        msvc: bool = builtin.abi == .msvc,
    },
) type {
    if (config.msvc) {
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

            __proxy: ProxyIter,
            allocator: Alloc,
            data: Data,
            len: usize,
            cap: usize,

            pub fn init(allocator: Alloc) Self {
                var self: Self = undefined;
                if (config.msvc) self.__proxy = ProxyIter.init();
                self.allocator = allocator;
                self.data = undefined;
                self.len = 0;
                self.cap = @sizeOf(Heap) - 1;
                return self;
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
            }
        };
    } else {
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
}

// todo: UniquePtr, SharedPtr
