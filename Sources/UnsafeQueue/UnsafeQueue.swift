@_exported import UnsafeCollectionsCore

/// A queue data structure implemented as a singly-linked list using unsafe memory operations.
///
/// This type is intended for educational purposes to demonstrate
/// manual memory management and pointer-based data structures.
///
/// **Warning:** This type is unsafe. Do not use in production.
public final class UnsafeQueue<Element>: UnsafeCollection {

    /// The type of elements stored in the queue.
    public typealias Element = Element

    /// A pointer to the first node in the queue.
    private var head: BasicNodePointer<Element>?

    /// A pointer to the last node in the queue.
    private var tail: BasicNodePointer<Element>?

    /// The first element in the queue.
    public var first: Element? {
        head?.pointee.data
    }

    /// The number of elements in the queue.
    public var count: Int

    /// Creates a new, empty queue.
    public init() {
        self.count = 0
    }

    /// Creates a queue from a collection of elements.
    public convenience init<S: Sequence>(
        collection: S
    ) where S.Element == Element {
        self.init()
        self.enqueue(data: collection)
    }

    deinit {
        removeAll()
    }

    /// Adds a single element to the end of the queue.
    public func enqueue(data: Element) {
        defer { count += 1 }
        guard head != nil else {
            head = BasicNode.allocate(by: data)
            tail = head
            return
        }
        let newNodePtr = BasicNode.allocate(by: data)
        tail?.pointee.next = newNodePtr
        tail = newNodePtr
    }

    /// Adds multiple elements to the end of the queue.
    public func enqueue<S: Sequence>(
        data: S
    ) where S.Element == Element {
        for value in data {
            enqueue(data: value)
        }
    }

    /// Removes and returns the first element in the queue.
    @discardableResult
    public func dequeue() -> Element? {
        let temp = head
        let dequeueData = temp?.pointee.data
        head = head?.pointee.next
        BasicNode.deallocate(ptr: temp)
        if count > 0 { count -= 1 }
        return dequeueData
    }

    /// Removes all elements from the queue.
    public func removeAll() {
        while !isEmpty { dequeue() }
    }
}

extension UnsafeQueue: ExpressibleByArrayLiteral {
    /// Creates a queue from the given array literal.
    public convenience init(arrayLiteral elements: Element...) {
        self.init()
        self.enqueue(data: elements)
    }
}

extension UnsafeQueue: ExpressibleByNilLiteral {
    /// Creates an empty queue from a nil literal.
    public convenience init(nilLiteral: ()) {
        self.init()
    }
}
