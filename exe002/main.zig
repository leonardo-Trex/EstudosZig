const std = @import("std");
const Allocator = std.mem.Allocator;

const print = std.debug.print;

const Usuario = struct {
    name: []u8,
    email: []u8,

    pub fn deinit(self: Usuario, allocator: Allocator) void {
        allocator.free(self.name);
        allocator.free(self.email);
    }

    pub fn show(self: Usuario) void {
        print("User: {s}, {s}\n", .{ self.name, self.email });
    }
};

fn makeUsuario(allocator: Allocator, name: []const u8, email: []const u8) !Usuario {
    const alloc_name = try allocator.dupe(u8, name);
    errdefer allocator.free(name);
    const alloc_email = try allocator.dupe(u8, email);

    return Usuario{
        .name = alloc_name,
        .email = alloc_email,
    };
}

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}).init;
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();
    const user = try makeUsuario(alloc, "leon", "leon@gmail.com");
    defer user.deinit(alloc);
    user.show();
}
