//
//  UserAndPosts.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//

import Foundation

struct UserAndPosts: Identifiable{
    var id = UUID()
    let user: User
    let posts: [Post]
    var numberofPosts: Int{
        posts.count
    }
}
