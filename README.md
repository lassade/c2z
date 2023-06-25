inspeired by this [article](https://floooh.github.io/2020/08/23/sokol-bindgen.html) uses zig to create zig bindgens for c++

`zig cc -x c++ -std=c++11 -Xclang -ast-dump=json {input_file}`


## Notes

- Avoid glue C code
- Transpiled code can leak memory (implicit destructors aren't called)
- Manual adjustments are required, specially to make bindings idiomatic and easer to read
- Meant to work with libraries that follow the *C with classes* coding style
- No Zig side inheritance, instead create bindings of a C++ implementation

## Todo

- (easy) verbose option
- (easy) better input file not found error
- (easy) format code blocks with `zig fmt --stdin`
- (easy) comment out transpiled functions as they might be worng and need manual check
- (easy) auto resolve naming conflics by apending a number in the funcion name
- (easy) fail when clang ast-bump has failed, because missing headers or worng code
- (easy) handle primitive type `ptrdiff_t`
- (hard) `if (*data++ == v) { ... }` should generate `{ data += 1; if (data.* == v) { ... } }`
- (hard) solve `UnresolvedMemberExpr`, maybe when integrating clang ast directly
- (hard) solve implicit destructors call
- (easy) handle private members, class is default private, struct default public, in code is referenced as `self.public`
- use `@compileError` for objects that couldn't be transpiled
- write layout tests

## Test cases

### C++ libs

- [x] fpng
- [ ] xatlas
- [ ] imgui
- [ ] box2d
- [ ] basis_universal
- [ ] JoltPhysics
- [ ] msdfgen
- [ ] astc-encoder

### C libs (or with builtin C bindings)

- [ ] SDL2
- [ ] stbi
- [ ] raylib
- [ ] meshoptimizer
- [ ] tinyexr
- [ ] minimp3
