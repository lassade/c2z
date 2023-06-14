inspeired by this [article](https://floooh.github.io/2020/08/23/sokol-bindgen.html) uses zig to create zig bindgens for c++

`zig cc -x c++ -std=c++11 -Xclang -ast-dump=json {input_file}`


# todo

- fix value to alias implicit cast (not represented in the ast)
- auto resolve naming conflics by adding a counter at the end of the function name
- handle typedefs of named structs
- unnamed enumdecl in typedef
- parse fn ptr function pointers should be decorated with `callconv(.C)`
- write opaques if they didn't get defined at the end of the file
- use `@compileError` for objects that couldn't be transpiled
- static methods inside classes
- peform layout validation
- multiple inheritance

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
