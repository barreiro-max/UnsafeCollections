import Testing
@testable import UnsafeList

struct List_MultiplePrepend_Tests {
    private let list = UnsafeList<Int>()
    
    @Test func onMultiplePrepend_expectedSize() {
        let values = [1,5,8,-9,0]
        list.prepend(data: values)
        #expect(list.count == values.count)
    }

    @Test func onMultiplePrepend_expectedFirst() throws {
        let values = [1,5,8,-9,0]
        list.prepend(data: values)
        try #require(
            list.first == values.last,
            "Expected the last value from the array"
        )
    }
    
    @Test func onMultiplePrepend_isEmpty_returnsFalse() {
        let values = [1,5,8,-9,0]
        list.prepend(data: values)
        #expect(!list.isEmpty)
    }
}
