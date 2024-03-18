const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "c2z",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    // This declares intent for the executable to be installed into the
    // standard location when the user invokes the "install" step (the default
    // step when running `zig build`).
    b.installArtifact(exe);

    // This *creates* a Run step in the build graph, to be executed when another
    // step is evaluated that depends on it. The next line below will establish
    // such a dependency.
    const run_cmd = b.addRunArtifact(exe);

    // By making the run step depend on the install step, it will be run from the
    // installation directory rather than directly from within the cache directory.
    // This is not necessary, however, if the application depends on other installed
    // files, this ensures they will be present and in the expected location.
    run_cmd.step.dependOn(b.getInstallStep());

    // This allows the user to pass arguments to the application in the build
    // command itself, like this: `zig build run -- arg1 arg2 etc`
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build run`
    // This will evaluate the `run` step rather than the default, which is "install".
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // Creates a step for unit testing. This only builds the test executable
    // but does not run it.
    const test_cases = b.addTest(.{
        .root_source_file = .{ .path = "./test_cases/tests.zig" },
        .target = target,
        .optimize = optimize,
    });

    // build and link use cases
    const cflags = &.{"-fno-sanitize=undefined"};
    const lib = b.addStaticLibrary(.{
        .name = "test_cases",
        .target = target,
        .optimize = optimize,
    });
    lib.addIncludePath(.{ .path = "./test_cases/include" });
    if (target.result.abi == .msvc) {
        lib.linkLibC();
    } else {
        lib.linkLibCpp();
    }
    //lib.addCSourceFile("./test_cases/include/c002_cpp_structs.cpp", cflags);
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/include/c005_inheritance.cpp" }, .flags = cflags });
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/include/c013_cpp_vector.cpp" }, .flags = cflags });
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/include/c022_cpp_string.cpp" }, .flags = cflags });
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/include/c023_cpp_nested_structs.cpp" }, .flags = cflags });
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/include/c024_cpp_bitfields.cpp" }, .flags = cflags });
    //lib.addCSourceFile("./test_cases/c001_c_structs_glue.cpp", cflags);
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/c005_inheritance_glue.cpp" }, .flags = cflags });
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/c009_enum_flags_glue.cpp" }, .flags = cflags });
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/c011_index_this_glue.cpp" }, .flags = cflags });
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/c013_cpp_vector_glue.cpp" }, .flags = cflags });
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/c022_cpp_string_glue.cpp" }, .flags = cflags });
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/c023_cpp_nested_structs_glue.cpp" }, .flags = cflags });
    lib.addCSourceFile(.{ .file = .{ .path = "./test_cases/c024_cpp_bitfields_glue.cpp" }, .flags = cflags });
    test_cases.linkLibrary(lib);

    const cpp_mod = b.addModule("cpp", .{ .root_source_file = .{ .path = "src/cpp.zig" } });
    test_cases.root_module.addImport("cpp", cpp_mod);

    const run_test_cases = b.addRunArtifact(test_cases);

    // Similar to creating the run step earlier, this exposes a `test` step to
    // the `zig build --help` menu, providing a way for the user to request
    // running the unit tests.
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_test_cases.step);
}
