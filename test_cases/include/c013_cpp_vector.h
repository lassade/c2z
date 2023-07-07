#include <vector>

std::vector<uint8_t> create();
size_t sizeof_vector_uint8_t();
const uint8_t *vector_data(const std::vector<uint8_t> &vec);
size_t vector_size(const std::vector<uint8_t> &vec);
size_t vector_capacity(const std::vector<uint8_t> &vec);
bool enumerate(std::vector<uint8_t>& out_buf, size_t count);
