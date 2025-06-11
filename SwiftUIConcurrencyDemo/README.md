# SwiftUIConcurrencyDemo

A modern SwiftUI demo project showcasing Swift Concurrency (`async/await`) with MVVM architecture, offline caching, image loading, and smooth UI updates.

## Features

- Swift Concurrency (`async/await`, `Task`, cancellation)
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
