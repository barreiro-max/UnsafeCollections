import Testing
@testable import UnsafeStack

struct EmptyStack_Tests {
    private let stack = UnsafeStack<Int>()
    
    @Test func emptyStack_isEmpty() {
        #expect(stack.isEmpty == true)
    }

    @Test func emptyStack_isCountZero() {
        #expect(stack.count == 0)
    }
    
    @Test func emptyStack_peek_returnsNil() {
        #expect(stack.first == nil)
    }

    @Test func emptyStack_pop_returnsNil() {
        #expect(stack.pop() == nil)
    }
}
