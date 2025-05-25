//
//  PostListViewModel.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//

import Foundation

class PostListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    var userId: Int?
    
    @MainActor
    func fetchPosts() async {
        if let userId = userId {
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            do{
                posts = try await apiService.getJSON()
            }catch{
                print("Error fetching posts: \(error.localizedDescription)")
            }
        }
    }
    
}
extension PostListViewModel {
    
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = Post.mockSingleUserPostArray
        }
    }
    
}
