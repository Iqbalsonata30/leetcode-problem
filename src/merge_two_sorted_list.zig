// Example 1:
// Input: list1 = [1,2,4], list2 = [1,3,4]
// Output: [1,1,2,3,4,4]
//
//
// list = undefined null
// list1.val = 1 list1_next2 -> list1.val = 2 list1_next3 -> list1.val = 4 null
// list2.val = 1 list2_next2 -> list2.val = 3 list2_next3 -> list2.val = 4 null
//
// node = new(ListNode)
// curr = node;
//
// for(list1 != null or list != null)
//  if list1 != null and list2 != null and list1.val <= list2.val or list2 == nul
//      curr = list1;
//      list1 = list1.Next
//  else if list2 != null
//      curr = list2;
//      list2 = list2.Next
//
//  curr = curr.Next
//
//  return node.Next;
//
// Example 2:
// Input: list1 = [], list2 = []
// Output: []

// Example 3:
// Input: list1 = [], list2 = [0]
// Output: [0]

// Constraint
// The number of nodes in both lists is in the range [0, 50].
// -100 <= Node.val <= 100
// Both list1 and list2 are sorted in non-decreasing order.

const std = @import("std");
const expect = std.testing.expect;

const ListNode = struct {
    val: i8,
    next: ?*ListNode = null,
};

fn initNode(val: i8, next: ?*ListNode) !*ListNode {
    const allocator = std.heap.page_allocator;
    const node = try allocator.create(ListNode);

    node.* = ListNode{
        .val = val,
        .next = next,
    };
    return node;
}

fn mergeTwoLists(list1: *ListNode, list2: *ListNode) *ListNode {
    var list_node: ListNode = .{ .val = undefined };
    var current_node: *ListNode = &list_node;
    var l1: ?*ListNode = list1;
    var l2: ?*ListNode = list2;

    // l1 = 1,
    // l2 = 1,3,4
    while (l1 != null or l2 != null) {
        if (l1 != null and l2 != null and l1.?.val <= l2.?.val or l2 == null) {
            if (l1) |ln1| {
                current_node.next = ln1;
                l1 = ln1.next;
            }
        } else if (l2 != null) {
            if (l2) |ln2| {
                current_node.next = ln2;
                l2 = ln2.next;
            }
        } else {
            break;
        }
        if (current_node.next) |next_node| {
            current_node = next_node;
        }
    }
    return list_node.next.?;
}

test mergeTwoLists {
    var list1_node3 = try initNode(4, null);
    var list1_node2 = try initNode(2, list1_node3);
    var list1_node1 = try initNode(1, list1_node2);
    _ = &list1_node3;
    _ = &list1_node2;
    _ = &list1_node1;

    var list2_node3 = try initNode(4, null);
    var list2_node2 = try initNode(3, list2_node3);
    var list2_node1 = try initNode(1, list2_node2);
    _ = &list2_node3;
    _ = &list2_node2;
    _ = &list2_node1;

    const res = mergeTwoLists(list1_node1, list2_node1);
    std.debug.print("list node :{any}\n", .{res});
}
