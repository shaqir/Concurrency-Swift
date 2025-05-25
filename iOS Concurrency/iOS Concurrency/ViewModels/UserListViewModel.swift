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
    
    func fetchUsers(){
        
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        
        apiService.getJSON{ (result: Result<[User], APIError>) in
            switch result {
            case  .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }
            case .failure(let error):
                print("Error: \(error)")
            }
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
