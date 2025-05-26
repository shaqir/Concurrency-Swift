//
//  PostListView.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//

import SwiftUI

struct PostListView: View {
    
#warning("Its for testing mocking data only, remove this line in real app. ")
    var posts: [Post]
    var body: some View {
        List{
            ForEach(posts){ post in
                VStack(alignment: .leading)
                {
                    Text(post.title).font(.headline)
                    Text(post.body).font(.callout)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
             
        }
    }
}

#Preview {
    NavigationView{
        PostListView(posts: Post.mockSingleUserPostArray)
    }
}
