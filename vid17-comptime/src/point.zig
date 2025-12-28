pub fn Point(comptime T: type) type {
    return struct {
        x: T,
        y: T,

        const Self = @This();

        // Namespaced function
        pub fn new(x: T, y: T) Self {
            // Anonimus struct literal`
            return .{ .x = x, .y = y };
        }

        // Method
        pub fn distance(self: Self, other: Self) f64 {
            const diff_x: f64 = switch (@typeInfo(T)) {
                .int => @floatFromInt(other.x - self.x),
                .float => other.x - self.x,
                else => @compileError("Allowed only float or int."),
            };
            const diff_y: f64 = switch (@typeInfo(T)) {
                .int => @floatFromInt(other.y - self.y),
                .float => other.y - self.y,
                else => @compileError("Allowed only float or int."),
            };
            return @sqrt(diff_x * diff_x + diff_y * diff_y);
        }
    };
}
