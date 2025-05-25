//
//  Post.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Sakir Saiyed on 24/05/25.
//
import Foundation

//Represents a single post fetched from the API.
struct Post: Identifiable, Decodable {
    let id: Int
    let title: String
    let body: String
}
