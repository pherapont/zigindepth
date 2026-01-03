const std = @import("std");

// Memory sections or where are the bytes?

// Stoored in global constant section of the memory
// Static region там где скомпилированный двойчный код всей программы
const pi: f64 = 3.1415;
const greeting = "Hello";

// Stored in global data section
// Static region too правда этот участок памяти можно изменять
var count: usize = 0;

fn locals() u8 {
    // All of these loclal variables are gone
    // once the function exist. They live on the
    // functon's stack frame.
    var a: u8 = 1;
    var b: u8 = 2;
    var result: u8 = a + b;
    // Here a copy of result is returned,
    // since it's a primitive numeric type.
    // Все переменные уничтожаются после завершения действия функции,
    // но это не проблема так как копия результата сохраняется в вызывающей
    // функции. (для примитивных типов)
    return result;
}

fn badIdia1() *u8 {
    // 'x' leave on the stack
    var x: u8 = 42;
    // Invalid pointer once the function returns
    // And it's stack frame is destroyed
    return &x;
}

fn badIdia2() []u8 {
    var array: [5]u8 = .{ 'H', 'e', 'l', 'l', 'o' };
    // Remember: a slice is also a pointer
    var s = array[2..];
    // This is an error since 'array' will be destroyed
    // when the function returns. 's' will be left dangling
    return s;
}

// Caller must free returned bytes
fn goodIdea(allocator: std.mem.Allocator) std.mem.Allocator.Error![]u8 {
    var array: [5]u8 = .{ 'H', 'e', 'l', 'l', 'o' };
    // 's' is a []u8 with length 5 and pointer to bytes on the heap
    var s = try allocator.alloc(u8, 5);
    std.mem.copy(u8, s, &array);
    // This is OK since 's' is a pointer to bytes allocated on the
    // heap and thus outleave the function's stack frame
    return s;
}
