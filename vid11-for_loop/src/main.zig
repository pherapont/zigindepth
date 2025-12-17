const std = @import("std");
const vid11_for_loop = @import("vid11_for_loop");

pub fn main() !void {
    var array = [_]u8{ 0, 1, 2, 3, 4, 5 };

    // You can iterate over the array
    for (array) |item| std.debug.print("{} ", .{item});
    std.debug.print("\n", .{});

    _ = &array;

    // Or a slice
    for (array[0..3]) |item| std.debug.print("{} ", .{item});
    std.debug.print("\n", .{});

    // Add a range to have an itndex
    for (array, 0..) |item, i| std.debug.print("{}-{} ", .{ i, item });
    std.debug.print("\n", .{});

    // You can  iterate over multiply objects
    // but they must have equal length
    for (array[0..2], array[1..3], array[2..4]) |a, b, c| {
        std.debug.print("({} {} {})\n", .{ a, b, c });
    }
    std.debug.print("\n", .{});

    // Iterate over the range, but that can't be unbounded
    for (3..12) |i| std.debug.print("{} ", .{i});
    std.debug.print("\n", .{});

    // Break and continue
    var sum: usize = 0;
    for (array) |item| {
        if (item == 2) continue;
        if (item == 4) break;
        sum += item;
    }
    std.debug.print("sum: {}\n", .{sum});

    // Use lable to break or continue from nested loop
    outer: for (1..10) |oi| {
        for (0..3) |ii| {
            if (oi == 5) break :outer;
            std.debug.print("{} ", .{ii});
        }
        std.debug.print("\n", .{});
    }
    std.debug.print("\n", .{});

    // You can obtain the pointer to the item to modify it
    // The object must not to be const and you must use pointer to it
    // (Remember: a slice is also a pointer type)
    for (&array) |*item| {
        item.* *= 2;
        std.debug.print("{} ", .{item.*});
    }
    std.debug.print("\n", .{});

    // A for loop can be an expression with an else cause
    // Here is a handy way to obtain a slice of just a first non-null
    // elements of an array of optionals
    const maybe_nums = [_]?u8{ 0, 1, 2, null, null };

    const just_nums = for (maybe_nums, 0..) |otp_num, i| {
        if (otp_num == null) break maybe_nums[0..i];
    } else maybe_nums[0..];
    std.debug.print("just_nums: {any}\n", .{just_nums});
}
