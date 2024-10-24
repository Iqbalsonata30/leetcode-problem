// Example 1:
//
// Input: nums = [1,2,3,1]
// Output: true
// Explanation:
// The element 1 occurs at the indices 0 and 3.
//
// Example 2:
//
// Input: nums = [1,2,3,4]
// Output: false
// Explanation:
// All elements are distinct.
//
// Example 3:
// Input: nums = [1,1,1,3,3,4,3,2,4,2]
// Output: true
//
// Constraint
// 1 <= nums.length <= 105
// -109 <= nums[i] <= 109

const std = @import("std");
const expect = std.testing.expect;
const allocator = std.testing.allocator;

fn containsDuplicate(nums: []i8) !bool {
    var map = std.AutoHashMap(i8, bool).init(allocator);
    defer map.deinit();

    for (nums) |num| {
        if (map.contains(num)) {
            return map.get(num).?;
        }
        try map.put(num, true);
    }
    return false;
}

const TestCase = struct {
    input: [5]i8,
    output: bool,
};
test containsDuplicate {
    var test_cases = [_]TestCase{
        .{
            .input = [5]i8{ 1, 2, 3, 1, 5 },
            .output = true,
        },
        .{
            .input = [5]i8{ 1, 2, 3, 4, 5 },
            .output = false,
        },
        .{
            .input = [5]i8{ 1, 1, 1, 1, 1 },
            .output = true,
        },
    };

    _ = &test_cases;
    var i: u32 = 0;
    while (i < test_cases.len) : (i += 1) {
        var tc = test_cases[i].input;
        const res = try containsDuplicate(tc[0..tc.len]);
        try expect(res == test_cases[i].output);
    }
}
