const std = @import("std");

pub fn main() !void {}

// Take an output variable , reeturning number of the bytes writen in it
// Стратегия при которой память выделяет вызывающая сторона
fn catOutVarLen(
    a: []const u8,
    b: []const u8,
    out: []u8,
) usize {
    // Make sure we have enough space
    std.debug.assert(out.len >= b.len + a.len);
    // Copy the bytes
    std.mem.copyForwards(u8, out, a);
    std.mem.copyForwards(u8, out[a.len..], b);
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
    std.mem.copyForwards(u8, out, a);
    std.mem.copyForwards(u8, out[a.len..], b);
    // Return the slice of copied bytes
    return out[0 .. a.len + b.len];
}

test "catOutVarSlice" {
    const hello: []const u8 = "Hello ";
    const world: []const u8 = "world!";

    // Our output buffer
    var buf: [128]u8 = undefined;

    // Write to buffer get slice
    const slice = catOutVarSlice(hello, world, &buf);
    try std.testing.expectEqualStrings(hello ++ world, slice);
}

// Take an allocator, return bytes allocated with it. Caller must free returned bytes
fn catAlloc(
    allocator: std.mem.Allocator,
    a: []const u8,
    b: []const u8,
) ![]u8 {
    // Try allocate enough space. Returns a []T on success.
    const bytes = try allocator.alloc(u8, a.len + b.len);
    // errdefer allocator.free(bytes);
    // Copy the bytes
    std.mem.copyForwards(u8, bytes, a);
    //  try mayFail();
    std.mem.copyForwards(u8, bytes[a.len..], b);
    // Return the allocated slice.
    return bytes;
}

test "catAlloc" {
    const hello: []const u8 = "Hello ";
    const world: []const u8 = "world ";
    const allocator = std.testing.allocator;

    // Write to buffer get slice.
    const slice = try catAlloc(allocator, hello, world);
    try std.testing.expectEqualStrings(hello ++ world, slice);
    allocator.free(slice);
}

// Always fails; just to demonstrate errdefer.
fn mayFail() !void {
    return error.Boom;
}
