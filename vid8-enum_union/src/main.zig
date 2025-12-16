const std = @import("std");
const vid8_enum_union = @import("vid8_enum_union");

pub fn main() !void {
    // Auto assigned integers starting at 0
    // Uses smallest possible unsigned integer type
    const Color = enum {
        red,
        green,
        blue,

        // Can have methods
        fn isRed(self: Color) bool {
            return self == .red;
        }
    };

    // Size of the largest field. 8 byte in this case
    const Number = union {
        int: u8,
        float: f64,
    };
}
