//
//  RegistrationViewModel.swift
//  Socialize
//
//  Created by Kartik Sharma on 05/09/24.
//

import Foundation

class RegistrationViewModel:ObservableObject{
    @Published var username=""
    @Published var password=""
    @Published var email=""
    
    @MainActor
    func createUser() async throws{
        try await AuthService.shared.createUser(withemail: email, password: password, username: username)
        email=""
        password=""
        username=""
    }
}
