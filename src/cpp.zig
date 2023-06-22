/// basic std::vector, read only
pub fn Vector(comptime T: type) type {
    return extern struct {
        const Self = @This();

        head: ?*T = null,
        tail: ?*T = null,
        end: ?*T = null,

        pub fn init() Self {
            return .{};
        }

        pub fn slice(self: *Self) []T {
            return if (self.head) |head| head[0..(self.tail.? - head)] orelse .{};
        }

        pub fn deinit(self: *Self) void {
            // todo: cast into a std::vector<u8> and free it
            _ = self;
            @panic("deinit std::vector");
        }
    };
}
