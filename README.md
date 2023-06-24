inspeired by this [article](https://floooh.github.io/2020/08/23/sokol-bindgen.html) uses zig to create zig bindgens for c++

`zig cc -x c++ -std=c++11 -Xclang -ast-dump=json {input_file}`


## Notes

- Avoid glue C code
- Transpiled code can leak memory (implicit destructors aren't called)
- Manual adjustments are required, specially to make bindings idiomatic and easer to read
- Meant to work with libraries that follow the *C with classes* coding style
- No Zig side inheritance, instead create bindings of a C++ implementation

## Todo

- `if (*data++ == v) { ... }` should generate `{ data += 1; if (data.* == v) { ... } }`
- format bits inline functions with `zig fmt --stdin` and output them commented out?
- flags mixin functions
- figure out a way of calling destructors when never necessary
- handle private members, class is default private, struct default public, in code is referenced as `self.public`
- better input file not found error
- fail when clang ast-bump has failed, because missing headers or worng code
- more operators
- use `getPtr` in `json.Value`
- static methods inside classes
- auto resolve naming conflics by adding a counter at the end of the function name
- handle typedefs of named structs
- constexpr
- use `@compileError` for objects that couldn't be transpiled
- write layout tests

test with: other libraries from: https://github.com/godotengine/godot/tree/master/modules
- SDL2
- stbi
- basis_universal
- meshoptimizer
- xatlas
- JoltPhysics
- minimp3
- tinyexr
- msdfgen
- astc-encoder
- raylib
- astcenc
