const std = @import("std");

pub fn main() !void {
    // Single item pointer to a const
    const a: u8 = 0;
    const a_ptr = &a;
    // a_ptr.* += 1;
    std.debug.print("a_ptr.*: {}, type of a_ptr: {}\n", .{ a_ptr.*, @TypeOf(a_ptr) });

    // Single item pointer to a variable
    var b: u8 = 0;
    const b_ptr = &b;
    b_ptr.* += 1;
    std.debug.print("b_ptr.*: {}, type of b_ptr: {}\n", .{ b_ptr.*, @TypeOf(b_ptr) });

    // Both a const and can't be modified themselves
    // a_ptr = &b;
    // b_ptr = &a;

    // Use the 'var' if you need to swap the pointer itself
    var c_ptr = a_ptr; // Внимательно! Тип c_ptr выводится при инициализации и является *const u8
    c_ptr = b_ptr; //OK Наоборот не получится так как возможно приведение только к более строгому типу и нельзя отбросить квалификатор const
    std.debug.print("c_ptr.*: {}, type of c_ptr: {}\n", .{ c_ptr.*, @TypeOf(c_ptr) });
    std.debug.print("\n", .{});

    // Multi-items pointer
    var array = [_]u8{ 1, 2, 3, 4, 5, 6 };
    var d_ptr: [*]u8 = &array;
    std.debug.print("d_ptr[0]: {}, type of d_ptr {}\n", .{ d_ptr[0], @TypeOf(d_ptr) });
    d_ptr[1] += 1; // indexing
    d_ptr += 1; // pointer arithmetic
    std.debug.print("d_ptr[0]: {}, type of d_ptr {}\n", .{ d_ptr[0], @TypeOf(d_ptr) });
    d_ptr -= 1; // pointer arithmetic
    std.debug.print("d_ptr[0]: {}, type of d_ptr {}\n", .{ d_ptr[0], @TypeOf(d_ptr) });
    std.debug.print("\n", .{});

    // Pointer to array
    const e_ptr = &array;
    std.debug.print("e_ptr[0]: {}, type of e_ptr {}\n", .{ e_ptr[0], @TypeOf(e_ptr) });
    e_ptr[1] += 1;
    std.debug.print("e_ptr[1]: {}, type of e_ptr {}\n", .{ e_ptr[1], @TypeOf(e_ptr) });
    std.debug.print("array[1]: {}\n", .{array[1]});
    std.debug.print("e_ptr.len: {}\n", .{e_ptr.len});
    std.debug.print("\n", .{});

    // Sentiel terminated pointer
    array[3] = 0;
    const f_ptr: [*:0]const u8 = array[0..3 :0];
    std.debug.print("f_ptr[1]: {}, type of f_ptr {}\n", .{ f_ptr[1], @TypeOf(f_ptr) });
    std.debug.print("\n", .{});

    // If you ever need the adress as an integer
    const adress = @intFromPtr(f_ptr);
    std.debug.print("adress: {}, type of adress {}\n", .{ adress, @TypeOf(adress) });
    // And the other way around too
    const g_ptr: [*:0]const u8 = @ptrFromInt(adress);
    std.debug.print("g_ptr[1]: {}, type of g_ptr {}\n", .{ g_ptr[1], @TypeOf(g_ptr) });
    std.debug.print("\n", .{});

    // If you need pointer that can be null as in C, use an optional pointer
    var h_ptr: ?*const usize = null;
    std.debug.print("h_ptr: {?}, type of h_ptr {}\n", .{ h_ptr, @TypeOf(h_ptr) });
    h_ptr = &adress;
    // Чтобы получить значение по такому указателю надо сначала проверить что не null(.?)
    // Такая проверка только когда уверены в результате (выкидывает ошибку) см. optionals
    std.debug.print("h_ptr.?.*: {}, type of h_ptr {}\n", .{ h_ptr.?.*, @TypeOf(h_ptr) });
    std.debug.print("\n", .{});
    // The size of the optional pointer is the same as the normal pointer
    std.debug.print("h_ptr.size: {}, *usize size {}\n", .{ @sizeOf(@TypeOf(h_ptr)), @sizeOf(*usize) });

    // There's also [*c] but that's only for transitions from C code.
}
