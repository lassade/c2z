void* malloc(unsigned long long);

void free(void*);

void run() {
    void* a = malloc(1);
    free(a);
}

class Foo {
    int* ptr = 0;

    bool init(bool val) {
        if (ptr == 0) {
            ptr = (int*)malloc(sizeof(int));
        }
        return !val;
    }

public:
    void inc() {
        init(true);
        *ptr += 1;
    }
};