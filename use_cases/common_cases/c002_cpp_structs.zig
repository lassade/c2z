pub const vec2_t = extern struct {
    x: f32,
    y: f32,

extern fn _ZN6vec2_t3addES_(self: *vec2_t, other: vec2_t) vec2_t;
pub const add = _ZN6vec2_t3addES_;

};

pub const Vec2 = vec2_t;

