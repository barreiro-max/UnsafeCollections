import Testing
@testable import UnsafeTree

struct BinaryTree_Search_Tests {
    private let tree = UnsafeTree<Int>()
    
    @Test func search_returnsTrue_forInsertedValue() {
        tree.insert(data: 2)
        
        #expect(tree.search(key: 2) == true)
    }
    
    @Test func search_returnsFalse_forNonexistentValue() {
        #expect(tree.search(key: 0) == false)
    }
    
    @Test
    func search_returnsTrue_inCompleteBinaryTree() {
        let values = [4,2,6,1,3,5,7]
        tree.insert(data: values)
        
        let allSearchIsSatisfy = values.allSatisfy {
            tree.search(key: $0)
        }
        #expect(allSearchIsSatisfy == true)
        
    }
    
    @Test func search_returnsFalse_inCompleteBinaryTree() {
        let values = [4,2,6,1,3,5,7]
        tree.insert(data: values)
        
        let missingValues = [0, 8, 10]
        let allSearchIsSatisfy = missingValues.allSatisfy {
            !tree.search(key: $0)
        }
        #expect(allSearchIsSatisfy == true)
    }
}
