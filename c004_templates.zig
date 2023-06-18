pub fn Vector(comptime T: type) type {
    return extern struct {
        const Self = @This();

        Data: ?*T,
        Size: c_int,
        Capacity: c_int,

        pub inline fn empty(self: *const Self) bool {
            return (@as(c_int, self.Size) == 0);
        }
        pub inline fn size(self: *const Self) c_int {
            return @as(c_int, self.Size);
        }
        pub inline fn size_in_bytes(self: *const Self) c_int {
            return (@as(c_int, self.Size) * @as(c_int, @sizeOf(T)));
        }
        pub inline fn getPointer(self: *Self, i: c_int) ?*T {
            return self.Data[i];
        }
        pub inline fn getValue(self: *const Self, i: c_int) ?*const T {
            return self.Data[i];
        }
    };
}
