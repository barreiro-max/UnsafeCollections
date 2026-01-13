import Testing
@testable import UnsafeTree

struct BinaryTree_SingleInsert_Tests {
    private let tree = UnsafeTree<Int>()
    
    @Test func sizeIsOne() {
        tree.insert(data: 0)
        #expect(tree.count == 1)
    }
    
    @Test func heightIsOne() {
        tree.insert(data: 5)
        #expect(tree.height == 1)
    }
    
    @Test func minAndMaxEqual() {
        tree.insert(data: 3)
        #expect(tree.min == 3)
        #expect(tree.max == 3)
    }
    
    @Test(arguments: TraversalOrder.allCases)
    func checkEachTraversal_expectedInserted(traversal: TraversalOrder) {
        tree.insert(data: 5)
        #expect(tree.traversal(order: traversal) == [5])
    }
}
