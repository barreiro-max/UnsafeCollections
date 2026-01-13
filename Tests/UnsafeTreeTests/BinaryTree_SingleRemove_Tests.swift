import Testing
@testable import UnsafeTree

struct BinaryTree_SingleRemove_Tests {
    private let tree = UnsafeTree<Int>()
    
    @Test
    func afterRemove_isSizeEqualZero() {
        tree.insert(data: 100)
        tree.remove(data: 100)
        #expect(tree.count == 0)
    }
    
    @Test
    func afterRemove_isHeightEqualZero() {
        tree.insert(data: 100)
        tree.remove(data: 100)
        #expect(tree.height == 0)
    }
    
    @Test(arguments: TraversalOrder.allCases)
    func afterRemove_traversal_isEmpty(traversal: TraversalOrder) {
        tree.insert(data: 100)
        tree.remove(data: 100)
        #expect(tree.traversal(order: traversal) == [])
    }
    
    @Test func afterRemove_minAndMaxEqualNil() {
        tree.insert(data: 100)
        tree.remove(data: 100)
        #expect(tree.max == nil)
        #expect(tree.min == nil)
    }
}
