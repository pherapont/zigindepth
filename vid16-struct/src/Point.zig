// We can defined struct in file
x: f32,
y: f32 = 0,

const Point = @This();

// Namespaced function
pub fn new(x: f32, y: f32) Point {
    // Anonimus struct literal
    return .{ .x = x, .y = y };
}

// Method
pub fn distance(self: Point, other: Point) f32 {
    const diff_x = other.x - self.x;
    const diff_y = other.y - self.y;
    return @sqrt(diff_x * diff_x + diff_y * diff_y);
}
