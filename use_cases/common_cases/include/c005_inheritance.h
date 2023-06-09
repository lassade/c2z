struct vec2_t {
    float x;
    float y;
};

class shape_t {
public:
    vec2_t aabb;
    virtual float area() const = 0;
};

class circle_t: public shape_t {
public:
    virtual float area() const = 0;

private:
    float radius;
};