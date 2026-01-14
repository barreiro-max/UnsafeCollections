/// Re-exports dependent modules so they become implicitly available
/// to any client importing `UnsafeCollections`.
///
/// `@_exported import` tells the Swift compiler to treat these imports
/// as if they were written in the client module itself.
/// As a result, types and symbols from the modules below can be used
/// without explicitly importing them.
///
/// This attribute is underscored (`@_exported`), which means it is
/// not part of Swift’s official, stable public API.
/// Its behavior is widely relied upon in practice, but it may change
/// or be removed in future Swift versions.
///
/// Use with care and only for intentional module re-exporting.
@_exported import UnsafeList
@_exported import UnsafeTree
@_exported import UnsafeQueue
@_exported import UnsafeStack
@_exported import UnsafeCollectionsCore

