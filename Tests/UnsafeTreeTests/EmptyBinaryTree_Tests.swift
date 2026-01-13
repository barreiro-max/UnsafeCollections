import Testing
@testable import UnsafeTree

struct EmptyBinaryTree_Tests {
    private let emptyTree: UnsafeTree<Int> = nil
    
    @Test func count_IsZero() {
        #expect(emptyTree.count == 0)
    }
    
    @Test func height_IsZero() {
        #expect(emptyTree.height == 0)
    }
    
    @Test func minAndMax_EqualNil() {
        #expect(emptyTree.min == nil)
        #expect(emptyTree.max == nil)
    }
    
    @Test(arguments: TraversalOrder.allCases)
    func isEmptyTraversalArray_ForEachTraversal(traversal: TraversalOrder) {
        #expect(emptyTree.traversal(order: traversal) == [])
    }
    
    @Test func remove_onEmptyTree_keepsTreeEmpty() {
        emptyTree.remove(data: 5)
        #expect(emptyTree.count == 0)
        #expect(emptyTree.traversal(order: .in) == [])
    }
    
    @Test func removeAll_onEmptyTree_keepsTreeEmpty() {
        emptyTree.removeAll()
        #expect(emptyTree.count == 0)
        #expect(emptyTree.traversal(order: .in) == [])
    }


}
