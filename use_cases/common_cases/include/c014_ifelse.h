void If(int value) {
    if (value < 0) {
        return;
    }
}

bool IfElse(int value) {
    if (value < 0) {
        return false;
    } else {
        return true;
    }
}

bool IfElseIfElse(int value) {
    if (value < -5) {
        return false;
    } else if (value > 5) {
        return false;
    } else {
        return true;
    }
}