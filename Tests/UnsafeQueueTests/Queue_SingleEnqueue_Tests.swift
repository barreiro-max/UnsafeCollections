import Testing
@testable import UnsafeQueue

struct Queue_SingleEnqueue_Tests {
    private let queue = UnsafeQueue<Int>()
 
    @Test func onSingleEnqueue_expectedCount_EqualOne() {
        let value = 1
        queue.enqueue(data: value)
        #expect(queue.count == 1)
    }

    @Test func onSingleEnqueue_expectedFirst() {
        let value = 235
        let expectedValue = value
        queue.enqueue(data: value)
        #expect(queue.first == expectedValue)
    }
    
    @Test func onSingleEnqueue_isEmpty_returnsFalse() {
        let value = 0
        queue.enqueue(data: value)
        #expect(!queue.isEmpty)
    }
    
}
