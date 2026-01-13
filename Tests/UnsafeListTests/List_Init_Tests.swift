import Testing
@testable import UnsafeList

struct List_Init_Tests {
    @Test func list_initFromCollection_isExpectedCount() {
        let values = [2,3,1,5,4,7]
        let list = UnsafeList<Int>(collection: values)
        #expect(list.count == values.count)
    }
    
    @Test func list_initFromArrayLiteral_isExpectedCount() {
        let list: UnsafeList<Int> = [2,3,1,5,4,7]
        #expect(list.count == 6)
    }
    
    @Test func list_initFromNilLiteral_expectedCountZero() {
        let list: UnsafeList<Int> = nil
        #expect(list.count == 0)
    }
}
    
    
