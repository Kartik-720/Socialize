//
//  SearchViewModel.swift
//  Socialize
//
//  Created by Kartik Sharma on 10/09/24.
//

import Foundation

class SearchViewModel:ObservableObject{
    @Published var users=[user]()
    
    init(){
        Task{try await fetchAllUsers()}
    }
    @MainActor 
    func fetchAllUsers()async throws{
        self.users = try await UserService.loadAllData()
        self.filteredUsers = users
    }
        @Published var filteredUsers: [user] = []
        func filterUsers(by query: String) {
            if query.isEmpty {
                filteredUsers = users
            } else {
                filteredUsers = users.filter { $0.username.lowercased().contains(query.lowercased()) }
            }
        }

}
