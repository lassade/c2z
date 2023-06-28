// transpile with `zig build run -- -R -target x86_64-linux .\src\typedefs.h`
// replacing `x86_64-linux` with your target of choice to resolve the `size_t`
// or anyother type from the standard library

#include <stddef.h>
#include <stdint.h>