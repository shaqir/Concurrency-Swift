# SwiftUIConcurrencyDemo

A modern SwiftUI demo project showcasing Swift Concurrency (`async/await`) with MVVM architecture, offline caching, image loading, and smooth UI updates, it also used combine framework (light) with some operatos.

## Features

- Swift Concurrency (`async/await`, `Task`, cancellation)
- Combine Framework 
- MVVM architecture
- Networking using `URLSession`
- Offline caching with `FileManager`
- Async image loading (`AsyncImage`)
- Retry + Cancel support
- Animated list updates
- SwiftUI Previews

## How It Works

- Loads cached messages at launch
- Fetches new messages from API on button tap
- Saves messages to disk for offline use
- Displays image thumbnails using placeholder service
- Allows retrying failed requests or canceling ongoing fetches

## Requirements

- Xcode 14 or later
- iOS 15+

# a visual flow chart showing both the Swift Concurrency and Combine pipelines in this demo app, side by side:

<img width="404" alt="BothPath" src="https://github.com/user-attachments/assets/15aa7b50-4866-4ff4-afbe-6c57cba7a819" />

