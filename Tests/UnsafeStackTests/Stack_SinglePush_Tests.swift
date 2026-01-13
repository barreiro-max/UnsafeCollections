import Testing
@testable import UnsafeStack

struct Stack_SinglePush_Tests {
    private let stack = UnsafeStack<Int>()
    
    @Test func onSinglePush_isCountOne() {
        let value = 0
        let expectedSize = 1
        stack.push(data: value)
        #expect(stack.count == expectedSize)
    }
    
    @Test func onSinglePush_expectedPeek() {
        let value = 0
        stack.push(data: value)
        #expect(stack.first == value)
    }
    
    @Test func onSinglePush_isEmpty_returnsFalse() {
        let value = 0
        stack.push(data: value)
        #expect(!stack.isEmpty)
    }
}
