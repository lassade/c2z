#include "c013_cpp_vector.h"

bool enumerate(std::vector<uint8_t>& out_buf, size_t count) {
    for (size_t i = 0; i < count; i++)
    {
        out_buf.push_back(i);
    }
    return true;
}
