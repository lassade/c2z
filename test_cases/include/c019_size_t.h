#include <stdint.h>
#include <stddef.h>

struct A {
    size_t a;
	static const A sA;

    A(int a);
    A(size_t a);
    ~A() {}

    void foo(size_t b);
    size_t boo();
};