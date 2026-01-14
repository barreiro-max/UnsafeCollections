@_exported import UnsafeCollectionsCore

/// A binary search tree implemented using unsafe memory operations.
///
/// This type is intended for educational purposes to demonstrate
/// manual memory management and pointer-based tree structures.
///
/// **Warning:** Unsafe operations are used. Do not use in production.
public final class UnsafeTree<Element: Comparable>: UnsafeCollection {

    /// The type of elements stored in the tree.
    public typealias Element = Element

    /// A pointer to the root node of the tree.
    private var root: TreeNodePointer<Element>?

    /// The first element in the tree (root value), or `nil` if the tree is empty.
    public var first: Element? {
        root?.pointee.data
    }

    /// The number of elements in the tree.
    public var count: Int

    /// The maximum element in the tree, or `nil` if empty.
    public var max: Element? {
        guard root != nil else { return nil }
        var current = root
        while current?.pointee.right != nil {
            current = current?.pointee.right
        }
        return current?.pointee.data
    }

    /// The minimum element in the tree, or `nil` if empty.
    public var min: Element? {
        guard root != nil else { return nil }
        var current = root
        while current?.pointee.left != nil {
            current = current?.pointee.left
        }
        return current?.pointee.data
    }

    /// The height of the tree.
    public var height: Int {
        func _height(root: TreeNodePointer<Element>?) -> Int {
            guard let root else { return 0 }
            let leftHeight = _height(root: root.pointee.left)
            let rightHeight = _height(root: root.pointee.right)
            return 1 + Swift.max(leftHeight, rightHeight)
        }
        return _height(root: root)
    }

    /// Creates a new, empty tree.
    public required init() {
        self.count = 0
    }

    /// Creates a tree containing elements from the given collection.
    public convenience init<S: Sequence>(
        collection: S
    ) where S.Element == Element {
        self.init()
        insert(data: collection)
    }

    /// Cleans up all allocated nodes when the tree is deallocated.
    deinit {
        removeAll()
    }

    // MARK: - Insert API

    /// Inserts a single element into the tree.
    ///
    /// - Parameter data: The element to insert.
    public func insert(data: Element) {
        root = _insert(node: root, data: data)
    }

    /// Inserts multiple elements into the tree.
    ///
    /// - Parameter data: A collection of elements to insert.
    public func insert<S: Sequence>(
        data: S
    ) where Element == S.Element {
        for value in data {
            insert(data: value)
        }
    }

    // MARK: - Remove API

    /// Removes a single element from the tree.
    ///
    /// - Parameter data: The element to remove.
    public func remove(data: Element) {
        root = _remove(node: root, data: data)
    }

    /// Removes multiple elements from the tree.
    ///
    /// - Parameter data: A collection of elements to remove.
    public func remove<S: Sequence>(data: S) where Element == S.Element {
        for value in data {
            remove(data: value)
        }
    }

    /// Removes all elements from the tree.
    public func removeAll() {
        while let root { remove(data: root.pointee.data) }
    }

    // MARK: - Search API

    /// Searches the tree for a given key.
    ///
    /// - Parameter key: The value to search for.
    /// - Returns: `true` if the key exists in the tree; otherwise `false`.
    public func search(key: Element) -> Bool {
        return _search(node: root, key: key)
    }

    // MARK: - Traversals

    /// Traverses the tree in a specified order.
    ///
    /// - Parameter order: The traversal order.
    /// - Returns: An array of elements in the traversal order.
    public func traversal(order: TraversalOrder) -> [Element] {
        var result = [Element]()
        switch order {
        case .pre:
            _preOrder(node: root, result: &result)
        case .in:
            _inOrder(node: root, result: &result)
        case .post:
            _postOrder(node: root, result: &result)
        case .bfs:
            _bfs(result: &result)
        }
        return result
    }
}

