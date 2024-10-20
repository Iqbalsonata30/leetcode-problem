// Example 1:
// Input: nums = [1,1,2]
// Output: 2, nums = [1,2,_]
// Explanation: Your function should return k = 2, with the first two elements of nums being 1 and 2 respectively.
// It does not matter what you leave beyond the returned k (hence they are underscores).
//
// Example 2:
// Input: nums = [0,0,1,1,1,2,2,3,3,4]
// Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
// Explanation: Your function should return k = 5, with the first five elements of nums being 0, 1, 2, 3, and 4 respectively.
// It does not matter what you leave beyond the returned k (hence they are underscores).

// Constraints:
//
// 1 <= nums.length <= 3 * 104
// -100 <= nums[i] <= 100
// nums is sorted in non-decreasing order.

// initialize the pure index
// iterate the nums
// compare the nums is being iterated to the pure index
// if found
// increment the pure index
// set the value
// increment the pure index, so the first unique index added to the length
//

const std = @import("std");
const allocator = std.testing.allocator;
const expect = std.testing.expect;
const assert = std.debug.assert;

fn removeDuplicates(nums: []i8) u16 {
    var k: u16 = 0;

    for (nums) |num| {
        if (nums[k] != num) {
            k += 1;
            nums[k] = num;
        }
    }

    return k + 1;
}

const TestCase = struct {
    input: [5]i8,
    output: u16,
};

test removeDuplicates {
    var test_cases = [_]TestCase{
        .{
            .input = [5]i8{ 1, 1, 2, 3, 4 },
            .output = 4,
        },
        .{
            .input = [5]i8{ 1, 1, 1, 1, 1 },
            .output = 1,
        },
        .{
            .input = [5]i8{ 0, 0, 1, 1, 2 },
            .output = 3,
        },
    };
    var i: u16 = 0;
    while (i < test_cases.len) : (i += 1) {
        var slice_idx: u16 = 0;
        _ = &slice_idx;
        const res = removeDuplicates(test_cases[i].input[slice_idx..test_cases[i].input.len]);
        try expect(res == test_cases[i].output);
    }
}
