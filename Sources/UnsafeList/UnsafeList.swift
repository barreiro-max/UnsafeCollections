import UnsafeCollectionsCore

/// A Doubly Circular Linked List that uses unsafe memory operations.
///
/// This type is intended for educational purposes to demonstrate
/// manual memory management and pointer-based data structures.
///
/// **Warning:** This type is unsafe. Do not use in production.
public final class UnsafeList<Element>: UnsafeCollectionWithTail {
    
    /// The type of elements stored in the list.
    public typealias Element = Element
    
    /// A pointer to the first node in the list.
    private var head: ListNodePointer<Element>?
    
    /// A pointer to the last node in the list.
    private var tail: ListNodePointer<Element>?
    
    /// The first element of list.
    public var first: Element? {
        head?.pointee.data
    }
    
    /// The last element of list.
    public var last: Element? {
        tail?.pointee.data
    }
    
    /// The number of elements in the list.
    public var count: Int
    
    /// Create a new, empty list.
    public init() {
        self.head = nil
        self.tail = nil
        self.count = 0
    }
    
    /// Creates a list containing the elements of the given sequence.
    public convenience init<S: Sequence>(
        collection: S
    ) where Element == S.Element {
        self.init()
        self.append(data: collection)
    }
    
    deinit {
        removeAll()
    }
        
    /// Inserts an element at the specified position in the list.
    ///
    /// - Parameters:
    ///   - pos: The index at which to insert the new element. Must be between `0` and `count`.
    ///   - data: The element to insert.
    /// - Throws: `ListError.positionOutOfBounds` if `pos` is invalid.
    public func insert(at pos: Int, data: Element) throws(ListError) {
        guard pos >= 0, pos <= count else {
            throw .positionOutOfBounds
        }
        
        defer { count += 1 }
        
        guard head != nil else {
            head = ListNode.allocate(by: data)
            
            // Closes the loop for single-element circular list.
            head?.pointee.next = head
            
            // Keeps backward link consistent.
            tail?.pointee.prev = head
                
            // Head and tail refer to the same node in single-element list.
            tail = head
            return
        }
        
        if pos == 0 {
            let newHead = ListNode.allocate(by: data)
            
            newHead.pointee.next = head
            
            newHead.pointee.prev = tail
            
            head?.pointee.prev = newHead
            
            tail?.pointee.next = newHead
            
            head = newHead
            return
        } else if pos == count {
            let newTail = ListNode.allocate(by: data)
            
            newTail.pointee.next = head
            newTail.pointee.prev = tail
            
            head?.pointee.prev = newTail
            tail?.pointee.next = newTail
            
            tail = newTail
            return
        } else {
            _insert(at: pos, data: data)
        }
    }
    
    /// Inserts a single element at the beginning of the list.
    public func prepend(data: Element) {
        try? insert(at: 0, data: data)
    }
    
    /// Inserts multiple elements at the beginning of the list, preserving order.
    public func prepend<S: Sequence>(
        data: S
    ) where S.Element == Element {
        for value in data {
            prepend(data: value)
        }
    }
    
    /// Inserts a single element at the end of the list.
    public func append(data: Element) {
        try? insert(at: count, data: data)
    }
    
    /// Inserts multiple elements at the end of the list, preserving order.
    public func append<S: Sequence>(
        data: S
    ) where S.Element == Element {
        for value in data {
            append(data: value)
        }
    }
    
    /// Removes and returns the element at the specified position.
    ///
    /// - Parameter pos: The index of the element to remove. Must be between `0` and `count`.
    /// - Throws: `ListError.positionOutOfBounds` if the index is invalid.
    /// - Returns: The removed element, or `nil` if the list is empty.
    @discardableResult
    public func remove(at pos: Int) throws(ListError) -> Element? {
        guard pos >= 0, pos <= count else {
            throw .positionOutOfBounds
        }
        
        guard head != nil else { return nil }
        
        defer { count -= 1 }
        if pos == 0 {
            let tempHead = head
            head = head?.pointee.next
            
            head?.pointee.prev = tail
            tail?.pointee.next = head
            let headValue = tempHead?.pointee.data

            ListNode.deallocate(ptr: tempHead)
            return headValue
        } else if pos == count - 1 {
            let tempTail = tail
            tail = tail?.pointee.prev
            
            tail?.pointee.next = head
            head?.pointee.prev = tail
            let tailValue = tempTail?.pointee.data
            ListNode.deallocate(ptr: tempTail)
            return tailValue
        } else {
            return _remove(at: pos)
        }
    }
    
    /// Removes and returns the first element of the list, or `nil` if empty.
    @discardableResult
    public func removeFirst() -> Element? {
        try? remove(at: 0)
    }

    /// Removes and returns the last element of the list, or `nil` if empty.
    @discardableResult
    public func removeLast() -> Element? {
        try? remove(at: count - 1)
    }

    /// Removes all elements from the list.
    public func removeAll() {
        while !isEmpty { removeFirst() }
    }
}

fileprivate extension UnsafeList {
    
    /// Inserts a new element at a specific position.
    ///
    /// - Note: This method is **internal to UnsafeList** and assumes the position is valid.
    ///         Use public `insert(at:data:)` to safely insert elements.
    /// - Parameter pos: The index at which to insert the element.
    /// - Parameter data: The element to insert.
    func _insert(at pos: Int, data: Element) {
        var prev = head
        for _ in 0..<(pos - 1) {
            prev = prev?.pointee.next
        }
        
        let newNode = ListNode.allocate(by: data)
        newNode.pointee.next = prev?.pointee.next
        
        prev?.pointee.next?.pointee.prev = newNode
        
        newNode.pointee.prev = prev
        prev?.pointee.next = newNode
    }
    
    /// zRemoves and returns the element at a specific position.
    ///
    /// - Note: This method is **internal to UnsafeList** and assumes the position is valid.
    ///         Use public `remove(at:)` to safely remove elements.
    /// - Parameter pos: The index of the element to remove.
    /// - Returns: The removed element, or `nil` if the list is empty.
    func _remove(at pos: Int) -> Element? {
        var prev = head
        for _ in 0..<(pos - 1) {
            prev = prev?.pointee.next
        }
        let tempNode = prev?.pointee.next
        prev?.pointee.next = tempNode?.pointee.next
        prev?.pointee.next?.pointee.prev = prev
        let tempValue = tempNode?.pointee.data
        ListNode.deallocate(ptr: tempNode)
        return tempValue
    }
}


extension UnsafeList: ExpressibleByArrayLiteral {
    /// Creates a list from the given array literal.
    public convenience init(arrayLiteral elements: Element...) {
        self.init()
        self.append(data: elements)
    }
}

extension UnsafeList: ExpressibleByNilLiteral {
    /// Creates an empty list from the nil literal.
    public convenience init(nilLiteral: ()) {
        self.init()
    }
}

/// Errors that can occur when working with `UnsafeList`.
public enum ListError: Error {
    /// Thrown when an operation is attempted at an index outside the valid range.
    case positionOutOfBounds
}
