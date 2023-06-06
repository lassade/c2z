inspeired by this [article](https://floooh.github.io/2020/08/23/sokol-bindgen.html) uses zig to create zig bindgens for c++

`zig cc -x c++ -std=c++11 -Xclang -ast-dump=json {input_file}`