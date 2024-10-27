// Example 1:
// Input: s = "IceCreAm"
// Output: "AceCreIm"
// Explanation:
// The vowels in s are ['I', 'e', 'e', 'A']. On reversing the vowels, s becomes "AceCreIm".
//
// Example 2:
// Input: s = "leetcode"
// Output: "leotcede"

// Constraint
// s consists of printable ASCII characters

const std = @import("std");
const expect = std.testing.expect;

fn reverseVowels(s: []const u8) []const u8 {
    var low: usize = 0;
    var high: usize = s.len - 1;
    var it = std.mem.split(u8, s, "");
    while (low < high) {
        while(low < high and isVowels(c: u8)){

        }
    }
}

fn isVowels(c: u8) bool {
    return c == 'A' or c == 'I' or c == 'U' or c == 'E' or c == 'O' or c == 'a' or c == 'i' or c == 'u' or c == 'e' or c == 'o';
}

const TestCase = struct {
    input: []const u8,
    output: []const u8,
};

test reverseVowels {
    const test_cases = [_]TestCase{
        .{
            .input = "IceCreAm",
            .output = "AceCreIm",
        },
        .{
            .input = "leetcode",
            .output = "leotcede",
        },
    };

    for (test_cases) |tc| {
        const res = reverseVowels(tc.input);
        try expect(std.mem.eql(u8, tc.output, res));
    }
}
