const std = @import("std");

pub fn main() !void {
    // Comptime expression evaluation
    const condition = false;

    // condition is comptime known, so it's evaluated in komptime.
    if (condition) {
        @compileError("What?");
    }

    // Inline for setup
    const nums = [_]i32{ 2, 4, 6 };
    var sum: usize = 0;

    // A inline for is unrolled
    inline for (nums) |i| {
        // A non inline for can't deal with types
        const T = switch (i) {
            2 => f32,
            4 => i8,
            6 => bool,
            else => unreachable,
        };
        sum += typeNameLength(T);
    }
    std.debug.print("for sum: {}\n", .{sum});

    // Inline while setup
    sum = 0;
    // We need a comptime var for the inline while given it's a comptime context
    comptime var i = 0;

    // A comptime while is also unrolled
    inline while (i < 3) : (i += 1) {
        // ... and can deal with types too
        const T = switch (i) {
            0 => f32,
            1 => i8,
            2 => bool,
            else => unreachable,
        };
        sum += typeNameLength(T);
    }
    std.debug.print("while sum: {}\n", .{sum});

    // Testing both inline and inline switch prong.
    std.debug.print("isOptFor A: {}\n", .{isOptFor(A, 1)});
    std.debug.print("isOptFor B: {}\n", .{isOptFor(B, 1)});
    std.debug.print("isOptSwitch A: {}\n", .{isOptSwitch(A, 1)});
    std.debug.print("isOptSwitch B: {}\n", .{isOptSwitch(B, 1)});

    // Testing inline else prong.
    const a: U = .{ .a = .{ .a = 0, .b = null } };
    const b: U = .{ .b = .{ .a = 0, .b = 0 } };
    std.debug.print("a.hasImpl(): {}\n", .{a.hasImpl()});
    std.debug.print("b.hasImpl(): {}\n", .{b.hasImpl()});

    // Runtime normal function eval.
    std.debug.print("Runtime fib() eval: {}\n", .{fib(7)});

    // Comptime normal function eval
    const cmp_fib = comptime blk: {
        break :blk fib(7);
    };
    std.debug.print("Comptime fib() eval: {}\n", .{cmp_fib});

    // another comptime fib
    const other_cmp_fib = comptime fib(7);
    std.debug.print("Other comptime fib() eval: {}\n", .{other_cmp_fib});
}

// This function requires the comptime parametr
fn typeNameLength(comptime T: type) usize {
    return @typeName(T).len;
}

// Struct with optional field and impl decl
const A = struct {
    a: u8,
    b: ?u8,

    fn impl() void {}
};

//  Struct without optional field and impl decl.
const B = struct {
    a: u8,
    b: u8,
};

// Using an inline for
fn isOptFor(comptime T: type, field_index: usize) bool {
    const fields = @typeInfo(T).@"struct".fields;

    inline for (fields, 0..) |field, i| {
        if (field_index == i and @typeInfo(field.type) == .optional) return true;
    }
    return false;
}

// Using a switch with inline prong.
fn isOptSwitch(comptime T: type, field_index: usize) bool {
    const fields = @typeInfo(T).@"struct".fields;

    return switch (field_index) {
        inline 0...fields.len - 1 => |idx| @typeInfo(fields[idx].type) == .optional,
        else => false,
    };
}

// A tagged union with a fields of above struct types
const U = union(enum) {
    a: A,
    b: B,

    // Using inline else to handle all variants in one shot.
    fn hasImpl(self: U) bool {
        return switch (self) {
            inline else => |s| @hasDecl(@TypeOf(s), "impl"),
        };
    }
};

// A normal function that requires not runtime context (system call or side effects) can be comptime automatically
fn fib(n: usize) usize {
    if (n < 2) return n;

    var a: usize = 0;
    var b: usize = 1;
    var i: usize = 0;

    while (i < n) : (i += 1) {
        const tmp = a;
        a = b;
        b = tmp + b;
    }
    return a;
}
