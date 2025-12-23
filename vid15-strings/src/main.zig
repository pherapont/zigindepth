const std = @import("std");

pub fn main() !void {
    // A string literal is a constant pointer to a santial terminated array.
    // The sential is 0 also known as the null character in C.
    // The arrays bytes are included as part of the generated binary file.
    const hello = "hello";
    std.debug.print("type of \"hello\": {}\n", .{@TypeOf(hello)});
    std.debug.print("\n", .{});

    // When you need more general type for strings in Zig, you'll use
    // a slice of bytes: either const '[]const u8' or not '[]u8'.
    printString("Hello world!");
    std.debug.print("\n", .{});

    // Zig has a minimal set of escapes
    std.debug.print("escapes: \t \" \' \x65 \u{e9} \n \r", .{});
    std.debug.print("\n", .{});

    // Indexing into a string produces individual bytes. (not codepintes)
    std.debug.print("hello[2]: == {}, {0c}, {0u}\n", .{hello[2]});
    std.debug.print("\n", .{});

    // Zig source is UTF-8 encoded but strings can contain non-UTF-8 using \x sytax
    // Note we can coerce a literal into a slice bytes.
    var hello_acute: []const u8 = "h\xe9llo";
    std.debug.print("hello_acute: {s} , len: {}\n", .{ hello_acute, hello_acute.len });
    hello_acute = "h\u{e9}llo";
    std.debug.print("hello_acute: {s} , len: {}\n", .{ hello_acute, hello_acute.len });
    std.debug.print("\n", .{});

    // Multiline literals begin with '\\' and don't process any escapes.
    const multiline =
        \\ This is a multiline
        \\ string in Zig. This \n
        \\ will not be prcessed
        \\ with a new line.
    ;
    std.debug.print("multiline: {s}\n", .{multiline});
    std.debug.print("\n", .{});

    // There are no characters in zig. A unicode code point literal is
    // specifided withing single quotes
    //const ziguana = 'U237C';
}

fn printString(s: []const u8) void {
    std.debug.print("{s}\n", .{s});
}
