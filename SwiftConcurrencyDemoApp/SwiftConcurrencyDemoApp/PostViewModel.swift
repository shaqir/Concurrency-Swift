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
    @Published var errorMessage: String?

    private let service = PostService()
    
    func loadPosts() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await service.fetchPosts()
            posts = result
        } catch {
            errorMessage = "Failed to load posts: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
