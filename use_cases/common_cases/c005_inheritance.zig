pub const vec2_t = extern struct {
    x: f32,
    y: f32,
};

pub const shape_t = extern struct {
    vtable: *const anyopaque, // manually added

    aabb: vec2_t,

    extern fn _ZNK7shape_t4areaEv(self: *const shape_t) f32;
    pub const area = _ZNK7shape_t4areaEv;
};

pub const circle_t = extern struct {
    base0: shape_t,

    radius: f32,

    extern fn _ZNK8circle_t4areaEv(self: *const circle_t) f32;
    pub const area = _ZNK8circle_t4areaEv;
};
