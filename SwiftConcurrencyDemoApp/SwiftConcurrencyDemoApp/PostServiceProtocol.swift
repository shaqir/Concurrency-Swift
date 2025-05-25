//
//  PostServiceProtocol.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Sakir Saiyed on 24/05/25.
//

import Foundation

protocol PostServiceProtocol {
    func fetchPosts() async throws -> [Post]
}

