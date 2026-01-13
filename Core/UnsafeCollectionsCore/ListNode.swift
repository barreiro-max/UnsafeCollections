/// A pointer to a `ListNode` of type `T`.
///
/// Used for manual memory management in linked list structures.
package typealias ListNodePointer<T> = UnsafeMutablePointer<ListNode<T>>

/// A node in a doubly-linked list, holding a value and optional next and previous nodes.
package struct ListNode<T> {
    
    /// The value stored in this node.
    package var data: T
    
    /// Pointer to the next node in the list, or `nil` if this is the last node.
    package var next: ListNodePointer<T>?
    
    /// Pointer to the previous node in the list, or `nil` if this is the first node.
    package var prev: ListNodePointer<T>?
    
    /// Creates a new list node with optional next and previous nodes.
    ///
    /// - Parameters:
    ///   - data: The value to store in the node.
    ///   - next: Optional pointer to the next node. Defaults to `nil`.
    ///   - prev: Optional pointer to the previous node. Defaults to `nil`.
    package init(
        data: T,
        next: ListNodePointer<T>? = nil,
        prev: ListNodePointer<T>? = nil
    ) {
        self.data = data
        self.next = next
        self.prev = prev
    }
}

package extension ListNode {
    
    /// Allocates a new `ListNode` in memory and returns a pointer to it.
    ///
    /// - Parameter data: The value to store in the newly allocated node.
    /// - Returns: A pointer to the newly allocated `ListNode`.
    static func allocate(
        by data: T
    ) -> ListNodePointer<T> {
        let ptr = ListNodePointer<T>.allocate(capacity: 1)
        ptr.initialize(to: ListNode(data: data))
        return ptr
    }
    
    /// Deallocates a previously allocated `ListNode` pointer.
    ///
    /// - Parameters:
    ///   - ptr: The pointer to deallocate.
    ///   - count: Number of instances to deinitialize (default is 1).
    static func deallocate(
        ptr: consuming ListNodePointer<T>?,
        count: Int = 1
    ) {
        ptr?.deinitialize(count: count)
        ptr?.deallocate()
    }
}
