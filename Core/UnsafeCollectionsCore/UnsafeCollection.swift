/// A base protocol for unsafe collections using manual memory management.
///
/// Types conforming to `UnsafeCollection` provide basic read-only access
/// to the first element, count of elements, and an `isEmpty` check.
public protocol UnsafeCollection {
    
    /// The type of elements stored in the collection.
    associatedtype Element
    
    /// The first element of the collection, or `nil` if empty.
    var first: Element? { get }
    
    /// Checks whether the collection contains no elements.
    var isEmpty: Bool { get }
    
    /// The total number of elements in the collection.
    var count: Int { get }
}

/// An unsafe collection that also exposes the last element.
public protocol UnsafeCollectionWithTail: UnsafeCollection {
    
    /// The last element of the collection, or `nil` if empty.
    var last: Element? { get }
}

public extension UnsafeCollection {
    
    /// Returns `true` if the collection has no elements, `false` otherwise.
    var isEmpty: Bool { count == 0 }
}
