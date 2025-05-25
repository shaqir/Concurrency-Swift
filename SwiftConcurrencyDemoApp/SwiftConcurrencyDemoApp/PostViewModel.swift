//
//  PostViewModel.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Sakir Saiyed on 24/05/25.
//

import Foundation

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
