const std = @import("std");

pub fn main() !void {
    // Blocks can define a new scope
    {
        const x: u8 = 42;
        std.debug.print("x: {}\n", .{x});
    }

    // Here x is out the scope
    // std.debug.print("x: {}\n", .{x});

    // Bloks are expressions and can return value
    // using lable and 'break'
    const x: u8 = blk: {
        const y: u8 = 20;
        const z: u8 = 23;
        break :blk y + z;
    };
    std.debug.print("x: {}\n", .{x});

    // 'switch' controls execution flow based on value
    switch (x) {
        // Range inclusive on both ends
        0...20 => std.debug.print("x in range 0...20", .{}),
        // You can combine several value in test with comma
        // This is like falltrough begavion in other languages
        30, 31, 32 => std.debug.print("It's 30, 31 or 32\n", .{}),
        // You can capture the matched value
        40...50 => |n| std.debug.print("It's {}\n", .{n}),
        // Use the block to more complex prongs
        77 => {
            const a = 1;
            const b = 2;
            std.debug.print("a + b = {}\n", .{a + b});
        },
        // As long as it's 'comptime known' any expression can be a prong
        blk: {
            const a = 100;
            const b = 2;
            break :blk a + b;
        } => std.debug.print("It's a 102\n", .{}),

        // 'else' is the default if other promt not matching
        else => std.debug.print("None of the above!\n", .{}),
    }

    // Like 'if' 'switch' can be an expression
    const z: u8 = switch (x) {
        0...20 => 1,
        21...50 => 2,
        else => 3,
    };
    std.debug.print("z: {}\n", .{z});
}
