import Testing
@testable import UnsafeStack

struct Stack_MultiplePush_Tests {
    private let stack = UnsafeStack<Int>()
    
    @Test func onMultiplePush_expectedSize() {
        let values = [1,5,8,-9,0]
        stack.push(data: values)
        #expect(stack.count == values.count)
    }

    @Test func onMultiplePush_expectedPeek() throws {
        let values = [1,5,8,-9,0]
        stack.push(data: values)
        try #require(
            stack.first == values.last,
            "Expected the last value from the array"
        )
    }
    
    @Test func onMultiplePush_isEmpty_returnsFalse() {
        let values = [1,5,8,-9,0]
        stack.push(data: values)
        #expect(!stack.isEmpty)
    }

}
