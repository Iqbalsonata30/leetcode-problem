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

const std = @import("std");
const allocator = std.testing.allocator;
const expect = std.testing.expect;
const assert = std.debug.assert;

fn removeDuplicates(nums: []i8, expected: []i8) !i8 {
    var buf = std.AutoHashMap(i8, bool).init(allocator);
    defer buf.deinit();
    var len: i8 = 0;

    for (nums, 0..) |num, i| {
        if (buf.contains(num)) {
            nums[i] = '_';
            len -= 1;
        }
        try buf.put(num, true);
        len += 1;
    }

    assert(std.mem.eql(i8, expected, nums[0..5]));

    return len;
}

const TestCase = struct {
    input: [5]i8,
    expect: [4]i8,
    output: u16,
};

test removeDuplicates {
    var test_cases = [_]TestCase{
        .{
            .input = [5]i8{ 1, 1, 2, 3, 4 },
            .expect = [4]i8{ 1, 2, 3, 4 },
            .output = 4,
        },
    };
    var i: u16 = 0;
    while (i < test_cases.len) : (i += 1) {
        var slice_idx: u16 = 0;
        _ = &slice_idx;
        const res = try removeDuplicates(test_cases[i].input[slice_idx..test_cases[i].input.len], test_cases[i].expect[slice_idx..test_cases[i].expect.len]);
        try expect(res == test_cases[i].output);
    }
}

// iterate the array
// map the each of value and set to be true
// if the next value is true remove it
//
//
