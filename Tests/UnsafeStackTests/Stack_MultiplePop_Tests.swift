import Testing
@testable import UnsafeStack

struct Stack_MultiplePop_Tests {
    private let stack = UnsafeStack<Int>()
    
    @Test func afterMultiplePop_expectedCount() {
        let values = [1,5,7,8,0,-6,2]
        stack.push(data: values)
        
        let range = 1...3
        for _ in range {
            stack.pop()
        }
        
        #expect(stack.count == values.count - range.count)
    }
    
    @Test func afterMultiplePop_expectedPeek() {
        let values = [1,5,7,8,0,-6,2]
        stack.push(data: values)
        
        let range = 1...3
        for _ in range {
            stack.pop()
        }
        
        #expect(stack.first == 8)
    }
    
    @Test func afterMultiplePop_expectedPop() {
        let values = [1,5,7,8,0,-6,2]
        stack.push(data: values)
        
        let range = 1...3
        for _ in range {
            stack.pop()
        }
        #expect(stack.pop() == 8)
    }
    
    @Test func afterRemoveAll_stack_isEmpty() {
        stack.push(data: [1,4,7,8,4,2])
        stack.removeAll()
        #expect(stack.isEmpty)
    }
}
