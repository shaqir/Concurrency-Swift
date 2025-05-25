//
//  User.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//
//Source https://jsonplaceholder.typicode.com/users

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}

