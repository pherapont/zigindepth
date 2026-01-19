const std = @import("std");

pub fn main() !void {}

// Returns  the concatination of a and b as newly allocated bytes
// Caller must free returnes bytes with a 'allocator'.
fn catAlloc(
    allocator: std.mem.Allocator,
    a: []const u8,
    b: []const u8,
) ![]u8 {
    // Try to allocate enough space. Returns []T on success.
    const bytes = try allocator.alloc(u8, a.len + b.len);
    // Copy the bytes
    std.mem.copy(u8, bytes, a);
    std.mem.copy(u8, bytes[a.len..], b);
    // return the allocted slice
    return bytes;
}

test "fba bytes" {
    // Our inputs
    const hello = "Hello ";
    const world = "world!";

    // If we  know the requirement memory size in advance, we can create
    // a fixed size array for it as buffer.
    var buf: [12]u8 = undefined;
    // And than use this buffer as the backing-store for a fixed-buffer-allocator.
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    const allocator = fba.allocator();

    const result = try catAlloc(allocator, hello, world);
}
