import Testing
@testable import UnsafeTree

struct BinaryTree_MultipleRemove_Tests {
    private let tree = UnsafeTree<Int>()
    
   @Test func afterRemove_isExpectedSize() {
        let initialValues = [1,3,4,6,7]
        tree.insert(data: initialValues)
        
        let removedValues = [3,4,1]
        tree.remove(data: removedValues)
       
       let expectedCount = initialValues.filter { !removedValues.contains($0)
       }.count
       
       #expect(tree.count == expectedCount)
    }
    
    @Test func afterRemove_isExpectedHeight() {
        let initialValues = [4,3,5,1,7,6]
        tree.insert(data: initialValues)
        
        let removedValues = [3,4,1]
        tree.remove(data: removedValues)
        
        let expectedheight = 3
        #expect(tree.height == expectedheight)
    }
    
    @Test func afterRemoveAll_isExpectedEmptyTree() {
        tree.insert(data: [-1,4,5,-7,3,1,6,-81,0])
        
        tree.removeAll()
        #expect(tree.count == 0)
        #expect(tree.height == 0)
        #expect(tree.min == nil)
        #expect(tree.max == nil)
        #expect(tree.traversal(order: .bfs) == [])
    }
    
    @Suite
    struct TraversalAfterRemove_Tests {
        private let tree = UnsafeTree<Int>()
        
        @Test
        func preservesPreOrderTraversal_afterMultipleRemoves() {
            let values = [4,2,6,1,3,5,7]
            tree.insert(data: values)
            tree.remove(data: [3,4,1])
            let expectedPreOrder = [5,2,6,7]
            #expect(tree.traversal(order: .pre) == expectedPreOrder)
        }
        
        @Test
        func preservesInOrderTraversal_afterMultipleRemoves() {
            let values = [4,2,6,1,3,5,7]
            tree.insert(data: values)
            tree.remove(data: [3,4,1])
            let expectedInOrder = [2,5,6,7]
            #expect(tree.traversal(order: .in) == expectedInOrder)
        }
        
        @Test
        func preservesPostOrderTraversal_afterMultipleRemoves() {
            let values = [4,2,6,1,3,5,7]
            tree.insert(data: values)
            tree.remove(data: [3,4,1])
            let expectedPostOrder = [2,7,6,5]
            #expect(tree.traversal(order: .post) == expectedPostOrder)
        }
        
        @Test
        func preservesBFSTraversal_afterMultipleRemoves() {
            let values = [4,2,6,1,3,5,7]
            tree.insert(data: values)
            tree.remove(data: [3,4,1])
            let expectedBFSOrder = [5,2,6,7]
            #expect(tree.traversal(order: .bfs) == expectedBFSOrder)
        }
    }
    
}
