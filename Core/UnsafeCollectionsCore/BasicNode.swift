/// A pointer to a `BasicNode` of type `T`.
///
/// Used for manual memory management in linear list structures like stacks and queues.
package typealias BasicNodePointer<T> = UnsafeMutablePointer<BasicNode<T>>

/// A node in a singly-linked list, holding a value and an optional pointer to the next node.
package struct BasicNode<T> {
    
    /// The value stored in this node.
    package var data: T
    
    /// Pointer to the next node in the list, or `nil` if this is the last node.
    package var next: BasicNodePointer<T>?
    
    /// Creates a new basic node with an optional next node.
    ///
    /// - Parameters:
    ///   - data: The value to store in the node.
    ///   - next: Optional pointer to the next node. Defaults to `nil`.
    package init(
        data: T,
        next: BasicNodePointer<T>? = nil
    ) {
        self.data = data
        self.next = next
    }
}

package extension BasicNode {
    
    /// Allocates a new `BasicNode` in memory and returns a pointer to it.
    ///
    /// - Parameter data: The value to store in the newly allocated node.
    /// - Returns: A pointer to the newly allocated `BasicNode`.
    static func allocate(by data: T) -> BasicNodePointer<T> {
        let ptr = BasicNodePointer<T>.allocate(capacity: 1)
        ptr.initialize(to: BasicNode(data: data))
        return ptr
    }
    
    /// Deallocates a previously allocated `BasicNode` pointer.
    ///
    /// - Parameters:
    ///   - ptr: The pointer to deallocate.
    ///   - count: Number of instances to deinitialize (default is 1).
    static func deallocate(ptr: consuming BasicNodePointer<T>?, count: Int = 1) {
        ptr?.deinitialize(count: count)
        ptr?.deallocate()
    }
}
