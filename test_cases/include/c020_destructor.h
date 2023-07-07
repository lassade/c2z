
struct ByteBlob {
    unsigned char* Data;
    int Size;
    int Capacity;

    ~ByteBlob();
};