// MARK: - Insert, Remove and Search
fileprivate extension UnsafeTree {

    /// Inserts a new node into the tree at the correct position.
    ///
    /// - Note: This method is **internal to UnsafeTree** and assumes the caller
    ///         has already handled tree invariants and count management.
    /// - Parameters:
    ///   - node: The current subtree root.
    ///   - data: The element to insert.
    /// - Returns: The root of the modified subtree.
    func _insert(
        node: TreeNodePointer<Element>?,
        data: Element
    ) -> TreeNodePointer<Element>? {
        guard let node else {
            let newRoot = TreeNode.allocate(by: data)
            count += 1
            return newRoot
        }
        
        if data < node.pointee.data {
            node.pointee.left = _insert(node: node.pointee.left, data: data)
        } else {
            node.pointee.right = _insert(node: node.pointee.right, data: data)
        }
        return node
    }

    /// Removes a node with the given element from the tree.
    ///
    /// - Note: This method is **internal to UnsafeTree** and assumes the caller
    ///         has already handled count and root management.
    /// - Parameters:
    ///   - node: The current subtree root.
    ///   - data: The element to remove.
    /// - Returns: The root of the modified subtree.
    func _remove(
        node: TreeNodePointer<Element>?,
        data: Element
    ) -> TreeNodePointer<Element>? {
        guard let node else {
            return node
        }
        
        if data < node.pointee.data {
            node.pointee.left = _remove(node: node.pointee.left, data: data)
        } else if data > node.pointee.data {
            node.pointee.right = _remove(node: node.pointee.right, data: data)
        } else {
            if node.pointee.left == nil {
                let temp = node.pointee.right
                TreeNode.deallocate(ptr: node)
                count -= 1
                return temp
            }
            if node.pointee.right == nil {
                let temp = node.pointee.left
                TreeNode.deallocate(ptr: node)
                count -= 1
                return temp
            }
            
            let successor = getSuccessor(current: node)
            if let successorData = successor?.pointee.data {
                node.pointee.data = successorData
                node.pointee.right = _remove(node: node.pointee.right, data: successorData)
            }
        }
        return node
    }

    /// Finds the in-order successor of a given node.
    ///
    /// - Parameter current: The node whose successor is to be found.
    /// - Returns: The node containing the next larger element in the tree.
    private func getSuccessor(
        current: TreeNodePointer<Element>?
    ) -> TreeNodePointer<Element>? {
        var curr = current?.pointee.right
        while curr?.pointee.left != nil {
            curr = curr?.pointee.left
        }
        return curr
    }

    /// Searches for a key in the subtree rooted at `node`.
    ///
    /// - Note: This method is **internal to UnsafeTree**.
    /// - Parameters:
    ///   - node: The root of the current subtree.
    ///   - key: The value to search for.
    /// - Returns: `true` if the key exists in this subtree, otherwise `false`.
    func _search(
        node: TreeNodePointer<Element>?,
        key: Element
    ) -> Bool {
        guard let node else { return false }
        
        if node.pointee.data == key { return true }
        if key < node.pointee.data {
            return _search(node: node.pointee.left, key: key)
        } else {
            return _search(node: node.pointee.right, key: key)
        }
    }
}

// MARK: - Traversals
fileprivate extension UnsafeTree {
    /// Performs a **pre-order traversal** on the subtree rooted at `node`.
    ///
    /// - Note: This method is **internal to UnsafeTree**.
    /// - Parameters:
    ///   - node: The root of the current subtree.
    ///   - result: The array to accumulate traversal results.
    private func _preOrder(
        node: TreeNodePointer<Element>?,
        result: inout [Element]
    ) {
        guard let node else { return }
        result.append(node.pointee.data)
        _preOrder(node: node.pointee.left, result: &result)
        _preOrder(node: node.pointee.right, result: &result)
    }
    
    /// Performs an **in-order traversal** on the subtree rooted at `node`.
    ///
    /// - Note: This method is **internal to UnsafeTree**.
    /// - Parameters:
    ///   - node: The root of the current subtree.
    ///   - result: The array to accumulate traversal results.
    private func _inOrder(
        node: TreeNodePointer<Element>?,
        result: inout [Element]
    ) {
        guard let node else { return }
        _inOrder(node: node.pointee.left, result: &result)
        result.append(node.pointee.data)
        _inOrder(node: node.pointee.right, result: &result)
    }
    
    /// Performs a **post-order traversal** on the subtree rooted at `node`.
    ///
    /// - Note: This method is **internal to UnsafeTree**.
    /// - Parameters:
    ///   - node: The root of the current subtree.
    ///   - result: The array to accumulate traversal results.
    private func _postOrder(
        node: TreeNodePointer<Element>?,
        result: inout [Element]
    ) {
        guard let node else { return }
        _postOrder(node: node.pointee.left, result: &result)
        _postOrder(node: node.pointee.right, result: &result)
        result.append(node.pointee.data)
    }
    
    /// Performs a **breadth-first (level-order) traversal** on the tree.
    ///
    /// - Note: This method is **internal to UnsafeTree**.
    /// - Parameter result: The array to accumulate traversal results.
    private func _bfs(result: inout [Element]) {
        guard let root else { return }
        
        typealias TreeNode = TreeNodePointer<Element>
        var dequeue = [TreeNode]()
        dequeue.append(root)
        
        while !dequeue.isEmpty {
            let node = dequeue.removeFirst()
            
            result.append(node.pointee.data)
            
            if let leftNode = node.pointee.left {
                dequeue.append(leftNode)
            }
            if let rightNode = node.pointee.right {
                dequeue.append(rightNode)
            }
        }
    }
}

extension UnsafeTree: ExpressibleByArrayLiteral {
    /// Creates a tree containing the elements of the given array literal.
    public convenience init(arrayLiteral elements: Element...) {
        self.init()
        insert(data: elements)
    }
}

extension UnsafeTree: ExpressibleByNilLiteral {
    /// Creates an empty tree from the nil literal.
    public convenience init(nilLiteral: ()) {
        self.init()
    }
}

/// Defines traversal orders for `UnsafeTree`.
public enum TraversalOrder: Sendable, CaseIterable {
    /// Pre-order traversal: root → left → right
    case pre
    /// In-order traversal: left → root → right
    case `in`
    /// Post-order traversal: left → right → root
    case post
    /// Breadth-first traversal (level order)
    case bfs
}
