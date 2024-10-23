// Step
//  find the lowest string
//  Set base to the lowest string
//  iterate the string
//  find the prefix len
//  if the remainder of the lowest string mod prefix len is not equal 0 skip it
//  set the prefix to the index
//
//  compare both of strings to the prefix
//  if each of string doesn't have same length with prefix break it
//  if does find the prefix index
//  and compare it character in the string with each character in the prefix
//  because we iterate the string, in case of string's length greater than prefix's length find the way
//  if each of character is not equal break it
//  if it is return true
//

const std = @import("std");
const expect = std.testing.expect;

fn gcdOfStrings(str1: []const u8, str2: []const u8) []const u8 {
    if (str2.len > str1.len) return gcdOfStrings(str2, str1);

    var i: usize = str2.len;

    while (i > 0) : (i -= 1) {
        const prefix_len = i;

        if (str2.len % prefix_len != 0) continue;
        const prefix = str2[0..i];

        if (dividesString(str2, prefix) and dividesString(str1, prefix)) {
            return prefix;
        }
    }

    return "";
}

fn dividesString(str: []const u8, prefix: []const u8) bool {
    if (str.len % prefix.len != 0) return false;
    for (str, 0..) |c, i| {
        const prefix_idx = i % prefix.len;
        if (c != prefix[prefix_idx]) {
            return false;
        }
    }
    return true;
}

const TestCase = struct {
    str1: []const u8,
    str2: []const u8,
    output: []const u8,
};

test gcdOfStrings {
    const test_cases = [_]TestCase{
        .{
            .str1 = "ABCABCABC",
            .str2 = "ABC",
            .output = "ABC",
        },
        .{
            .str1 = "ABABAB",
            .str2 = "ABAB",
            .output = "AB",
        },
        .{ .str1 = "LEET", .str2 = "CODE", .output = "" },
        .{
            .str1 = "ABCDEF",
            .str2 = "ABC",
            .output = "",
        },
    };

    for (test_cases) |tc| {
        const res = gcdOfStrings(tc.str1, tc.str2);
        try expect(std.mem.eql(u8, res, tc.output));
    }
}
