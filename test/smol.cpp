
#include "smol.h"

Vec2 Vec2::add(Vec2 other) {
    return Vec2 {
        x = this->x + other.x,
        y = this->y + other.y,
    };
}

Vec2 Vec2::sub(Vec2 other) {
    return Vec2 {
        x = this->x - other.x,
        y = this->y - other.y,
    };
}