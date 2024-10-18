//
//  LoginView.swift
//  Socialize
//
//  Created by Kartik Sharma on 24/08/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Replacing Instagram image with "Chi8i" text
                Text("Socialize")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.top, 40) // Adjust top padding for better positioning
                
                // Email and Password fields
                VStack(spacing: 16) {
                    TextField("Enter your email", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .padding(.horizontal, 24)
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .padding(.horizontal, 24)
                }
                
                // Forgot Password Button
                Button {
                    print("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.blue)
                }
                
                // Login Button
                Button {
                    Task { try await viewModel.login() }
                } label: {
                    Text("Login")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 44)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.top, 16)
                
                // OR Divider
                HStack {
                    Rectangle()
                        .frame(width: 120, height: 0.5)
                        .foregroundColor(.gray)
                    
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(width: 120, height: 0.5)
                        .foregroundColor(.gray)
                }
                .padding(.top, 24)
                
                // Apple login option
                HStack(spacing: 10) {
                    Image(systemName: "apple.logo")
                        .foregroundColor(.black)
                    
                    Text("Login with Apple")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .padding(.top, 12)
                
                Spacer()
                
                // Sign Up Link
                Divider()
                
                NavigationLink {
                    AddEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.blue)
                    .font(.subheadline)
                }
                .padding(.bottom, 24)
            }
        }
    }
}

#Preview {
    LoginView()
}
