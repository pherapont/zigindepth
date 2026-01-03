const std = @import("std");

pub fn main() !void {}

// Take an output variable , reeturning rumber of the bytes written in it
// Стратегия при которой память выделяет вызывающая сторона
fn catOutVarLen(
    a: []const u8,
    b: []const u8,
    out: []u8,
) usize {
    // Make sure we have enough space
    std.debug.assert(out.len >= b.len + a.len);
    // Copy the bytes
    std.mem.copy(u8, out, a);
    std.mem.copy(u8, out[a.len..], b);
    // Return the number of bytes copied
    return a.len + b.len;
}

test "catOutVarLen" {
    const hello: []const u8 = "Hello ";
    const world: []const u8 = "world!";

    // Our output buffer
    var buf: [128]u8 = undefined;

    // Write to buffer get length
    const len = catOutVarLen(hello, world, &buf);
    try std.testing.expectEqualStrings(hello ++ world, buf[0..len]);
    // If you are feeling clever, you can also do this
    try std.testing.expectEqualStrings(hello ++ world, buf[0..catOutVarLen(hello, world, &buf)]);
}

// Take an output variable returning a slice from it
fn catOutVarSlice(
    a: []const u8,
    b: []const u8,
    out: []u8,
) []u8 {
    // Make sure we have enough space
    std.debug.assert(out.len >= b.len + a.len);
    // Copy the bytes
    std.mem.copy(u8, out, a);
    std.mem.copy(u8, out[a.len..], b);
    // Return the slice of copied bytes
    return out[0 .. a.len + b.len];
}

test "catOutVarSlice" {
    const hello: []const u8 = "Hello ";
    const world: []const u8 = "world!";

    // Our output buffer
    var buf: [128]u8 = undefined;

    // Write to buffer get slice
    const slice = catOutVarLen(hello, world, &buf);
    try std.testing.expectEqualStrings(hello ++ world, slice);
}
