#include <vector>

bool fpng_encode_image_to_memory(const void* pImage, uint32_t w, uint32_t h, uint32_t num_chans, std::vector<uint8_t>& out_buf, uint32_t flags = 0);
