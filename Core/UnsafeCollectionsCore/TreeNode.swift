/// A pointer to a `TreeNode` of type `T`.
///
/// Used for manual memory management in the tree structure.
package typealias TreeNodePointer<T> = UnsafeMutablePointer<TreeNode<T>>

/// A node in a binary tree, holding a value and optional left and right children.
package struct TreeNode<T> {
    
    /// The value stored in this node.
    package var data: T
    
    /// Pointer to the left child node, or `nil` if none.
    package var left: TreeNodePointer<T>?
    
    /// Pointer to the right child node, or `nil` if none.
    package var right: TreeNodePointer<T>?
    
    /// Creates a new tree node with optional left and right children.
    ///
    /// - Parameters:
    ///   - data: The value to store in the node.
    ///   - left: Optional pointer to the left child node. Defaults to `nil`.
    ///   - right: Optional pointer to the right child node. Defaults to `nil`.
    package init(
        data: T,
        left: TreeNodePointer<T>? = nil,
        right: TreeNodePointer<T>? = nil
    ) {
        self.data = data
        self.left = left
        self.right = right
    }
}

package extension TreeNode {
    
    /// Allocates a new `TreeNode` in memory and returns a pointer to it.
    ///
    /// - Parameter data: The value to store in the newly allocated node.
    /// - Returns: A pointer to the newly allocated `TreeNode`.
    static func allocate(
        by data: T
    ) -> TreeNodePointer<T> {
        let ptr = TreeNodePointer<T>.allocate(capacity: 1)
        ptr.initialize(to: TreeNode(data: data))
        return ptr
    }
    
    /// Deallocates a previously allocated `TreeNode` pointer.
    ///
    /// - Parameters:
    ///   - ptr: The pointer to deallocate.
    ///   - count: Number of instances to deinitialize (default is 1).
    static func deallocate(
        ptr: consuming TreeNodePointer<T>?,
        count: Int = 1
    ) {
        ptr?.deinitialize(count: count)
        ptr?.deallocate()
    }
}
