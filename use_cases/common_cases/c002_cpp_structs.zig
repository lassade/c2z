pub const vec2_t = extern struct {
    extern const _ZN6vec2_t5sZeroE: vec2_t;
    pub inline fn sZero() vec2_t {
        return _ZN6vec2_t5sZeroE;
    }

    x: f32,
    y: f32,

    extern fn _ZNK6vec2_t3addES_(self: *const vec2_t, other: vec2_t) vec2_t;
    pub const add = _ZNK6vec2_t3addES_;
};

pub const Vec2 = vec2_t;
