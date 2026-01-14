@_exported import UnsafeCollectionsCore

/// A stack data structure implemented as a singly-linked list using unsafe memory operations.
///
/// This type is intended for educational purposes to demonstrate
/// manual memory management and pointer-based data structures.
///
/// **Warning:** This type is unsafe. Do not use in production.
public final class UnsafeStack<Element>: UnsafeCollection {

    /// The type of elements stored in the stack.
    public typealias Element = Element

    /// A pointer to the top node in the stack.
    private var head: BasicNodePointer<Element>?

    /// Returns the element at the top without removing it.
    public var first: Element? {
        head?.pointee.data
    }
    
    /// The number of elements in the stack.
    public var count: Int

    /// Creates a new, empty stack.
    public init() {
        self.count = 0
    }

    /// Creates a stack from a collection of elements.
    public convenience init<S: Sequence>(
        collection: S
    ) where S.Element == Element {
        self.init()
        self.push(data: collection)
    }

    deinit {
        removeAll()
    }

    /// Pushes a single element onto the top of the stack.
    public func push(data: Element) {
        defer { count += 1 }
        guard head != nil else {
            head = BasicNode.allocate(by: data)
            return
        }
        let newHeadNode = BasicNode.allocate(by: data)
        newHeadNode.pointee.next = head
        head = newHeadNode
    }

    /// Pushes multiple elements onto the stack in order.
    public func push<S: Sequence>(
        data: S
    ) where S.Element == Element {
        for value in data {
            push(data: value)
        }
    }

    /// Removes and returns the element at the top of the stack.
    @discardableResult
    public func pop() -> Element? {
        let temp = head
        let poppedValue = temp?.pointee.data
        if !isEmpty { count -= 1 }
        head = temp?.pointee.next
        BasicNode.deallocate(ptr: temp)
        return poppedValue
    }

    /// Removes all elements from the stack.
    public func removeAll() {
        while !isEmpty { pop() }
    }
}

extension UnsafeStack: ExpressibleByArrayLiteral {
    /// Creates a stack from the given array literal.
    public convenience init(arrayLiteral elements: Element...) {
        self.init()
        self.push(data: elements)
    }
}

extension UnsafeStack: ExpressibleByNilLiteral {
    /// Creates an empty stack from a nil literal.
    public convenience init(nilLiteral: ()) {
        self.init()
    }
}
