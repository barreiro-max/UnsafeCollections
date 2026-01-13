import Testing
@testable import UnsafeList

struct List_MultipleRemoveFirst_Tests {
    private let list = UnsafeList<Int>()
    
    @Test func afterMultipleRemoveFirst_expectedCount() throws {
        let values = [1,5,7,8,0,-6,2]
        list.append(data: values)
        
        let range = 1...3
        for _ in range {
            _ = try #require(try list.removeFirst())
        }
        
        #expect(list.count == values.count - range.count)
    }
    
    @Test func afterMultipleRemoveFirst_expectedFirst() throws {
        let values = [1,5,7,8,0,-6,2]
        list.append(data: values)
        
        let range = 1...3
        for _ in range {
            _ = try #require(try list.removeFirst())
        }
        
        #expect(list.first == 8)
    }
    
    @Test func afterMultipleRemoveFirst_expectedRemove() throws {
        let values = [1,5,7,8,0,-6,2]
        list.append(data: values)
        
        let range = 1...3
        for _ in range {
            _ = try #require(try list.removeFirst())
        }
        
        let removed = try #require(try list.removeFirst())
        #expect(removed == 8)
    }
    
    @Test func afterRemoveAll_list_isEmpty() {
        list.append(data: [1,4,7,8,4,2])
        list.removeAll()
        #expect(list.isEmpty)
    }
}
