#include "c013_cpp_vector.h"

std::vector<uint8_t> create()
{
    auto tmp = std::vector<uint8_t>();
    tmp.push_back(0);
    tmp.push_back(1);
    tmp.push_back(2);
    return tmp;
}

size_t sizeof_vector_uint8_t()
{
    return sizeof(std::vector<uint8_t>);
}

const uint8_t *vector_data(const std::vector<uint8_t> &vec)
{
    return vec.data();
}

size_t vector_size(const std::vector<uint8_t> &vec)
{
    return vec.size();
}

size_t vector_capacity(const std::vector<uint8_t> &vec)
{
    return vec.capacity();
}

bool enumerate(std::vector<uint8_t>& out_buf, size_t count)
{
    for (size_t i = 0; i < count; i++)
    {
        out_buf.push_back(i);
    }
    return true;
}
