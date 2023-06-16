const std = @import("std");
const clap = @import("clap");
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

    const params = comptime clap.parseParamsComptime(
        \\-h, --help                   Display this help and exit.
        \\--std <str>                  C++ version, default c++11.
        \\--cargs <str>                Clang args.
        \\--transpile-includes         By default includes are excluded from final output, use this options to include them.
        //\\--zigify                     Aliases in the zig code style.
        \\<str>...
        \\
    );

    var diag = clap.Diagnostic{};
    var res = clap.parse(clap.Help, &params, clap.parsers.default, .{ .diagnostic = &diag }) catch |err| {
        // Report useful error and exit
        diag.report(io.getStdErr().writer(), err) catch {};
        return err;
    };
    defer res.deinit();

    if (res.args.help != 0) {
        return clap.help(io.getStdErr().writer(), clap.Help, &params, .{});
    }

    var c_ver: []const u8 = "-std=c++11";
    if (res.args.std) |s| {
        c_ver = s;
    }

    const cwd = try std.fs.cwd().realpathAlloc(allocator, "");
    defer allocator.free(cwd);

    for (res.positionals) |input_file| {
        log.info("binding `{s}`", .{input_file});

        // zig cc -x c++ -std=c++11 -Xclang -ast-dump=json {input_file}
        var args = std.ArrayList([]const u8).init(allocator);
        defer args.deinit();

        try args.append("zig");
        try args.append("cc");
        try args.append("-x");
        try args.append("c++");
        try args.append(c_ver);
        try args.append("-Xclang");
        try args.append("-ast-dump=json");
        if (res.args.cargs) |cargs| {
            try args.append(cargs);
        }
        try args.append(input_file);

        var astdump = try std.ChildProcess.exec(.{
            .allocator = allocator,
            .argv = args.items,
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
        const node_count = Transpiler.nodeCount(&tree.root);

        var buffer = std.ArrayList(u8).init(allocator);
        defer buffer.deinit();
        var transpiler = Transpiler.init(&buffer, allocator);
        transpiler.transpile_includes = res.args.@"transpile-includes" != 0;
        //transpiler.zigify = res.args.zigify != 0;
        defer transpiler.deinit();
        try transpiler.visit(&tree.root);

        log.info("transpiled {d}/{d} ({d:.2} %)", .{
            transpiler.visited,
            node_count,
            (100.0 * @intToFloat(f64, transpiler.visited) / @intToFloat(f64, node_count)),
        });

        var path = std.ArrayList(u8).init(allocator);
        try path.writer().print("{s}.zig", .{std.fs.path.stem(input_file)});
        defer path.deinit();

        var file = try std.fs.cwd().createFile(path.items, .{});
        try file.writeAll(buffer.items);
        file.close();

        log.info("formating `{s}`", .{path.items});
        args.clearRetainingCapacity();
        try args.append("zig");
        try args.append("fmt");
        try args.append(path.items);
        var zfmt = std.ChildProcess.init(args.items, args.allocator);
        zfmt.stderr_behavior = .Ignore;
        zfmt.stdout_behavior = .Ignore;
        _ = try zfmt.spawnAndWait();
    }
}
