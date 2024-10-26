// Example 1:
// Input: flowerbed = [1,0,0,0,1], n = 1
// Output: true
//
// Example 2:
// Input: flowerbed = [1,0,0,0,1], n = 2
// Output: false
// Runing time is O(N)

const std = @import("std");
const expect = std.testing.expect;

fn canPlaceFlowers(flowerbed: []i32, n: i32) bool {
    var count: u32 = 0;

    for (flowerbed, 0..) |fb, i| {
        if (fb == 0) {
            const left_side: bool = (i == 0) or (flowerbed[i - 1] == 0);
            const right_side: bool = (i == flowerbed.len - 1) or (flowerbed[i + 1] == 0);

            if (left_side and right_side) {
                flowerbed[i] = 1;
                count += 1;
                if (count >= n) {
                    return true;
                }
            }
        }
    }
    return count >= n;
}

const TestCase = struct {
    input: []i32,
    flower: i32,
    output: bool,
};

test canPlaceFlowers {
    var input1 = [5]i32{ 1, 0, 0, 0, 1 };
    var input2 = [5]i32{ 1, 0, 0, 0, 1 };
    var input3 = [7]i32{ 1, 0, 0, 0, 1, 0, 0 };

    const test_cases = [_]TestCase{
        .{
            .input = &input1,
            .flower = 2,
            .output = false,
        },
        .{
            .input = &input2,
            .flower = 1,
            .output = true,
        },
        .{
            .input = &input3,
            .flower = 2,
            .output = true,
        },
    };

    for (test_cases) |tc| {
        const res = canPlaceFlowers(tc.input, tc.flower);
        try expect(res == tc.output);
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
