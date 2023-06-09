pub const vec2_t = extern struct {
    x: f32,
    y: f32,
};

extern fn _Z3add6vec2_tS_(a: vec2_t, b: vec2_t) vec2_t;
pub const add = _Z3add6vec2_tS_;

