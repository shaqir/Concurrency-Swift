//
//  UserListViewModel.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//

import Foundation
@MainActor
class UserListViewModel: ObservableObject{
    @Published var users: [User] = []
    
    @MainActor
    func fetchUsers() async{
        
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        
        do{
            users = try await apiService.getJSON()
        }catch{
            print("Error fetching users: \(error.localizedDescription)")
        }
    
    }
}

extension UserListViewModel {
    
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = User.mockUsers
        }
    }
    
}
