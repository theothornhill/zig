const std = @import("std");

pub const Panic = struct {
    pub const call = panic;
    pub const unwrapError = std.debug.FormattedPanic.unwrapError;
    pub const outOfBounds = std.debug.FormattedPanic.outOfBounds;
    pub const startGreaterThanEnd = std.debug.FormattedPanic.startGreaterThanEnd;
    pub const sentinelMismatch = std.debug.FormattedPanic.sentinelMismatch;
    pub const inactiveUnionField = std.debug.FormattedPanic.inactiveUnionField;
    pub const messages = std.debug.FormattedPanic.messages;
};

fn panic(message: []const u8, stack_trace: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    _ = stack_trace;
    if (std.mem.eql(u8, message, "integer overflow")) {
        std.process.exit(0);
    }
    std.process.exit(1);
}
pub fn main() !void {
    var buffer = [6]i32{ 1, 2, 3, 4, 5, 6 };
    var len = buffer.len;
    _ = &len;
    @memset(buffer[0..len], undefined);
    var x: i32 = buffer[1];
    x += buffer[2];
}
// run
// backend=llvm
// target=native
