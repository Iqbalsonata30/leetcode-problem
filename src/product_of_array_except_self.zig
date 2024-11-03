// Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].
// The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
//
// You must write an algorithm that runs in O(n) time and without using the division operation.
//
// Example 1:
// Input: nums = [1,2,3,4]
// Output: [24,12,8,6]
//
// Example 2:
// Input: nums = [-1,1,0,-3,3]
// Output: [0,0,9,0,0]
//
// Constraint
// 2 <= nums.length <= 105
// -30 <= nums[i] <= 30
// The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
//
// Running Time : O(2N) Which is O(N)  and without using divison operation

const std = @import("std");
const expect = std.testing.expect;
const testing_allocator = std.testing.allocator;

fn productExceptSelf(nums: []i32, allocator: std.mem.Allocator) ![]i32 {
    var answer = std.ArrayList(i32).init(allocator);

    var left = std.ArrayList(i32).init(allocator);
    defer left.deinit();

    var right = std.ArrayList(i32).init(allocator);
    defer right.deinit();

    var current: i32 = 1;

    var i: usize = 1;
    while (i <= nums.len) : (i += 1) {
        try left.append(current);
        current *= nums[i - 1];
    }

    var j: usize = nums.len;
    current = 1;
    while (j > 0) : (j -= 1) {
        try right.append(current);
        current *= nums[j - 1];
    }

    i = 0;
    j = nums.len;

    while (i < nums.len and j > 0) : ({
        i += 1;
        j -= 1;
    }) {
        try answer.append(left.items[i] * right.items[j - 1]);
    }

    return try answer.toOwnedSlice();
}

const TestCase = struct {
    input: []i32,
    output: []i32,
};

test productExceptSelf {
    var input1 = [_]i32{ 1, 2, 3, 4 };
    var output1 = [_]i32{ 24, 12, 8, 6 };
    var input2 = [_]i32{ -1, 1, 0, -3, 3 };
    var output2 = [_]i32{ 0, 0, 9, 0, 0 };

    const test_cases = [_]TestCase{
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
        const res = try productExceptSelf(tc.input, testing_allocator);
        defer testing_allocator.free(res);
        try expect(std.mem.eql(i32, res, tc.output));
    }
}
