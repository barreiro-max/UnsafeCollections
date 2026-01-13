import Testing
@testable import UnsafeQueue

struct Queue_MultipleEnqueue_Tests {
    private let queue = UnsafeQueue<Int>()
    
    @Test func onMultipleEnqueue_expectedSize() {
        let values = [1,5,8,-9,0]
        queue.enqueue(data: values)
        #expect(queue.count == values.count)
    }

    @Test func onMultipleEnqueue_expectedPeek() throws {
        let values = [1,5,8,-9,0]
        queue.enqueue(data: values)
        try #require(
            queue.first == values.first,
            "Expected the first value from the array"
        )
    }
    
    @Test func onMultipleEnqueue_isEmpty_returnsFalse() {
        let values = [1,5,8,-9,0]
        queue.enqueue(data: values)
        #expect(!queue.isEmpty)
    }

}
