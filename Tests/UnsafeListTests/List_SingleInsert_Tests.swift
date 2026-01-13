import Testing
@testable import UnsafeList

struct List_SingleInsert_Tests {
    private let list = UnsafeList<Int>()
    
    @Test func onSingleInsert_isCountEqualOne() throws {
        try #require(
            try list.insert(at: 0, data: 1),
            "Insert throws an error when passed an invalid position."
        )
        #expect(list.count == 1)
    }
    
    @Test func onSingleInsert_expectedFirst() throws {
        let value = 14
        try #require(
            try list.insert(at: 0, data: value),
            "Insert throws an error when passed an invalid position."
        )
        #expect(list.first == value)
    }

    @Test func onSingleInsert_expectedLast() throws {
        let value = 123
        try #require(
            try list.insert(at: 0, data: value),
            "Insert throws an error when passed an invalid position."
        )
        #expect(list.last == value)
    }
    
    @Test func onSingleInsert_isEmpty_returnsFalse() throws {
        let value = 234
        try #require(
            try list.insert(at: 0, data: value),
            "Insert throws an error when passed an invalid position."
        )
        #expect(!list.isEmpty)
    }
}
