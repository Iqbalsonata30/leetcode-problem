// You are given two strings word1 and word2. Merge the strings by adding letters in alternating order, starting with word1.
// If a string is longer than the other, append the additional letters onto the end of the merged string.
// Return the merged string.
//
// Example 1:
// Input: word1 = "abc", word2 = "pqr"
// Output: "apbqcr"
// Explanation: The merged string will be merged as so:
// word1:  a   b   c
// word2:    p   q   r
// merged: a p b q c r
//
// Example 2:
// Input: word1 = "ab", word2 = "pqrs"
// Output: "apbqrs"
// Explanation: Notice that as word2 is longer, "rs" is appended to the end.
// word1:  a   b
// word2:    p   q   r   s
// merged: a p b q   r   s
//
// Example 3:
// Input: word1 = "abcd", word2 = "pq"
// Output: "apbqcd"
// Explanation: Notice that as word1 is longer, "cd" is appended to the end.
// word1:  a   b   c   d
// word2:    p   q
// merged: a p b q c   d
//
// Constraint
// 1 <= word1.length, word2.length <= 100
// word1 and word2 consist of lowercase English letters.

// find the length of word 1
// find the length of word 2
// size tmp array = [word1 + word2]u8
// index = 0
// indexWord1 = 0;
// indexWord2 = 0;
//
//
// iterate the word1 and word2
// if word1 doesn't reach the end
//  tmpArr[index] = word1[i]
//  indexWord1 += 1
//  index += 1
//
// if word2 doesn't reach the end
// tmpArr[index] = word2[indexWord2]
// indexWord2 += 1
// index += 1
//
//
//return tmpArray
//

const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;
const allocator = std.testing.allocator;

fn mergeAlternately(word1: []const u8, word2: []const u8, alloc: Allocator) ![]const u8 {
    const lw1 = word1.len;
    const lw2 = word2.len;

    var iw1: u32 = 0;
    var iw2: u32 = 0;

    var merge_str = std.ArrayList(u8).init(alloc);
    //should be comptime known but it given run-time known

    while ((iw1 < lw1) or (iw2 < lw2)) {
        if (iw1 < lw1) {
            try merge_str.append(word1[iw1]);
            iw1 += 1;
        }
        if (iw2 < lw2) {
            try merge_str.append(word2[iw2]);
            iw2 += 1;
        }
    }
    return try merge_str.toOwnedSlice();
}

test mergeAlternately {
    const res = try mergeAlternately("ab", "pqrs", allocator);
    defer allocator.free(res);  
    
    try expect(std.mem.eql(u8,res,"apbqrs"));
}
