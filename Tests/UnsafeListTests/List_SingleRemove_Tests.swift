import Testing
@testable import UnsafeList

struct List_SingleRemove_Tests {
    private let list = UnsafeList<Int>()
    
    @Test func afterSingleRemove_count_isExpectedZero() throws {
        list.append(data: 5)
        let _ = try #require(
            try list.remove(at: 0)
        )
        #expect(list.count == 0)
    }
    
    @Test func afterSingleRemove_isExpectedFirst() throws {
        list.append(data: 5)
        
        let expectedFirst = 1
        list.append(data: expectedFirst)
        let _ = try #require(
            try list.remove(at: 0)
        )
        
        #expect(list.first == expectedFirst)
    }
    
    @Test func afterSingleAppend_And_SingleRemove_expectedRemoved() throws {
        let value = 10
        list.append(data: value)
        
        let expectedRemove = try #require(
            try list.remove(at: 0)
        )
        
        #expect(value == expectedRemove)
    }
    
    @Test func afterSingleAppend_And_SingleRemove_list_isEmpty() throws {
        list.append(data: 0)
        let _ = try #require(
            try list.remove(at: 0)
        )
        #expect(list.isEmpty)
    }
}
