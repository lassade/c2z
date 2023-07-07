// pub const shape_t = extern struct {
//     vtable: *const anyopaque,
//     id: c_int,
// };
struct shape_t {
public:
    int id;
    virtual float area() const = 0;
};

// pub const renderable_t = extern struct {
//     vtable: *const anyopaque,
//     mat: c_int,
// };
struct renderable_t {
public:
    int mat;
    virtual float render() const = 0;
};

// pub const circle_t = extern struct {
//     base0: shape_t,
//     base1: renderable_t,
//     radius: f32,
// }
struct circle_t: public shape_t, public renderable_t {
public:
    float radius;
    virtual float render() const;
    virtual float area() const;
}; 