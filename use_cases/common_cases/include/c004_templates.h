
template<typename T>
struct Vector {
    T* data;
    int size;
    int capacity;

    inline bool         empty() const                       { return Size == 0; }
    inline int          size() const                        { return Size; }
    inline int          size_in_bytes() const               { return Size * (int)sizeof(T); }
    
    inline T&           operator[](int i)                   { return Data[i]; }
    inline const T&     operator[](int i) const             { return Data[i]; }
};