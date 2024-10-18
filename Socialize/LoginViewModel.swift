//
//  LoginViewModel.swift
//  Socialize
//
//  Created by Kartik Sharma on 07/09/24.
//

import Foundation

class LoginViewModel:ObservableObject{
    @Published var email=""
    @Published var password=""
    
    func login()async throws{
        try await AuthService.shared.login(withemail: email, password: password)
    }
}
