const std = @import("std");
const builtin = @import("builtin");
const debug = std.debug;
const io = std.io;
const log = std.log;
const json = std.json;
const mem = std.mem;
const fmt = std.fmt;
const Allocator = mem.Allocator;

const Transpiler = @import("Transpiler.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.testing.expect(gpa.deinit() != .leak) catch @panic("memory leak");
    const allocator = gpa.allocator();

    // zig cc -x c++ -std=c++11 -Xclang -ast-dump=json {input_file}
    var clang = std.ArrayList([]const u8).init(allocator);
    defer clang.deinit();

    try clang.append("zig");
    try clang.append("cc");
    try clang.append("-x");
    try clang.append("c++");
    try clang.append("-lc++");
    try clang.append("-Xclang");
    try clang.append("-ast-dump=json");
    try clang.append("-fsyntax-only");

    const argv = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, argv);

    var target_tuple: ?[]const u8 = null;

    var transpiler = Transpiler.init(allocator);
    defer transpiler.deinit();

    var i: usize = 1;
    while (i < argv.len) : (i += 1) {
        const arg = argv[i];
        if (mem.eql(u8, arg, "-h") or mem.eql(u8, arg, "-help")) {
            _ = try io.getStdErr().writer().write(
                \\-h, -help                    Display this help and exit
                \\-target TARGET_TUPLE         Clang target tuple, e.g. x86_86-windows-gnu
                \\-R                           Recursive transpiling, use to also parse includes
                \\-no-glue                     No c++ glue code, bindings will be target specific
                \\-no-comments                 Don't write comments
                \\[clang arguments]            Pass any clang arguments, e.g. -DNDEBUG -I.\include -target x86-linux-gnu
                \\[--] [FILES]                 Input files
                \\
            );
            return;
        } else if (mem.eql(u8, arg, "-R")) {
            transpiler.recursive = true;
            continue;
        } else if (mem.eql(u8, arg, "-no-glue")) {
            transpiler.no_glue = true;
            continue;
        } else if (mem.eql(u8, arg, "-no-comments")) {
            transpiler.no_comments = true;
            continue;
        } else if (mem.eql(u8, arg, "--")) {
            // positionals arguments
            i += 1;
            break;
        } else if (mem.eql(u8, arg, "-target")) {
            // track the target tuple if specified
            try clang.append(arg);
            i += 1;

            target_tuple = argv[i];
            try clang.append(argv[i]);
            continue;
        } else if (i == argv.len - 1 and arg[0] != '-') {
            // last arg is not a command, so it must be a input arg
            break;
        }

        try clang.append(arg);
    }

    const host_target = try builtin.target.linuxTriple(allocator);
    defer allocator.free(host_target);

    if (target_tuple == null) {
        // assing a default target tuple
        target_tuple = host_target;
    }

    var dclang = std.ArrayList(u8).init(allocator);
    defer dclang.deinit();
    for (clang.items) |arg| {
        try dclang.appendSlice(arg);
        try dclang.appendSlice(" ");
    }
    log.info("{s}", .{dclang.items});

    const cwd = try std.fs.cwd().realpathAlloc(allocator, ".");
    defer allocator.free(cwd);

    var output_path = std.ArrayList(u8).init(allocator);
    defer output_path.deinit();

    while (i < argv.len) : (i += 1) {
        const file_path = argv[i];
        log.info("binding `{s}`", .{file_path});

        try clang.append(file_path);
        defer _ = clang.pop();

        const astdump = try std.ChildProcess.run(.{
            .allocator = allocator,
            .argv = clang.items,
            .max_output_bytes = 512 * 1024 * 1024,
        });
        defer {
            allocator.free(astdump.stdout);
            allocator.free(astdump.stderr);
        }

        var parsed = try json.parseFromSlice(json.Value, allocator, astdump.stdout, .{});
        defer parsed.deinit();

        transpiler.header = std.fs.path.basename(file_path);
        try transpiler.run(&parsed.value);

        log.info("transpiled {d}/{d} ({d:.2} %)", .{
            transpiler.nodes_visited,
            transpiler.nodes_count,
            (100.0 * @as(f64, @floatFromInt(transpiler.nodes_visited)) / @as(f64, @floatFromInt(transpiler.nodes_count))),
        });

        const file_name = std.fs.path.stem(file_path);

        // zig output
        {
            output_path.clearRetainingCapacity();
            try output_path.writer().print("{s}.zig", .{file_name});

            var file = try std.fs.cwd().createFile(output_path.items, .{});
            try file.writeAll(transpiler.buffer.items);
            file.close();

            log.info("formating `{s}`", .{output_path.items});
            var zfmt_args = std.ArrayList([]const u8).init(allocator);
            defer zfmt_args.deinit();
            zfmt_args.clearRetainingCapacity();
            try zfmt_args.append("zig");
            try zfmt_args.append("fmt");
            try zfmt_args.append(output_path.items);

            var zfmt = std.ChildProcess.init(zfmt_args.items, allocator);
            zfmt.stderr_behavior = .Ignore;
            zfmt.stdout_behavior = .Ignore;
            _ = try zfmt.spawnAndWait();
        }

        // glue output
        if (!transpiler.no_glue) {
            output_path.clearRetainingCapacity();
            try output_path.writer().print("{s}_glue.cpp", .{file_name});

            var file = try std.fs.cwd().createFile(output_path.items, .{});
            try file.writeAll(transpiler.c_buffer.items);
            file.close();
        }
    }
}
