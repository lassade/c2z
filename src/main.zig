const std = @import("std");
const builtin = @import("builtin");
const debug = std.debug;
const io = std.io;
const log = std.log;
const json = std.json;
const mem = std.mem;
const fmt = std.fmt;
const Allocator = mem.Allocator;

const Transpiler = @import("transpiler.zig");

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

    var argv = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, argv);

    var recursive = false;
    var target_tuple: ?[]const u8 = null;

    var i: usize = 1;
    while (i < argv.len - 1) : (i += 1) {
        const arg = argv[i];
        if (mem.eql(u8, arg, "-h") or mem.eql(u8, arg, "-help")) {
            _ = try io.getStdErr().writer().write(
                \\-h, --help                   Display this help and exit
                \\-target                      Target tuple
                \\-R                           Recursive transpiling, use to also parse includes
                \\[clang arguments]            Pass any clang arguments, e.g. -DNDEBUG -I.\include -target x86-linux
                \\[--] [FILES]                 Input files
                \\
            );
            return;
        } else if (mem.eql(u8, arg, "-R")) {
            recursive = true;
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
        }

        try clang.append(arg);
    }

    var dclang = std.ArrayList(u8).init(allocator);
    defer dclang.deinit();
    for (clang.items) |arg| {
        try dclang.appendSlice(arg);
        try dclang.appendSlice(" ");
    }
    log.info("{s}", .{dclang.items});

    const target_path = if (target_tuple != null) try mem.replaceOwned(u8, allocator, target_tuple.?, "-", "/") else ".";
    defer if (target_tuple != null) allocator.free(target_path);
    try std.fs.cwd().makePath(target_path);

    const cwd = try std.fs.cwd().realpathAlloc(allocator, ".");
    defer allocator.free(cwd);

    while (i < argv.len) : (i += 1) {
        const input_file = argv[i];
        log.info("binding `{s}`", .{input_file});

        try clang.append(input_file);
        defer _ = clang.pop();

        var astdump = try std.ChildProcess.exec(.{
            .allocator = allocator,
            .argv = clang.items,
            .max_output_bytes = 512 * 1024 * 1024,
        });
        defer {
            allocator.free(astdump.stdout);
            allocator.free(astdump.stderr);
        }

        var parser = json.Parser.init(allocator, .alloc_if_needed);
        defer parser.deinit();

        var tree = try parser.parse(astdump.stdout);
        defer tree.deinit();

        var transpiler = Transpiler.init(allocator);
        defer transpiler.deinit();
        transpiler.recursive = recursive;
        try transpiler.run(&tree.root);

        log.info("transpiled {d}/{d} ({d:.2} %)", .{
            transpiler.nodes_visited,
            transpiler.nodes_count,
            (100.0 * @intToFloat(f64, transpiler.nodes_visited) / @intToFloat(f64, transpiler.nodes_count)),
        });

        var path = std.ArrayList(u8).init(allocator);
        try path.writer().print("{s}/{s}.zig", .{ target_path, std.fs.path.stem(input_file) });
        defer path.deinit();

        var file = try std.fs.cwd().createFile(path.items, .{});
        try file.writeAll(transpiler.buffer.items);
        file.close();

        log.info("formating `{s}`", .{path.items});
        var zfmt_args = std.ArrayList([]const u8).init(allocator);
        defer zfmt_args.deinit();
        zfmt_args.clearRetainingCapacity();
        try zfmt_args.append("zig");
        try zfmt_args.append("fmt");
        try zfmt_args.append(path.items);

        var zfmt = std.ChildProcess.init(zfmt_args.items, allocator);
        zfmt.stderr_behavior = .Ignore;
        zfmt.stdout_behavior = .Ignore;
        _ = try zfmt.spawnAndWait();
    }
}
