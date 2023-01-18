const rvm_code = ");'u?>vD?>vRD?>vRA?>vRA?>vR:?>vR=!(:lkm!':lkv6y"; // RVM code that prints HELLO!

const std = @import("std");
const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    try stdout.print("RVM code:\n", .{});
    try stdout.print("{s}\n", .{rvm_code});
}
