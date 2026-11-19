// Eu realmente não entendi o exercicio três
const std = @import("std");

pub fn main() !void {
    // var gpa = std.heap.DebugAllocator(.{}).init;
    // defer _ = gpa.deinit();

    // const allocator = gpa.allocator();
    var buffer: [256]u8 = undefined;
    // O alocador desse cara tem uma quantidade máxima que pode disponibilizar
    var gpa = std.heap.FixedBufferAllocator.init(&buffer);

    const allocator = gpa.allocator();

    var lista = std.ArrayList(i32).empty;
    defer lista.deinit(allocator);

    for (0..100) |i| {
        // O alinhamento de memória provoca um comportamente interessante
        // no append(), fazendo com que seja possivel apenas 34 adições das
        // 64 teóricas. o compilador acabou gastando bytes para manter o
        // alinhamento
        std.debug.print("{d}\n", .{i});
        try lista.append(allocator, 5);
    }
}
