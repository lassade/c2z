// auto generated by c2z
const std = @import("std");
//const cpp = @import("cpp");

extern fn _1_malloc_(__arg0: c_ulonglong) ?*anyopaque;
pub const malloc = _1_malloc_;

extern fn _1_free_(__arg0: ?*anyopaque) void;
pub const free = _1_free_;

pub fn run() void {
    var a: ?*anyopaque = malloc(@as(c_ulonglong, @intCast(1)));
    free(a);
}
pub const Foo = extern struct {
    ptr: [*c]c_int,

    pub fn init(self: *Foo, val: bool) bool {
        if (self.ptr == null) {
            self.ptr = @as([*c]c_int, @ptrCast(malloc(@sizeOf(c_int))));
        }
        return !val;
    }
    pub fn inc(self: *Foo) void {
        self.init(true);
        self.ptr.* += 1;
    }
};
