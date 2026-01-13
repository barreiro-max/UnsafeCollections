import Testing
@testable import UnsafeQueue

struct EmptyQueue_Tests {
    private let queue = UnsafeQueue<Int>()
    
    @Test func emptyqueue_isEmpty() {
        #expect(queue.isEmpty == true)
    }

    @Test func emptyqueue_isCountZero() {
        #expect(queue.count == 0)
    }
    
    @Test func emptyqueue_first_returnsNil() {
        #expect(queue.first == nil)
    }

    @Test func emptyqueue_pop_returnsNil() {
        #expect(queue.dequeue() == nil)
    }
}

