import Testing
@testable import UnsafeQueue

struct Queue_SingleDequeue_Tests {
    private let queue = UnsafeQueue<Int>()
    
    @Test func afterSingleDequeue_count_isExpectedZero() {
        queue.enqueue(data: 5)
        queue.dequeue()
        #expect(queue.count == 0)
    }
    
    @Test func afterSingleDequeue_isExpectedFirst() {
        queue.enqueue(data: 5)
        
        let expectedFirst = 1
        queue.enqueue(data: expectedFirst)
        queue.dequeue()
        
        #expect(queue.first == expectedFirst)
    }
    
    @Test func afterSingleEnqueue_And_SingleDequeue_expectedPop() {
        let value = 10
        queue.enqueue(data: 10)
        
        let expectedDequeue = queue.dequeue()
        
        #expect(value == expectedDequeue)
    }
    
    @Test func afterSingleEnqueue_And_SingleDequeue_queue_isEmpty() {
        queue.enqueue(data: 0)
        queue.dequeue()
        #expect(queue.isEmpty)
    }
}
