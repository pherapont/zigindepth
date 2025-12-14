const std = @import("std");

// Constant and variable names are snake case

// Global constant
const global_const: u8 = 42;

// Global variable
var global_var: u8 = 0;

// Fanction names are camelCase.
fn printInfo(name: []const u8, x: anytype) void {
    std.debug.print("{s:>10} {any:^10}\t{}\n", .{ name, x, @TypeOf(x) });
}

pub fn main() !void {
    std.debug.print("{s:>10} {s:^10}\t{s}\n", .{ "name", "value", "type" });
    std.debug.print("{s:>10} {s:^10}\t{s}\n", .{ "____", "_____", "____" });

    // const defines an immutable value accessed via the name 'a_const'.
    const a_const = 1;
    // a_const += 1;
    printInfo("a_const", a_const);

    // var defines an mutable value accessed via the name 'a_var'.
    var a_var: u8 = 3;
    a_var += 1;
    printInfo("a_var", a_var);

    // var must have a type or be comptime
    // var b_var = 3;
    // comptime var b_var = 3;
    var b_var: u8 = 3;
    _ = &b_var;
    printInfo("b_var", b_var);

    // Both have to be intialized with a value.
    // const b_const;
    // var c_var: u8;

    // Use 'undefined' to initialize a variable whose value is
    // to be determined later on in the program.
    var d_var: u8 = undefined;
    printInfo("d_var", d_var);
    d_var = 3;
    printInfo("d_var", d_var);

    // You can't define a name and not use it.
    var e_var: u8 = 0;
    // As a workaround you can use the underscore special name to ignore something
    _ = &e_var;
}
