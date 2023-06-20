inspeired by this [article](https://floooh.github.io/2020/08/23/sokol-bindgen.html) uses zig to create zig bindgens for c++

`zig cc -x c++ -std=c++11 -Xclang -ast-dump=json {input_file}`


## Notes

- Avoid glue C code
- Manual adjustments are required
- Not all transpiled code should compile, but all code that does compile should work
- Meant to work with libraries that follow the *C with classes* coding style
- No Zig side inheritance, instead create bindings of a C++ implementation

## Todo

- fail when clang ast-bump has failed as well ...
- more operators
- write unnamed enumerations as global constants, if they aren't referenced by any typedef
- use `getPtr` in `json.Value`
- static methods inside classes
- auto resolve naming conflics by adding a counter at the end of the function name
- handle typedefs of named structs
- constexpr
- write opaques if they didn't get defined at the end of the file
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
