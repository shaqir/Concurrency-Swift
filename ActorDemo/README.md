# Why actor is the right choice for the Rate Limiter

## What does our rate limiter need to do?

- Track shared mutable state → requestTimestamps
- Ensure thread-safe access to this state when called from multiple async tasks
- Avoid data races when called from SwiftUI or other Task {} blocks

## Example Problem Without Actor:

If you used a class or struct like this:

    class RateLimiter {
        var requestTimestamps: [Date] = []
    
        func allowRequest() -> Bool {
            // Mutating shared state...
        }
    }

And then called await or .async tasks like:

       Task {
          await rateLimiter.allowRequest()
      }


## This would be unsafe:

-> Multiple async tasks could access and mutate the array at the same time

-> Leading to data races, crashes, or incorrect behavior.

✅ actor Fixes This Elegantly

- Serialized access to its methods and properties.
- Swift automatically ensures no two tasks access mutable state at once.
- Cleaner code: no need for DispatchQueue, NSLock, or manual synchronization.

~ **Structs** are immutable — not useful for this.
~ **Classes** are not thread-safe — risky.

**Actors** are the best fit: they give you shared mutable state with safe, isolated access in concurrent environments.

## Use actor when:
 
- You need to protect shared mutable state across async contexts.
- You want safety without manual locks.
- You want to future-proof your code for structured concurrency.



