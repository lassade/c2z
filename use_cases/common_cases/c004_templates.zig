pub fn Vector(comptime T: type) type {
    return extern struct {
        Data: ?*T,
        Size: c_int,
        Capacity: c_int,
    };
}

