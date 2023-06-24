void foo(int);

void for1() {
    for (int i = 0; i < 5; i++) foo(i);
}

void for2() {
    for (int i = 0; i < 5; i++) {
        foo(i);
    }
}

void for3() {
    for (int i = 0; i < 5; i++) {
        foo(i);
    }
    for (int i = 5; i < 10; i++) {
        foo(i);
    }
}

void for4() {
    for (int i = 0, j = 8; i < 5; i++, j--) {
        foo(i);
    }
}