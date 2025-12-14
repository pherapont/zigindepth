const std = @import("std");

pub fn main() !void {
    // Explicit - type and length
    const a1: [5]u8 = [5]u8{ 1, 2, 3, 4, 5 };
    std.debug.print("a1: {any}, a1.len: {}\n", .{ a1, a1.len });

    // Inferred type and length
    const a2 = [_]u8{ 6, 7, 8, 9, 10 };
    std.debug.print("a2: {any}, a2.len: {}\n", .{ a2, a2.len });

    // ** repeat an array
    const a3 = a2 ** 2;
    std.debug.print("a3: {any}, a3.len: {}\n", .{ a3, a3.len });
    // and for initializing array with single value
    const a4 = [_]u8{0} ** 4;
    std.debug.print("a4: {any}, a4.len: {}\n", .{ a4, a4.len });

    // The array length must be comptime known
    // var x: u8 = 5;
    // _ = &x;
    // const a5: [x]u8 = [_]u8{0} ** x;
    // std.debug.print("a5: {any}, a5.len: {}\n", .{ a5, a5.len });

    // We can leave array as undefined and use it later
    var a6: [2]u8 = undefined;
    std.debug.print("a6: {any}, a6.len: {}\n", .{ a6, a6.len });
    a6[0] = 11;
    a6[1] = 22;
    std.debug.print("a6: {any}, a6.len: {}\n", .{ a6, a6.len });

    // Multidimensinal array
    const a7: [2][2]u8 = [_][2]u8{ .{ 1, 2 }, .{ 3, 4 } };
    std.debug.print("a7: {any}, a7.len: {}\n", .{ a7, a7.len });
    std.debug.print("a7[1][1]: {}\n", .{a7[1][1]});

    // Sentiel terminated array use the syntax [N:V]T where N is the length
    // and V is the sential value of the type T
    const a8: [2:0]u8 = .{ 7, 8 };
    std.debug.print("a8: {any}, a8.len: {}\n", .{ a8, a8.len });
    // In normal arrays you can't access the index = len
    // std.debug.print("a7[a7.len]: {}\n", .{a7[a7.len]});
    std.debug.print("a8[a8.len]: {}\n", .{a8[a8.len]});

    // ++ concantinate arrays
    const a9 = a1 ++ a2;
    std.debug.print("a9: {any}, a9.len: {}\n", .{ a9, a9.len });

    // With ** you can call function to initialize value
    const a10 = [_]u8{getSquare(3)} ** 3;
    std.debug.print("a10: {any}, a10.len: {}\n", .{ a10, a10.len });

    // Empty array
    _ = [0]u8{};
    _ = [_]u8{};
}

fn getSquare(x: u8) u8 {
    return x *| x;
}
