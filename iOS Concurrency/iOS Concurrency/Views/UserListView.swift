//
//  UserListView.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//

import SwiftUI


struct UserListView: View {
    
    #warning("Remove preview from mockdata when using actual API.")
    @StateObject var vm = UserListViewModel(forPreview: false)
    
    var body: some View {
        NavigationView{
            List{
                ForEach(vm.users){ user in
                    
                    NavigationLink(destination: PostListView(userId: user.id)) {
                        VStack(alignment: .leading)
                        {
                            Text(user.name).font(.title)
                            Text(user.email)
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
