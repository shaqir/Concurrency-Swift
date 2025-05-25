//
//  PostService.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Sakir Saiyed on 24/05/25.
//
import Foundation

//Purpose: Handles the API request and decoding.

class PostService: PostServiceProtocol {
   
    func fetchPosts() async throws -> [Post] {
            let config = URLSessionConfiguration.default
            config.waitsForConnectivity = true
            config.timeoutIntervalForRequest = 15
            let session = URLSession(configuration: config)

            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

            let (data, _) = try await session.data(for: request)
            return try JSONDecoder().decode([Post].self, from: data)
        }
}
