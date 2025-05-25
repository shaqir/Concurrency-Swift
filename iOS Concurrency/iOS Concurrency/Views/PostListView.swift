//
//  PostListView.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//

import SwiftUI

struct PostListView: View {
    
    #warning("Its for testing mocking data only, remove this line in real app. ")
    @StateObject var vm = PostListViewModel(forPreview: true)
    var userId: Int?
    
    var body: some View {
        List{
            ForEach(vm.posts){ post in
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
            .onAppear(){
                Task {
                    vm.userId = userId
                    vm.fetchPosts()
                }
            }
        }
    }
}

#Preview {
    NavigationView{
        PostListView(userId: 1)
    }
}
