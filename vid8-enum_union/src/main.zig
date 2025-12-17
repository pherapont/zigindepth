const std = @import("std");
const vid8_enum_union = @import("vid8_enum_union");

// Auto assigned integers starting at 0
// Uses smallest possible unsigned integer type
const Color = enum {
    red,
    green,
    blue,

    // Can have methods
    fn isRed(self: Color) bool {
        return self == .red;
    }
};

// Size of the largest field. 8 byte in this case
const Number = union {
    int: u8,
    float: f64,
};

// Taggedd union
const Token = union(enum) {
    keiword_if,
    keiword_switch: void,
    digit: usize,

    fn is(self: Token, tag: std.meta.Tag(Token)) bool {
        return self == tag;
    }
};
pub fn main() !void {
    // You can omit the enum name in literal when the type can be inferred
    var fav_color: Color = .red;
    std.debug.print("fav_color: {s} is red? {}\n", .{ @tagName(fav_color), fav_color.isRed() });
    fav_color = .blue;
    std.debug.print("fav_color: {s} is red? {}\n", .{ @tagName(fav_color), fav_color.isRed() });

    // Get the integer value of an enum field
    std.debug.print("fav_color as int = {}\n", .{@intFromEnum(fav_color)});
    // And the other way around too
    fav_color = @enumFromInt(1);
    std.debug.print("fav_color: {}\n", .{fav_color});

    // Enum work perfectly with switches
    switch (fav_color) {
        .red => std.debug.print("It's red\n", .{}),
        .green => std.debug.print("It's green\n", .{}),
        .blue => std.debug.print("It's blue\n", .{}),
    }

    // Union can be only one of the field at the time
    var fav_num: Number = .{ .int = 13 };
    std.debug.print("fav_num: {}\n", .{fav_num.int});
    // To change the field you reassigned the whole union
    fav_num = .{ .float = 3.1435 };
    std.debug.print("fav_num: {d:.4}\n", .{fav_num.float});

    // Tagged union get the best of both world
    var tok: Token = .keiword_if;
    std.debug.print("Is 'if': {}\n", .{tok.is(.keiword_if)});

    // And combined whith switch and payload capture, they are really useful
    switch (tok) {
        .keiword_if => std.debug.print("keiword_if\n", .{}),
        .keiword_switch => std.debug.print("keiword_switch\n", .{}),
        .digit => |d| std.debug.print("digit {}\n", .{d}),
    }

    tok = .{ .digit = 42 };

    switch (tok) {
        .keiword_if => std.debug.print("keiword_if\n", .{}),
        .keiword_switch => std.debug.print("keiword_switch\n", .{}),
        .digit => |d| std.debug.print("digit {}\n", .{d}),
    }

    // You can compare the tagged union with the enum tag type
    if (tok == .digit and tok.digit == 42) std.debug.print("It's is 42\n", .{});
}
