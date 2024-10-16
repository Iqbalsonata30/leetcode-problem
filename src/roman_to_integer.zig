// Example 1:
// Input: s = "III"
// Output: 3
// Explanation: III = 3.
//

// Example 2:
// Input: s = "LVIII"
// Output: 58
// Explanation: L = 50, V= 5, III = 3.
//
// Example 3:
// Input: s = "MCMXCIV"
// Output: 1994
// Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
//
// s only contain characters ('I', 'V', 'X', 'L', 'C', 'D', 'M')

const std = @import("std");
const expect = std.testing.expect;
const allocator = std.testing.allocator;

fn romanToInt(s: []const u8) !i32 {
    const romans = [7]u8{ 'I', 'V', 'X', 'L', 'C', 'D', 'M' };
    const ints = [7]i32{ 1, 5, 10, 50, 100, 500, 1000 };

    var map = std.AutoHashMap(u8, i32).init(allocator);
    defer map.deinit();

    for (romans, ints) |roman, int| {
        map.put(roman, int) catch |e| switch (e) {
            error.OutOfMemory => return error.OutOfMemory,
            else => return e,
        };
    }

    var result: i32 = 0;
    const limit = s.len - 1;

    for (s, 0..) |c, i| {
        if (map.contains(c)) {
            const val: i32 = map.get(c).?;
            result = if (i < limit and val < map.get(s[i + 1]).?) result - val else result + val;
        }
    }

    return result;
}

const TestCase = struct {
    input: []const u8,
    output: i32,
};

test romanToInt {
    const test_case = [_]TestCase{ .{
        .input = "III",
        .output = 3,
    }, .{
        .input = "LVIII",
        .output = 58,
    }, .{
        .input = "MCMXCIV",
        .output = 1994,
    }, .{
        .input = "MMMDCCXXIV",
        .output = 3724,
    } };

    for (test_case) |tc| {
        const res = try romanToInt(tc.input);
        try expect(res == tc.output);
    }
}
