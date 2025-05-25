# Swift Concurrency Demo App

Absolutely! Here's a **complete breakdown** of the Swift Concurrency example with **detailed explanations for each class and concept**, followed by a professional, easy-to-read `README.md` file tailored for the demo.

---

## 🔍 **Explanation of Each Class & Concept**

---

### 1. **`Post` (Model)**

```swift
struct Post: Identifiable, Decodable {
    let id: Int
    let title: String
    let body: String
}
```

* **Purpose**: Represents a single post fetched from the API.
* **`Identifiable`**: Makes it usable in SwiftUI `List`.
* **`Decodable`**: Allows it to be constructed from JSON using `JSONDecoder`.

---

### 2. **`PostService` (Networking Layer)**

```swift
class PostService: PostServiceProtocol {
   
    func fetchPosts() async throws -> [Post] {
            let config = URLSessionConfiguration.default
            config.waitsForConnectivity = true
            config.timeoutIntervalForRequest = 15
            let session = URLSession(configuration: config)

            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

            let (data, _) = try await session.data(for: request)
            return try JSONDecoder().decode([Post].self, from: data)
        }
}
```

* **Purpose**: Handles the API request and decoding.
* **`async throws`**: The function is asynchronous and can throw an error.
* **`await`**: Suspends execution until the async call returns.
* **`URLSession.shared.data(from:)`**: Asynchronously fetches data from the internet.
* **Error Handling**: If the fetch or decoding fails, the error bubbles up to be caught later.

---

### 3. **`PostViewModel` (ViewModel Layer)**

```swift
@MainActor
class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var error: String?

    private let service: PostServiceProtocol

    init(service: PostServiceProtocol = PostService()) {
        self.service = service
    }

    func loadPosts() async {
        isLoading = true
        error = nil
        do {
            posts = try await self.service.fetchPosts()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
```

* **Purpose**: Acts as the glue between the service and the SwiftUI view.
* **`@MainActor`**: Ensures all UI updates happen on the main thread.
* **`@Published`**: Automatically notifies the SwiftUI view when values change.
* **`ObservableObject`**: Lets SwiftUI observe the state and re-render views on changes.
* **`loadPosts()`**: Main async function that calls the service and updates UI state safely.

---

### 4. **`ContentView` (SwiftUI View)**

```swift
struct ContentView: View {
    @StateObject private var viewModel = PostViewModel(service: PostService())

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Async Posts")
        }
        .task {
            await viewModel.loadPosts()
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let errorMessage = viewModel.error {
            VStack {
                Text(errorMessage).foregroundColor(.red)
                Button("Retry") {
                    Task { await viewModel.loadPosts() }
                }
            }
        } else {
            List(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title).font(.headline)
                    Text(post.body).font(.subheadline)
                }
            }
        }
    }
}
```

* **Purpose**: Displays the UI based on ViewModel state.
* **`@StateObject`**: Creates and observes a single instance of the ViewModel.
* **`NavigationView` + `List`**: Structured UI for displaying the list of posts.
* **`.task {}`**: A SwiftUI modifier to run async code when the view appears.

---

## 📘 README.md for the Project

```markdown
# 📱 SwiftUI Concurrency Demo - Fetching Posts Asynchronously

This project demonstrates how to use **Swift Concurrency** (`async/await`) in **SwiftUI** to fetch and display data from a REST API.

---

## 🚀 Features

- ✅ Uses `async/await` for asynchronous networking
- ✅ Loads and decodes JSON from `jsonplaceholder.typicode.com`
- ✅ Updates the UI with SwiftUI and MVVM architecture
- ✅ Includes error handling and loading state
- ✅ All updates happen on the main thread safely using `@MainActor`

---

## 🧠 Technologies

- **SwiftUI**
- **Swift Concurrency (`async/await`)**
- **MVVM (Model-View-ViewModel)**
- **URLSession**
- **JSON Decoding**

---

📦 SwiftConcurrencyDemo  
┣ 📄 ContentView.swift        – SwiftUI View  
┣ 📄 Post.swift               – Data Model (Decodable)  
┣ 📄 PostService.swift        – Networking Layer (Async)  
┗ 📄 PostViewModel.swift      – ObservableObject (ViewModel)  


---

## 🧵 How Concurrency is Used

- `PostService.fetchPosts()` uses `await` to fetch data using `URLSession`.
- The ViewModel calls `fetchPosts()` in an `async` context and publishes state.
- SwiftUI’s `.task {}` modifier triggers loading as soon as the view appears.

---

## 🧪 Run the Project

1. Open **Xcode** → New SwiftUI Project.
2. Copy the files or paste the code into the appropriate files.
3. Run in **iOS Simulator**.

---

## 🧠 Concepts Covered

- `@MainActor` → Ensures ViewModel updates are thread-safe.
- `async/await` → Clean handling of background operations.
- `@Published` and `ObservableObject` → Live UI updates.
- `.task {}` → Async code trigger in SwiftUI.

---

## 🌐 API Source

- [https://jsonplaceholder.typicode.com/posts](https://jsonplaceholder.typicode.com/posts)

---

## 📌 Requirements

- Xcode 13+
- iOS 15+
- Swift 5.5+

---

## 📸 Demo

Displays a list of blog post titles and body text from a placeholder API.

---
