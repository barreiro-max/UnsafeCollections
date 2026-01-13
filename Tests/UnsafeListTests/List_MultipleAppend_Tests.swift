import Testing
@testable import UnsafeList

struct List_MultipleAppend_Tests {
    private let list = UnsafeList<Int>()
    
    @Test func onMultipleAppend_expectedSize() {
        let values = [1,5,8,-9,0]
        list.append(data: values)
        #expect(list.count == values.count)
    }

    @Test func onMultipleAppend_expectedFirst() throws {
        let values = [1,5,8,-9,0]
        list.append(data: values)
        try #require(
            list.first == values.first,
            "Expected the first value from the array"
        )
    }
    
    @Test func onMultipleAppend_isEmpty_returnsFalse() {
        let values = [1,5,8,-9,0]
        list.append(data: values)
        #expect(!list.isEmpty)
    }
}
