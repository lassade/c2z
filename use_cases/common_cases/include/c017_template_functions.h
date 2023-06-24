void free(void*);

template<typename T> void IM_DELETE(T* p)   { if (p) { p->~T(); free(p); } }
