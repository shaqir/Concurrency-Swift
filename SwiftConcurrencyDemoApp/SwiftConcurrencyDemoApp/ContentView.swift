//
//  ContentView.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Sakir Saiyed on 24/05/25.
//
import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PostViewModel(service: PostService())

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Async Posts")
        }
        .task {
            await viewModel.loadPosts()
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let errorMessage = viewModel.error {
            VStack {
                Text(errorMessage).foregroundColor(.red)
                Button("Retry") {
                    Task { await viewModel.loadPosts() }
                }
            }
        } else {
            List(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title).font(.headline)
                    Text(post.body).font(.subheadline)
                }
            }
        }
    }
}
