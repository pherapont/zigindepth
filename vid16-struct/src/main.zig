const std = @import("std");
const vid16_struct = @import("vid16_struct");

pub fn main() !void {
    // Define a simple struct
    const Point = struct {
        x: f32,
        y: f32,

        // Namespaced function
        fn new(x: f32, y: f32) Point {
            // Anonimus struct literal
            return .{ .x = x, .y = y };
        }

        // Method
        fn distance(self: Point, other: Point) f32 {
            const diff_x = self.x - other.x;
            const diff_y = self.y - other.y;
            return @sqrt(diff_x * diff_x + diff_y * diff_y);
        }
    };

    // Struct can have declaretions and no field at all. If it has
    // no fields it's basically a just a namespace.
    const Namespace = struct {
        const pi: f64 = 3.141592;
        var count: usize = 0;
    };
}
