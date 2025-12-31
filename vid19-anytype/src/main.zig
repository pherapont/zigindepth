const std = @import("std");

const A = struct {
    // Method
    fn toString(_: A) []const u8 {
        return "A";
    }
};

const B = struct {
    // Not a method
    fn toString(s: []const u8) []const u8 {
        return s;
    }
};

const C = struct {
    // Not even a funtion
    const toString: []const u8 = "C";
};

const D = enum {
    a,
    d,
    // Method
    fn toString(self: D) []const u8 {
        return @tagName(self);
    }
};

fn print(x: anytype) void {
    const T = @TypeOf(x);
    // Do we have a toString declaration?
    if (!@hasDecl(T, "toString")) return;
    // Is it a function?
    const decl_type = @TypeOf(@field(T, "toString"));
    if (@typeInfo(decl_type) != .@"fn") return;
    // Is it a method?
    const args = std.meta.ArgsTuple(decl_type);
    inline for (std.meta.fields(args), 0..) |arg, i| {
        if (i == 0 and arg.type == T) {
            // Now we know we can call it as a method
            std.debug.print("{s}\n", .{x.toString()});
        }
    }
}

pub fn main() !void {
    const a = A{};
    const b = B{};
    const c = C{};
    const d = D.d;

    print(a);
    print(b);
    print(c);
    print(d);
}
