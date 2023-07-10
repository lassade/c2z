inspeired by this [article](https://floooh.github.io/2020/08/23/sokol-bindgen.html) uses zig to create zig bindgens for c++

`zig cc -x c++ -std=c++11 -Xclang -ast-dump=json {input_file}`


## Notes

- Glue is invitable ... snap ... and needed to make the bindings cross platform
- Transpiled code can leak memory (implicit destructors aren't called)
- Manual adjustments are required, specially to make bindings idiomatic and easer to read
- Meant to work with libraries that follow the *C with classes* coding style
- No Zig side inheritance, instead create bindings of a C++ implementation

## Usage

### Setup

1. make sure `zig` in your PATH, you will need the version `0.11.0-dev.3220+447a30299` (sorry about that)
2. build the project and copy the `c2z` executable from `zig-out` to your desired location
3. or just run the project using `zig build run -- ARGS`

### Running it

1. `zig build run -- lib.h` or `c2z lib.h`
2. pass any clang argument like include and defines e.g. `zig build run -- -DNDEBUG -I.\include -target x86-linux -- .\include\lib.h`
4. modify the generated bindings until it works ;) you might need to import `cpp.zig` it is located in the src folder

### Misc

- `msvc` has a second tier support, just pass it as target tuple like as: `-no-glue -target x86_64-windows-msvc` to generate a target specifc binding for it. Debug builds aren't fully supported, use `ReleaseFast` or at least `-O1`, you might also wan't to find a way of define `_ITERATOR_DEBUG_LEVEL` to something different than `2`.

## Todo

- transpile inline or constexpr constructors when the class isn't polymorphic
- (hard) `#include` -> `@import`
- (easy) walk a directory tree

- transpile vector of vectors
- (easy) better input file not found error
- (easy) verbose option
- (easy) handle `BlockCommandComment` and `ParamCommandComment` in `FullComment`
- (easy) resolve return of function with a aliased return type
- (easy) fail when clang ast-bump has failed, because missing headers or wrong code
- (hard) `if (*data++ == v) { ... }` should generate `{ const __tmp0 = data; data += 1; if (__tmp0.* == v) { ... }  }`
- (hard) solve `UnresolvedMemberExpr`, maybe when integrating clang ast directly
- (hard) solve implicit destructors calls
- (easy) handle private members, class is default private, struct default public, in code is referenced as `self.public`
- (hard) handle varidact functions `myFunction(va_args) -> myFunction(args: [*c]u8) and myFunction__VA(...)`
- (hard) apply `keywordFix`
- use `@compileError` for objects that couldn't be transpiled
- write layout tests

## Test cases

### C++ libs

- [ ] fpng (99.99 %)
- [ ] xatlas (86.40 %)
- [ ] imgui (67.21 %)
- [ ] msdfgen (~80% ish)
- [ ] box2d
- [ ] basis_universal
- [ ] JoltPhysics
- [ ] astc-encoder

### C libs (or with builtin C bindings)

- [ ] SDL2
- [ ] stbi
- [ ] raylib
- [ ] meshoptimizer
- [ ] tinyexr
- [ ] minimp3
