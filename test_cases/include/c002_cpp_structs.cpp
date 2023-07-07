#include "c002_cpp_structs.h"

const vec2_t vec2_t::sZero = { 0, 0 };

vec2_t vec2_t::add(vec2_t other) const {
    return vec2_t { this->x + other.x, this->y + other.y };
}