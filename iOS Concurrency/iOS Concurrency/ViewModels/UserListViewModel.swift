//
//  UserListViewModel.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//

import Foundation
@MainActor
class UserListViewModel: ObservableObject{
    
    @Published var usersAndPosts: [UserAndPosts] = []
    
    @MainActor
    func fetchUsers() async{
        
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        let apiService2 = APIService(urlString: "https://jsonplaceholder.typicode.com/posts")
        do{
            async let users: [User] = try await apiService.getJSON()
            async let posts: [Post] = try await apiService2.getJSON()
            let(fetchedUsers, fetchedPosts) = await (try users, try posts)
            
            for user in fetchedUsers{
                let userPosts  = fetchedPosts.filter { $0.userId == user.id }
                let userAndPostsObj = UserAndPosts(user: user, posts: userPosts)
                usersAndPosts.append(userAndPostsObj)
            }
        }catch{
            print("Error fetching users: \(error.localizedDescription)")
        }
    
    }
}

extension UserListViewModel {
    
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.usersAndPosts = UserAndPosts.mockUserAndPosts
        }
    }
    
}
