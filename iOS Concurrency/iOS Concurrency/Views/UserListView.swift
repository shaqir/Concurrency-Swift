//
//  UserListView.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//

import SwiftUI


struct UserListView: View {
    
    @StateObject var vm = UserListViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(vm.usersAndPosts){ userAndPosts in
                    
                    NavigationLink(destination: PostListView(posts: userAndPosts.posts)) {
                        VStack(alignment: .leading)
                        {
                            Text(userAndPosts.user.name).font(.title)
                            Spacer()
                            Text("\(userAndPosts.numberofPosts)")
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .listStyle(.plain)
            .onAppear(){
                Task {
                    await vm.fetchUsers()
                }
            }
        }
    }
}

#Preview {
    UserListView()
}
