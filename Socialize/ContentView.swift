//
//  ContentView.swift
//  Socialize
//
//  Created by Kartik Sharma on 12/08/24.
//

import SwiftUI
import FirebaseAuth


struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    var body: some View {
        Group{
            if (viewModel.userSession == nil){
                LoginView()
                    .environmentObject(registrationViewModel)
            }
            else if let currentUser = viewModel.currentUser{
                TabBar(user:currentUser)
            }
        }
    }
}
#Preview {
    ContentView()
}
