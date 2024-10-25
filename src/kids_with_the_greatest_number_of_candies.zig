// Example 1:
// Input: candies = [2,3,5,1,3], extraCandies = 3
// Output: [true,true,true,false,true]
// Explanation: If you give all extraCandies to:
// - Kid 1, they will have 2 + 3 = 5 candies, which is the greatest among the kids.
// - Kid 2, they will have 3 + 3 = 6 candies, which is the greatest among the kids.
// - Kid 3, they will have 5 + 3 = 8 candies, which is the greatest among the kids.
// - Kid 4, they will have 1 + 3 = 4 candies, which is not the greatest among the kids.
// - Kid 5, they will have 3 + 3 = 6 candies, which is the greatest among the kids.
//
// Example 2:
// Input: candies = [4,2,1,1,2], extraCandies = 1
// Output: [true,false,false,false,false]
// Explanation: There is only 1 extra candy.
// Kid 1 will always have the greatest number of candies, even if a different kid is given the extra candy.

// Constraints:
// n == candies.length
// 2 <= n <= 100
// 1 <= candies[i] <= 100
// 1 <= extraCandies <= 50
//
// i can solve it with n^2 but that is not good an idea, the best improvement is O(2N) which is O(N)
// because there's a skill issue in zig, the input and output limits to 5

const std = @import("std");
const expect = std.testing.expect;

fn kidsWithCandies(candies: [5]u8, extraCandies: u8) [5]bool {
    var result: [5]bool = undefined;
    var the_greatest: u8 = 0;
    for (candies) |candy| {
        if (candy > the_greatest) {
            the_greatest = candy;
        }
    }

    for (candies, 0..) |candy, i| {
        result[i] = if ((candy + extraCandies) >= the_greatest) true else false;
    }
    return result;
}

const TestCase = struct {
    input: [5]u8,
    extraCandies: u8,
    output: [5]bool,
};

test kidsWithCandies {
    const test_cases = [_]TestCase{
        .{
            .input = [5]u8{ 2, 3, 5, 1, 3 },
            .extraCandies = 3,
            .output = [5]bool{ true, true, true, false, true },
        },
    };

    for (test_cases) |tc| {
        const res = kidsWithCandies(tc.input, tc.extraCandies);
        try expect(std.mem.eql(bool, &tc.output, &res));
    }
}
