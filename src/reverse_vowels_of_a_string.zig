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
const allocator = std.heap.page_allocator;

fn reverseVowels(s: []const u8) []const u8 {
    var output = allocator.dupe(u8, s) catch |err| {
        std.debug.print("error : {?}\n", .{err});
        unreachable;
    };
    _ = &output;
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
            const high: u8 = s[j];
            std.mem.replaceScalar(u8, output, s[i], high);
            i += 1;
            j -= 1;
        }
    }
    std.debug.print(" {s}\n", .{output});
    return "";
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
        _ = res;
    }
}
