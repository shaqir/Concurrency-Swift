# Concurrency-Swift

**Swift Concurrency topics**:

1. `async` / `await`
2. `Task`
3. `async let`
4. `TaskGroup` / `ThrowingTaskGroup`
5. `actor`
6. `@MainActor`
7. `nonisolated`
8. Global actors
9. `withCheckedContinuation` / `withUnsafeContinuation`
10. `Task.detached`
11. Task cancellation
12. Sendable and `@Sendable`
13. Reentrancy
14. Structured concurrency
15. Unstructured concurrency
16. MainActor.run
17. SwiftUI + Concurrency (`.task`, `.refreshable`, etc.)
18. Testing async code
19. Concurrency debugging tools
20. Distributed actors (advanced)
21. Back deployment support for concurrency


**Swift Concurrency topics**

---

### 1. **Structured Concurrency**

* `async` / `await`
* `Task {}` and `Task priorities`
* Task trees & child tasks
* `await` keyword and suspending functions

### 2. **Tasks**

* Creating and cancelling `Task`
* `Task.sleep` / `Task.checkCancellation()`
* `Task.cancel()` and cooperative cancellation
* `Task.detached` vs `Task.init`

---

## **Actors and Isolation**

### 3. **Actors**

* What is an `actor`?
* Why use actors (data isolation, safety)
* Accessing actor properties & methods (`await`)
* Actor reentrancy
* `nonisolated` and `@MainActor`
* Actor inheritance (or lack thereof)

---

##  **Concurrency Primitives**

### 4. **Async Let**

* Concurrent bindings inside a single scope
* `async let result = ...`
* Structured concurrency with `async let`

### 5. **TaskGroup / ThrowingTaskGroup**

* Parallelism within a structured scope
* `TaskGroup { group in ... }`
* Handling errors with `ThrowingTaskGroup`

### 6. **Continuation**

* `withCheckedContinuation` and `withUnsafeContinuation`
* Bridging callback-based code to `async`/`await`
* Avoiding retain cycles and misuse

---

## **Concurrency in Real Projects**

### 7. **MainActor**

* UI updates on the main thread
* Annotating classes, properties, and functions with `@MainActor`
* `MainActor.run {}` usage

### 8. **Global Actors**

* Custom global actors
* Sharing isolation across modules or features


##  **Concurrency in SwiftUI**

### 9. **SwiftUI + Concurrency**

* `@MainActor` in ViewModels
* Async bindings with `.task`, `.refreshable`, `.onAppear`
* Using `ObservableObject` with async code
* `@Published` updates from background threads → using `MainActor.run`

---

##  **Concurrency Pitfalls & Best Practices**

### 10. **Race Conditions**

* Why actors solve data races
* Misusing `Task.detached` or global shared data

### 11. **Reentrancy**

* What it means
* How an actor can be re-entered during `await` pauses

### 12. **Cancellation**

* Propagation and cooperative cancellation
* When not to ignore `Task.isCancelled`

---

##  **Testing & Debugging Concurrency**

### 13. **Testing async code**

* `XCTest` with async functions
* `await` in tests, `expectation` vs. modern patterns

### 14. **Concurrency Debugging Tools**

* Thread sanitizer
* Swift Concurrency warnings in Xcode
* Logging with `os_signpost` or `print`

---

## Bonus Topics

### 15. **Sendable and @Sendable**

* Value types vs reference types in concurrent code
* Marking closures as `@Sendable`
* `Sendable` conformance in custom types

### 16. **Distributed Actors (Advanced)**

* New in Swift 5.7+ / 5.9
* Used for building actor systems that work across processes or networks

### 17. **Back Deployment of Concurrency**

* Swift Concurrency in iOS 13/14 using back-deployment
* Limitations and compiler support

 
