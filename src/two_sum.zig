// Example 1:
// Input: nums = [2,7,11,15], target = 9
// Output: [0,1]
// Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
// Example 2:
// Input: nums = [3,2,4], target = 6
// Output: [1,2]
// Example 3:
// Input: nums = [3,3], target = 6
// Output: [0,1]
// Example 4:
// Input: nums = [1,2,3,5] target = 6
// Output: [0,3];
//
//
// follow up : come up with an alg that is less than O(n^2) time complexity

const std = @import("std");
const allocator = std.testing.allocator;
const expect = std.testing.expect;

fn twoSum(nums: []i32, target: i32) ![2]i32 {
    var m = std.AutoHashMap(i32, i32).init(allocator);
    defer m.deinit();

    for (nums, 0..) |val, idx| {
        const difference: i32 = target - val;

        if (m.contains(difference)) {
            return [2]i32{ m.get(difference).?, @intCast(idx) };
        }
        try m.put(val, @intCast(idx));
    }
    return error.InvalidNumber;
}

test twoSum {
    var nums = [_]i32{ 3, 2, 4 };
    const expected = [2]i32{ 1, 2 };
    var start: usize = 0;
    _ = &start;
    const target: i32 = 6;

    const out = try twoSum(nums[start..nums.len], target);
    try expect(std.mem.eql(i32, &out, &expected));
}

// map of index based on value
// iterate the array
// declare the diff
// if the diff found in the map ;
// return val, and the index
//
// insert the index to the map based on the val
