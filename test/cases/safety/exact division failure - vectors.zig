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
    if (std.mem.eql(u8, message, "exact division produced remainder")) {
        std.process.exit(0);
    }
    std.process.exit(1);
}

pub fn main() !void {
    const a: @Vector(4, i32) = [4]i32{ 111, 222, 333, 444 };
    const b: @Vector(4, i32) = [4]i32{ 111, 222, 333, 441 };
    const x = divExact(a, b);
    _ = x;
    return error.TestFailed;
}
fn divExact(a: @Vector(4, i32), b: @Vector(4, i32)) @Vector(4, i32) {
    return @divExact(a, b);
}
// run
// backend=llvm
// target=native
