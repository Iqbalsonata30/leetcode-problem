// Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.
//
// Note that you must do this in-place without making a copy of the array.
//
// Example 1:
// Input: nums = [0,1,0,3,12]
// Output: [1,3,12,0,0]
//
// Example 2:
// Input: nums = [0]
// Output: [0]

const std = @import("std");
const expect = std.testing.expect;

// i can solve it with insertion sort, but the running is damn bad, that is O(n^2)
// let's improve it
fn moveZeroes(nums: []i32) void {
    if (nums.len == 1) {
        return;
    }
    var left: usize = 0;
    var right: usize = 0;

    while (right < nums.len) : (right += 1) {
        if (nums[left] != 0) {
            left += 1;
        } else {
            if (nums[right] == 0) {
                continue;
            } else {
                nums[left] = nums[right];
                nums[right] = 0;
                left += 1;
            }
        }
    }
}

test moveZeroes {
    var input1 = [_]i32{ 0, 1, 0, 3, 2 };
    var input2 = [_]i32{0};

    var output1 = [_]i32{ 1, 3, 2, 0, 0 };
    var output2 = [_]i32{0};

    const test_cases = [_]struct {
        input: []i32,
        output: []i32,
    }{
        .{
            .input = &input1,
            .output = &output1,
        },
        .{
            .input = &input2,
            .output = &output2,
        },
    };

    for (test_cases) |tc| {
        moveZeroes(tc.input);
        try expect(std.mem.eql(i32, tc.input, tc.output));
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
