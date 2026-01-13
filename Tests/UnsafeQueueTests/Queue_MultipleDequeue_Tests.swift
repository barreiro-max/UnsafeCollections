import Testing
@testable import UnsafeQueue

struct Queue_MultipleDequeue_Tests {
    private let queue = UnsafeQueue<Int>()
    
    @Test func afterMultipledequeue_expectedCount() {
        let values = [1,5,7,8,0,-6,2]
        queue.enqueue(data: values)
        
        let range = 1...3
        for _ in range {
            queue.dequeue()
        }
        
        #expect(queue.count == values.count - range.count)
    }
    
    @Test func afterMultipleDequeue_expectedPeek() {
        let values = [1,5,7,8,0,-6,2]
        queue.enqueue(data: values)
        
        let range = 1...3
        for _ in range {
            queue.dequeue()
        }
        
        #expect(queue.first == 8)
    }
    
    @Test func afterMultipleDequeue_expectedDequeue() {
        let values = [1,5,7,8,0,-6,2]
        queue.enqueue(data: values)
        
        let range = 1...3
        for _ in range {
            queue.dequeue()
        }
        #expect(queue.dequeue() == 8)
    }
    
    @Test func afterRemoveAll_queue_isEmpty() {
        queue.enqueue(data: [1,4,7,8,4,2])
        queue.removeAll()
        #expect(queue.isEmpty)
    }
}
