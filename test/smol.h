// typedef struct {
//     float x;
//     float y;
// } cVec2;

// cVec2 vec2_add(cVec2 a, cVec2 b);
// cVec2 vec2_sub(cVec2 a, cVec2 b);

struct Vec2 {
    float x;
    float y;
    Vec2 add(Vec2 other);
    Vec2 sub(Vec2 other);
};

// template<typename T>
// struct Vec2T {
//     T x;
//     T y;
//     Vec2T<T> add(Vec2T<T> other);
//     Vec2T<T> sub(Vec2T<T> other);
// };
