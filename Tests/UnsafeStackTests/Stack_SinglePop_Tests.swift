import Testing
@testable import UnsafeStack

struct Stack_SinglePop_Tests {
    private let stack = UnsafeStack<Int>()
    
    @Test func afterSinglePop_count_isExpectedZero() {
        stack.push(data: 5)
        stack.pop()
        #expect(stack.count == 0)
    }
    
    @Test func afterSinglePop_isExpectedPeek() {
        let value = 5
        let expectedPeek = value
        stack.push(data: value)
        
        stack.push(data: 0)
        stack.pop()
        
        #expect(stack.first == expectedPeek)
    }
    
    @Test func afterSinglePush_And_SinglePop_expectedPop() {
        let value = 10
        stack.push(data: 10)
        
        let expectedPop = stack.pop()
        
        #expect(value == expectedPop)
    }
    
    @Test func afterSinglePush_And_SinglePop_stack_isEmpty() {
        stack.push(data: 0)
        stack.pop()
        #expect(stack.isEmpty)
    }
}
