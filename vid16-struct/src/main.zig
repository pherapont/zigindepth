const std = @import("std");
const Point = @import("Point.zig");

// Define a simple struct
// const Point = struct {
//     x: f32,
//     y: f32 = 0,

//     // Namespaced function
//     fn new(x: f32, y: f32) Point {
//         // Anonimus struct literal
//         return .{ .x = x, .y = y };
//     }

//     // Method
//     fn distance(self: Point, other: Point) f32 {
//         const diff_x = self.x - other.x;
//         const diff_y = self.y - other.y;
//         return @sqrt(diff_x * diff_x + diff_y * diff_y);
//     }
// };

// Struct can have declaretions and no field at all. If it has
// no fields it's basically a just a namespace.
const Namespace = struct {
    const pi: f64 = 3.141592;
    var count: usize = 0;
};
pub fn main() !void {
    // Anonimus struct literal .y ommited since it has default value.
    const a_point: Point = .{ .x = 2 };
    // Using namespaced function
    const b_point: Point = Point.new(3, 3);

    // Using method syntax
    std.debug.print("distance: {d:.1}\n", .{a_point.distance(b_point)});
    // Using namespaced function syntax
    std.debug.print("distance: {d:.1}\n", .{Point.distance(a_point, b_point)});
    std.debug.print("\n", .{});

    // The namespaced struct with no fields has size 0.
    std.debug.print("size of Point: {}\n", .{@sizeOf(Point)});
    std.debug.print("size of Namespace: {}\n", .{@sizeOf(Namespace)});
    std.debug.print("size of mass: {}\n", .{@sizeOf(*[8:0]u16)});
    // std.debug.print("\n", .{});

    // @fieldParentPtr demo
    var c_point = Point.new(0, 0);
    setYBasedOnX(&c_point.x, 42);
    std.debug.print("c_point.y: {d}\n", .{c_point.y});
    std.debug.print("\n", .{});

    // The dot operator de-referances a pointer to a struct automatically
    // when accessing field or calling methods
    const c_point_ptr = &c_point;
    std.debug.print("c_point_ptr.*.y: {d}, c_point_ptr.y: {d}\n", .{ c_point_ptr.*.y, c_point_ptr.y });
}

// Struct field order is determained by the compailer for optimal performance.
// however you can still calculate a struct pointer from the pointer to that field
fn setYBasedOnX(x: *f32, y: f32) void {
    // @fieldParentPtr lets get you a field's parent from the pointer to that field
    const point: *Point = @fieldParentPtr("x", x);
    point.y = y;
}
