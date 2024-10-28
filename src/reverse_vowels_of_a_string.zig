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
const allocator = std.testing.allocator;

fn reverseVowels(s: []const u8) ![]const u8 {
    var slice_str = try allocator.dupe(u8, s);
    defer allocator.free(slice_str);
    var i: usize = 0;
    var j: usize = s.len - 1;
    while (i < j) {
        while (i < j and !isVowels(s[i])) {
            i += 1;
        }
        while (i < j and !isVowels(s[j])) {
            j -= 1;
        }
        if (i < j) {
            slice_str[i] ^= slice_str[j];
            slice_str[j] ^= slice_str[i];
            slice_str[i] ^= slice_str[j];
            i += 1;
            j -= 1;
        }
    }
    return slice_str;
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
        const res = try reverseVowels(tc.input);
        _ = res;
    }
}
