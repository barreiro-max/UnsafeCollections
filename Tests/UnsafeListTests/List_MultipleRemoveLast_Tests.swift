import Testing
@testable import UnsafeList

struct List_MultipleRemoveLast_Tests {
    private let list = UnsafeList<Int>()
    
    @Test func afterMultipleRemoveLast_expectedCount() throws {
        let values = [1,5,7,8,0,-6,2]
        list.append(data: values)
        
        let range = 1...3
        for _ in range {
            _ = try #require(try list.removeLast())
        }
        
        #expect(list.count == values.count - range.count)
    }
    
    @Test func afterMultipleRemoveLast_expectedFirst() throws {
        let values = [1,5,7,8,0,-6,2]
        list.append(data: values)
        
        let range = 1...3
        for _ in range {
            _ = try #require(try list.removeLast())
        }
        
        #expect(list.first == 1)
    }
    
    @Test func afterMultipleRemoveLast_expectedRemove() throws {
        let values = [1,5,7,8,0,-6,2]
        list.append(data: values)
        
        let range = 1...3
        for _ in range {
            _ = try #require(try list.removeLast())
        }
        
        let removed = try #require(try list.removeLast())
        #expect(removed == 8)
    }
    
    @Test func afterRemoveAll_list_isEmpty() {
        list.append(data: [1,4,7,8,4,2])
        list.removeAll()
        #expect(list.isEmpty)
    }
}

