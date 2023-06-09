pub fn Vector(comptime T: type) type {
    return extern struct {
        data: ?*T,
        size: c_int,
        capacity: c_int,
    };
}

