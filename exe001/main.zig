const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}).init;
    const alloc = gpa.allocator();
    defer _ = gpa.deinit();
    const lista = try makeSequence(alloc, 10);
    defer alloc.free(lista);

    for (lista, 0..) |_, i| {
        std.debug.print("valor no índice {d} : {d}\n", .{ i, lista[i] });
    }
}

fn makeSequence(allocator: std.mem.Allocator, size: usize) ![]usize {
    var arr = try allocator.alloc(usize, size);
    for (0..(arr.len)) |i| {
        arr[i] = i * 2;
    }
    return arr;
}
