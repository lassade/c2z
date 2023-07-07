#include "c005_inheritance.h"

circle_t::circle_t() { this->radius = 0; }
circle_t::circle_t(float radius) { this->radius = radius; }
circle_t::~circle_t() { }
float circle_t::area() const { return 3.14 * radius * radius; }


float area(const shape_t &shape) {
    return shape.area();
}