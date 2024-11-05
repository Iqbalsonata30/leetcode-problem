// Given an integer array nums, return true if there exists a triple of indices (i, j, k) such that i < j < k and nums[i] < nums[j] < nums[k].
// If no such indices exists, return false.
//
// Example 1:
// Input: nums = [1,2,3,4,5]
// Output: true
// Explanation: Any triplet where i < j < k is valid.
//
// Example 2:
// Input: nums = [5,4,3,2,1]
// Output: false
// Explanation: No triplet exists.
//
// Example 3:
// Input: nums = [2,1,5,0,4,6]
// Output: true
// Explanation: The triplet (3, 4, 5) is valid because nums[3] == 0 < nums[4] == 4 < nums[5] == 6.
//
// Constraint
// 1. -231 <= nums[i] <= 231 - 1

const std = @import("std");
const testing = std.testing;

fn increasingTriplet(nums: []i32) bool {
    var first: i32 = std.math.maxInt(i32);
    var second: i32 = std.math.maxInt(i32);

    return for (nums) |num| {
        if (num <= first) {
            first = num;
        } else if (num <= second) {
            second = num;
        } else {
            return true;
        }
    } else false;
}

test increasingTriplet {
    var input1 = [_]i32{ 1, 2, 3, 4, 5 };
    var input2 = [_]i32{ 5, 4, 3, 2, 1 };
    var input3 = [_]i32{ 2, 1, 5, 0, 4, 6 };
    var input4 = [_]i32{ 20, 100, 10, 12, 5, 13 };
    var input5 = [_]i32{ 5, 1, 6 };

    const test_cases = [_]struct {
        input: []i32,
        output: bool,
    }{
        .{
            .input = &input1,
            .output = true,
        },
        .{
            .input = &input2,
            .output = false,
        },
        .{
            .input = &input3,
            .output = true,
        },
        .{
            .input = &input4,
            .output = true,
        },
        .{
            .input = &input5,
            .output = false,
        },
    };

    for (test_cases) |tc| {
        const res = increasingTriplet(tc.input);
        try testing.expect(res == tc.output);
    }
}
