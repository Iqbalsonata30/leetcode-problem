// An input string is valid if:
// 1. Open brackets must be closed by the same type of brackets.
// 2. Open brackets must be closed in the correct order.
// 3. Every close bracket has a corresponding open bracket of the same type.
//
// Example 1
// Input: s = "()"
// Output: true
//
// Example 2:
// Input: s = "()[]{}"
// Output: true
//
// Example 3:
// Input: s = "(]"
// Output: false
//
// Example 4:
// Input: s = "([])"
// Output: true

// Constraint
// s consists of parentheses only '()[]{}'.

const std = @import("std");
const expect = std.testing.expect;
const allocator = std.testing.allocator;

fn isValid(s: []const u8) !bool {
    const open_parentheses = [3]u8{ '(', '[', '{' };
    const close_parentheses = [3]u8{ ')', ']', '}' };

    var map = std.AutoHashMap(u8, u8).init(allocator);
    defer map.deinit();

    for (open_parentheses, close_parentheses) |open_p, close_p| {
        try map.put(open_p, close_p);
    }
    var stack = std.ArrayList(u8).init(allocator);
    defer stack.deinit();

    for (s) |c| {
        if (map.contains(c)) {
            try stack.append(c);
        } else {
            if (stack.items.len == 0 or map.get(stack.pop()).? != c) {
                return false;
            }
        }
    }
    return stack.items.len == 0;
}

const TestCase = struct {
    input: []const u8,
    output: bool,
};

test isValid {
    const test_cases = [_]TestCase{
        .{
            .input = "()",
            .output = true,
        },
        .{
            .input = "()[]{}",
            .output = true,
        },
        .{
            .input = "(]",
            .output = false,
        },
        .{
            .input = "([])",
            .output = true,
        },
        .{
            .input = "([)]",
            .output = false,
        },
        .{
            .input = "([{}])",
            .output = true,
        },
    };

    for (test_cases) |tc| {
        const res = try isValid(tc.input);
        try expect(res == tc.output);
    }
}
