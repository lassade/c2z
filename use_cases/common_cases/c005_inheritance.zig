pub const vec2_t = extern struct {
    x: f32,
    y: f32,
};

pub const shape_t = extern struct {
    vtable: *const anyopaque,

    aabb: vec2_t,

    extern fn _ZNK7shape_t4areaEv(self: *const shape_t) f32;
    pub const area = _ZNK7shape_t4areaEv;
};

pub const circle_t = extern struct {
    base: shape_t,

    radius: f32,

    // extern fn _ZN8circle_tC1Ef(self: *circle_t) void;
    // pub inline fn init() circle_t {
    //     // might cause UB if the ctor takes refereces to self
    //     var self: circle_t = undefined;
    //     _ZN8circle_tC1Ef(&self);
    //     return self;
    // }

    extern fn _ZN8circle_tD1Ev(self: *circle_t) void;
    pub inline fn deinit(self: *circle_t) void {
        self._ZN8circle_tD1Ev();
    }

    extern fn _ZNK8circle_t4areaEv(self: *const circle_t) f32;
    pub const area = _ZNK8circle_t4areaEv;
};

extern fn _Z4areaRK7shape_t(shape: [*c]const shape_t) f32;
pub const area = _Z4areaRK7shape_t;
