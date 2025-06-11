
import Foundation
import Combine

class NetworkService {
    
    static let apiURL = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    private static let cacheURL: URL = {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("messages.json")
    }()
    
    // MARK: - Async/await
    static func fetchMessages() async throws -> [Message] {
            let (data, _) = try await URLSession.shared.data(from: apiURL)
            let decoded = try JSONDecoder().decode([MessageDTO].self, from: data)
            let messages = decoded.prefix(5).map { Message(title: $0.title) }
            try? saveToCache(messages)
            return messages
    }
    
    // MARK: - Combine
    static func fetchMessagesPublisher() -> AnyPublisher<[Message], Error> {
        URLSession.shared.dataTaskPublisher(for: apiURL)
            .map(\.data)
            .decode(type: [MessageDTO].self, decoder: JSONDecoder())
            .map{ $0.prefix(5).map{ Message(title: $0.title)}}
            .handleEvents(receiveOutput: { messages in
                            try? saveToCache(messages)
                        })
            .eraseToAnyPublisher()
        
    }
    
    
    static func loadFromCache() -> [Message] {
        guard let data = try? Data(contentsOf: cacheURL) else { return [] }
        return (try? JSONDecoder().decode([Message].self, from: data)) ?? []
    }
    
    private static func saveToCache(_ messages: [Message]) throws {
        let data = try JSONEncoder().encode(messages)
        try data.write(to: cacheURL)
    }
}

private struct MessageDTO: Decodable {
    let title: String
}
