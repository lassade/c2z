// auto-generated

#include "include/c005_inheritance.h"

struct shape_tZimpl: public shape_t {
public:
    float (*area_callback)(const void*) = nullptr;

    virtual float area() const {
        if (area_callback == nullptr) return shape_t::area();
        else return area_callback((void*)this);
    }
};