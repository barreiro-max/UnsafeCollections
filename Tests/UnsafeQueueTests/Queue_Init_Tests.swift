import Testing
@testable import UnsafeQueue

struct Queue_Init_Tests {
    @Test func queue_initFromCollection_isExpectedCount() {
        let values = [2,3,1,5,4,7]
        let queue = UnsafeQueue<Int>(collection: values)
        #expect(queue.count == values.count)
    }
    
    @Test func queue_initFromArrayLiteral_isExpectedCount() {
        let queue: UnsafeQueue<Int> = [2,3,1,5,4,7]
        #expect(queue.count == 6)
    }
    
    @Test func queue_initFromNilLiteral_expectedCountZero() {
        let queue: UnsafeQueue<Int> = nil
        #expect(queue.count == 0)
    }
}
    
    
