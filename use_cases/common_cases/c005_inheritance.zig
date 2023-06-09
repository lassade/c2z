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

extern fn _Z6circlef(radius: f32) circle_t;
pub const circle = _Z6circlef;

extern fn _Z4areaRK7shape_t(shape: [*c]const shape_t) f32;
pub const area = _Z4areaRK7shape_t;
