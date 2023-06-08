typedef struct {
    float x;
    float y;
} Vec2;

struct f32x2 {
    float x;
    float y;
    f32x2 add(f32x2 other);
};

typedef f32x2 F32x2;

template<typename T>
struct Tx2 {
    T x;
    T y;
    inline Tx2<T> add(Tx2<T> other) {  Tx2<T> v; v.x = x + other.x; v.y = y + other.y; return v; }
};
