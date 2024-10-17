// Example 1:
// Input: strs = ["flower","flow","flight"]
// Output: "fl"
//
// flower
// flow
// flight
// fly
//
// flower[..i+1] = f
//
//

// Example 2:
// Input: strs = ["dog","racecar","car"]
// Output: ""
// Explanation: There is no common prefix among the input strings.

// Constraints:
// 1 <= strs.length <= 200
// 0 <= strs[i].length <= 200
// strs[i] consists of only lowercase English letters.

const std = @import("std");
const expect = std.testing.expect;

fn longestCommonPrefix(strs: [][]const u8) []const u8 {
    const len: usize = strs[0].len - 1;
    var i: usize = 0;
    prloop: while (i <= len) : (i += 1) {
        for (strs) |str| {
            if (str[i] != strs[0][i]) {
                break :prloop;
            }
        }
    }

    if (i == 0) return "";

    return strs[0][0..i];
}

const TestCase = struct {
    input: [3][]const u8,
    output: []const u8,
};

test longestCommonPrefix {
    var test_cases = [_]TestCase{
        .{
            .input = .{ "flower", "flow", "flight" },
            .output = "fl",
        },
        .{
            .input = .{ "dog", "racecar", "car" },
            .output = "",
        },
        .{
            .input = .{ "component", "company", "computer" },
            .output = "comp",
        },
    };
    for (test_cases, 0..) |tc, i| {
        const res = longestCommonPrefix(&test_cases[i].input);
        try expect(std.mem.eql(u8, tc.output, res));
    }
}
