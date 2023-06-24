const std = @import("std");

extern fn _Z3fooi(_: c_int) void;
pub const foo = _Z3fooi;

pub fn for1() void {
    {
        var i: c_int = 0;
        while (i < 5) : ({
            i += 1;
        }) foo(i);
    }
}

pub fn for2() void {
    {
        var i: c_int = 0;
        while (i < 5) : ({
            i += 1;
        }) {
            foo(i);
        }
    }
}

pub fn for3() void {
    {
        var i: c_int = 0;
        while (i < 5) : ({
            i += 1;
        }) {
            foo(i);
        }
    }
    {
        var i: c_int = 5;
        while (i < 10) : ({
            i += 1;
        }) {
            foo(i);
        }
    }
}

pub fn for4() void {
    {
        var i: c_int = 0;
        var j: c_int = 8;
        while (i < 5) : ({
            i += 1;
            j -= 1;
        }) {
            foo(i);
        }
    }
}
