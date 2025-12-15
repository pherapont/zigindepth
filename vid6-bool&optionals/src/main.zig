const std = @import("std");

pub fn main() !void {
    // A bool can only be true or false
    const t: bool = true;
    const f: bool = false;
    std.debug.print("t: {}, f: {}\n", .{ t, f });

    // You can convert a bool to integer (0 or 1 only)
    std.debug.print("t: {}, f: {}\n", .{ @intFromBool(t), @intFromBool(f) });

    // Only optionals can be null
    var maybe_byte: ?u8 = null;
    std.debug.print("maybe_byte: {?}\n", .{maybe_byte});
    maybe_byte = 42;
    std.debug.print("maybe_byte: {?}\n", .{maybe_byte});

    // Use ? to assert the optional isn't null and extract its payload
    var the_byte = maybe_byte.?;

    // 'orelse' will extract the payload or default to the provided value to null
    the_byte = maybe_byte orelse 13;

    // You can control the execution flow with if, bool and optional
    if (t) {
        std.debug.print("t: {}\n", .{t});
    } else if (f) {
        std.debug.print("It's never execute", .{});
    } else {
        std.debug.print("None from above are true", .{});
    }

    // You can capture payload the optional if it's not null
    if (maybe_byte) |b| {
        // In here b is u8, not an optional
        std.debug.print("b is {}\n", .{b});
    } else {
        std.debug.print("It's a null\n", .{});
    }

    // You can ignore the payload with _
    if (maybe_byte) |_| {
        std.debug.print("It's not a null\n", .{});
    }

    // Only optionals can be compared with null
    if (maybe_byte == null) {
        std.debug.print("It's a null\n", .{});
    }

    // You can write a simple if as one liner
    if (t) std.debug.print("It's {}\n", .{t});

    // You can also use if as expression
    // Zig version of the ternary operator
    the_byte = if (maybe_byte) |b| b else 0;
    // orelse is the convinient shortcuts of above
    the_byte = maybe_byte orelse 0;

    // When using if as expression brackets not allowed
    the_byte = if (maybe_byte != null and maybe_byte.? == 42)
        42 * 2
    else
        0;
    std.debug.print("the_byte: {}\n", .{the_byte});
}
