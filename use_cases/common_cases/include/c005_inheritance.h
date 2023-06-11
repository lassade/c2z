struct vec2_t {
    float x;
    float y;
};

struct shape_t {
public:
    vec2_t aabb;
    virtual float area() const = 0;
};

struct circle_t: public shape_t {
public:
    circle_t();
    circle_t(float radius);
    ~circle_t();
    virtual float area() const;

private:
    float radius;
};

float area(const shape_t &shape);