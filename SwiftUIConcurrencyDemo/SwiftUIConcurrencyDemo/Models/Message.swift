import Foundation

struct Message: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String

    init(title: String) {
        self.id = UUID()
        self.title = title
    }

    var imageURL: URL {
        URL(string: "https://picsum.photos/200/200?random=\(id.uuidString)")!
    }
}
