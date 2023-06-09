struct vec2_t {
    static const vec2_t sZero;

    float x;
    float y;
    vec2_t add(vec2_t other) const;
};

typedef vec2_t Vec2;