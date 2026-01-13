import Testing
@testable import UnsafeTree

struct BinaryTree_Init_Tests {
    @Test func tree_initFromCollection_isExpectedCount() {
        let values = [2,3,1,5,4,7]
        let tree = UnsafeTree<Int>(collection: values)
        #expect(tree.count == values.count)
    }
    
    @Test func tree_initFromArrayLiteral_isExpectedCount() {
        let tree: UnsafeTree<Int> = [2,3,1,5,4,7]
        #expect(tree.count == 6)
    }
    
    @Test func tree_initFromNilLiteral_expectedCountZero() {
        let tree: UnsafeTree<Int> = nil
        #expect(tree.count == 0)
    }
}
