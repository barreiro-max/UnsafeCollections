import Testing
@testable import UnsafeStack

struct Stack_Init_Tests {
    @Test func stack_initFromCollection_isExpectedCount() {
        let values = [2,3,1,5,4,7]
        let stack = UnsafeStack<Int>(collection: values)
        #expect(stack.count == values.count)
    }
    
    @Test func stack_initFromArrayLiteral_isExpectedCount() {
        let stack: UnsafeStack<Int> = [2,3,1,5,4,7]
        #expect(stack.count == 6)
    }
    
    @Test func stack_initFromNilLiteral_expectedCountZero() {
        let stack: UnsafeStack<Int> = nil
        #expect(stack.count == 0)
    }
}
    
    
