//
//  Post.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//
//Source: https://jsonplaceholder.typicode.com/posts
//Single User's post: https://jsonplaceholder.typicode.com/users/1/posts

import Foundation

struct Post: Decodable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
