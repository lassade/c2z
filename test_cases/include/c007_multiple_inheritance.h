// pub const shape_t = extern struct {
//     vtable: *const anyopaque,
//     id: c_int,
// };
struct shape_t {
public:
    int id;
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
//     base1: renderable_t, // polymorphic classes always start frist, despite the declaration order
//     base0: shape_t,
//     radius: f32,
// }
struct circle_t: public shape_t, public renderable_t {
public:
    float radius;
    virtual float render() const;
    virtual float area() const;
}; 