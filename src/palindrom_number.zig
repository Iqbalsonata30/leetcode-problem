// follow up : solve it without converting the integer to a string
//
// Example 1:
// Input: x = 121
// Output: true
// Explanation: 121 reads as 121 from left to right and from right to left.

const std = @import("std");
const expect = std.testing.expect;

fn isPalindrome(x: i32) bool {
    if (x < 0) {
        return false;
    }
    var temp: i32 = x;
    var val: i32 = 0;

    while (temp > 0) {
        val = if (temp < 10) (val + @rem(temp, 10)) else (val + @rem(temp, 10)) * 10;
        temp = @divFloor(temp, 10);
    }
    return x == val;
}

test isPalindrome {
    const inputs = [_]i32{ 121, -121, 10, 33 };
    const outputs = [_]bool{ true, false, false, true };

    for (inputs, outputs) |input, output| {
        const res = isPalindrome(input);
        try expect(res == output);
    }
}
