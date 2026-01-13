# UnsafeCollections

UnsafeCollections is a learning-oriented library that provides **unsafe data structures** to help understand **how memory management works under the hood**.

The project is intentionally unsafe. Its goal is **education**, not production use.

---

## 🚨 Disclaimer

This library uses **unsafe memory operations**.

* ❌ Not production-ready
* ❌ No safety guarantees
* ❌ Easy to crash or leak memory

**Use only for learning, experiments, and exploration.**

---

## 🎯 Goals of the Project

* Understand **manual memory management**
* Learn how **pointers and raw memory** behave
* See what Swift normally protects you from
* Explore performance and layout trade-offs

---

## 📦 What’s Inside

* UnsafeQueue
* UnsafeStack
* UnsafeList (Doubly Circular Linked List)
* UnsafeTree (Binary Search Tree)

Each data structure:

* Uses raw pointers
* Manages memory manually
* Avoids Swift safety abstractions on purpose

---

## 🧠 What You’ll Learn

* Allocation and deallocation
* Ownership and lifetime issues
* Dangling pointers
* Double free / memory leaks
* Why ARC and safety checks exist

---

🛠 Installation

1. Open your project in Xcode.

2. Go to File → Add Packages… and paste this URL:

```
https://github.com/BarreiroFontelaMax/UnsafeCollections.git
```

Click Next.

3. Pick Branch: main or a specific version tag, then click Next again.

4. Choose the target(s) to attach the package to and click Add Package.

5. Check Project Navigator → Swift Packages → Package Dependencies to confirm it’s there.

Now you can import it in your code

---

### Imports

You can import the whole package:

```swift
import UnsafeCollections
```

Or import individual modules if you only need specific data structures:

```swift
import UnsafeQueue
import UnsafeStack
import UnsafeList
import UnsafeTree
```

## ✍️ Usage Example

```swift
import UnsafeQueue

let queue = UnsafeQueue<Int>()
queue.enqueue(1)
queue.enqueue(2)

let value = queue.dequeue()
```

⚠️ No safety checks are performed.

---

## 🧪 Testing

The project uses **Swift Testing**.

Each test:

* Initializes its own data structures
* Avoids shared state
* Focuses on memory correctness

---

## 📚 Who This Is For

* Students learning systems programming
* Developers curious about memory internals
* People who want to understand what "unsafe" really means

---

## 📄 License

MIT License

See `LICENSE.txt` for details.

---

## 🤝 Contributing

Contributions are welcome **for educational purposes**.

Please:

* Keep code unsafe by design
* Add comments explaining memory behavior
* Avoid hiding problems behind safety wrappers

