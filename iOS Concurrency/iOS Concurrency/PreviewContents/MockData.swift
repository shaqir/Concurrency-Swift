//
//  MockData.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//

import Foundation

extension User{
    
    static var mockUsers: [User] {
        Bundle.main.decode([User].self, from: "users.json")
    }
    static var mockSingleUser: User {
        self.mockUsers[0]
    }
    
}

extension Post{
    
    static var mockPosts: [Post] {
        Bundle.main.decode([Post].self, from: "posts.json")
    }
    static var mockSingleUser: Post {
        self.mockPosts[0]
    }
    
    static var mockSingleUserPostArray: [Post] {
        self.mockPosts.filter { $0.userId == 1 }
    }
    
}

extension UserAndPosts{
    
    static var mockUserAndPosts: [UserAndPosts] {
        var newUserAndPosts: [UserAndPosts] = []
        for user in User.mockUsers {
            var userAndPosts: UserAndPosts = UserAndPosts(user: user, posts: Post.mockPosts.filter{ $0.userId == user.id })
            newUserAndPosts.append(userAndPosts)
        }
        return newUserAndPosts
    }
}

