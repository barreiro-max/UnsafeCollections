import Testing
@testable import UnsafeTree

@Suite
struct BinaryTree_MultipleInsert_Tests {
   
    @Suite
    struct DifferentValues_Tests {
        private let tree = UnsafeTree<Int>()

        @Test func isSizeEqualExpectedCount() {
            let values = [2,1,4,5,2]
            
            tree.insert(data: values)
            
            #expect(tree.count == values.count)
        }
        
        @Test func isExpectedHeight() {
            let values = [2,1,4,5,2]
            
            tree.insert(data: values)
            
            #expect(tree.height == 3)
        }
        
        @Test func isExpectedMinMax() {
            let values = [3,8,1,-1,7,-5,0]
            tree.insert(data: values)
            #expect(tree.min == values.min())
            #expect(tree.max == values.max())
        }
    }
    
    @Suite
    struct EqualValues_Tests {
        private let tree = UnsafeTree<Int>()

        @Test func isExpectedCount() {
            let values = [1,1,1,1]
            tree.insert(data: values)
            #expect(tree.count == values.count)
        }
        
        @Test func isHeightEqualSize() {
            let values = [0,0,0,0,0,0,0]
            tree.insert(data: values)
            #expect(tree.height == values.count)
        }
    }
    
    @Suite
    struct InsertEmptyArray_Tests {
        private let tree = UnsafeTree<Int>()

        @Test func emptyArray_isSizeZero() {
            tree.insert(data: [])
            #expect(tree.count == 0)
        }
        
        @Test func emptyArray_isHeightZero() {
            tree.insert(data: [])
            #expect(tree.height == 0)
        }
    }
    
    @Suite
    struct Traversal_Tests {
        private let tree = UnsafeTree<Int>()
        
        @Test func preservesPreOrderTraversal() {
            let values = [2,1,3,5,0]
            tree.insert(data: values)
            let expectedPreOrder = [2,1,0,3,5]
            #expect(tree.traversal(order: .pre) == expectedPreOrder)
        }
        
        @Test(arguments: [
            [2,1,3,5,0],
            [5,4,3,2,1],
            [1,2,3,4,5],
            [3,1,4,2,5],
        ])
        func preservesInOrderTraversal(values: [Int]) {
            tree.insert(data: values)
            #expect(tree.traversal(order: .in) == values.sorted())
        }
        
        @Test func preservesPostOrderTraversal() {
            let values = [2,1,3,5,0]
            tree.insert(data: values)
            let expectedPostOrder = [0,1,5,3,2]
            #expect(tree.traversal(order: .post) == expectedPostOrder)
        }

        @Test func preserves_BFS_traversal() {
            let values = [2,1,3,5,0]
            tree.insert(data: values)
            let expectedBFSOrder = [2,1,3,0,5]
            #expect(tree.traversal(order: .bfs) == expectedBFSOrder)
        }
    }
}
