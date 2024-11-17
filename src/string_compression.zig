// Example 1:
// Input: chars = ["a","a","b","b","c","c","c"]
// Output: Return 6, and the first 6 characters of the input array should be: ["a","2","b","2","c","3"]
// Explanation: The groups are "aa", "bb", and "ccc". This compresses to "a2b2c3".
//
// Example 2:
// Input: chars = ["a"]
// Output: Return 1, and the first character of the input array should be: ["a"]
// Explanation: The only group is "a", which remains uncompressed since it's a single character.
//
// Example 3:
// Input: chars = ["a","b","b","b","b","b","b","b","b","b","b","b","b"]
// Output: Return 4, and the first 4 characters of the input array should be: ["a","b","1","2"].
// Explanation: The groups are "a" and "bbbbbbbbbbbb". This compresses to "ab12".

const std = @import("std");
const expect = std.testing.expect;

fn compress(chars: []u8, allocator: std.mem.Allocator) ![]const u8 {
    var left: usize = 0;
    var right: usize = 0;

    while (right < chars.len) {
        var j: usize = right + 1;
        while (j < chars.len and chars[j] == chars[j - 1]) : (j += 1) {}

        chars[left] = chars[right];
        left += 1;

        if (j != right + 1) {
            const itoa = try std.fmt.allocPrint(allocator, "{d}", .{j - right}); // int to ascii
            for (itoa) |n| {
                chars[left] = n;
                left += 1;
            }
        }

        right = j;
    }

    return chars[0..left];
}

test compress {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var input1 = "aabbccc".*;
    var input2 = "a".*;
    var input3 = "abbbbbbbbbbbb".*;

    const test_cases = [_]struct {
        input: []u8,
        output: []const u8,
        len: usize,
    }{
        .{
            .input = &input1,
            .len = 6,
            .output = "a2b2c3",
        },
        .{
            .input = &input2,
            .len = 1,
            .output = "a",
        },
        .{
            .input = &input3,
            .len = 4,
            .output = "ab12",
        },
    };

    for (test_cases) |tc| {
        const res = try compress(tc.input, allocator);
        try expect(std.mem.eql(u8, res, tc.output));
        try expect(res.len == tc.len);
    }
}

// iterate the flowerbed
// check each value
// if 1 skip
// if 0
// chech it is first index or isn't
// if it is the first index okay so left size true
// if it isn't the first index, check left side
// if left true , check the right side
// if it is the last index, so it true
// if it isn't check the right side, which is the next val
// if both side true.
// plant it
//
