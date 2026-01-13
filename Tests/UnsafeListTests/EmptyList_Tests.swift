import Testing
@testable import UnsafeList

struct EmptyList_Tests {
    private let list = UnsafeList<Int>()
    
    @Test func emptyList_isEmpty() {
        #expect(list.isEmpty == true)
    }

    @Test func emptyList_isCountZero() {
        #expect(list.count == 0)
    }
    
    @Test func emptyList_first_returnsNil() {
        #expect(list.first == nil)
    }
    
    @Test func emptyList_last_returnsNil() {
        #expect(list.last == nil)
    }

    @Test func emptyList_removeAtZeroPos_returnsNil() throws {
        let position = 0
        try #require(
            try list.remove(at: position) == nil,
            "Remove throws an error when passed an invalid position."
        )
    }
}
