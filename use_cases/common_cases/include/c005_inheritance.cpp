#include "c005_inheritance.h"

circle_t::circle_t(float radius) {
    this->radius = radius;
}

float circle_t::area() const {
    return 3.14 * radius * radius;
}

circle_t circle(float radius) {
    return circle_t(radius);
}

float area(const shape_t &shape) {
    return shape.area();
}