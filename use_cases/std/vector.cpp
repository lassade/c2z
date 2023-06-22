#include <stdio.h>
#include <stdint.h>
#include <vector>

struct vector_layout {
    void* head;
    void* tail;
    void* end;
};

int main() {
    printf("vector\n");
    printf("size: %d -> %d\n", sizeof(std::vector<char>), sizeof(vector_layout));

    auto vec = std::vector<char>();
    // vec.push_back('a');
    // vec.push_back('b');
    // vec.push_back('c');
    auto layout = (vector_layout*)(&vec);

    printf("ptr: %p -> %p\n", vec.data(), layout->head);
    printf("size: %d -> %d\n", vec.size(), (size_t)layout->tail - (size_t)layout->head);
    printf("capacity: %d -> %d\n", vec.capacity(),  (size_t)layout->end - (size_t)layout->head);

    return 0;
}