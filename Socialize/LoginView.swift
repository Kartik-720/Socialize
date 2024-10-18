//
//  LoginView.swift
//  Socialize
//
//  Created by Kartik Sharma on 24/08/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var passsword = ""
    var body: some View {
        NavigationStack {
            VStack{
                Image("Instagram")
                    .resizable()
                    .frame(width: 300,height: 150)
            }
            
            VStack{
                TextField("Enter you email",text: $email)
                    .autocorrectionDisabled()
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    .padding(.horizontal,24)
                
                SecureField("Enter your password",text: $passsword)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    .padding(.horizontal,24)
            }
            
            Button{
                print("Forgot Password")
            }label: {
                Text("Forgot Password?")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.top,8)
                    .padding(.horizontal,26)
            }
            .frame(maxWidth: .infinity,alignment: .trailing)
            Button{
                print("Login")
            }label: {
                Text("Login")
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundStyle(Color.white)
                    .frame(width: 360,height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(12)
            }
            .padding(.vertical)
            HStack{
                Rectangle()
                    .frame(width: 150,height: 0.5)
                    .foregroundStyle(Color(.systemGray))
                Text("OR")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.gray))
                Rectangle()
                    .frame(width: 150,height: 0.5)
                    .foregroundStyle(Color(.systemGray))
            }
            HStack{
                Image(systemName: "apple.logo")
                Text("Login with apple")
            }
            .padding(.top,9)
            Spacer()
            Divider()
            NavigationLink {
            AddEmailView()
                    .navigationBarBackButtonHidden()
            } label: {
                HStack(spacing:3){
                    Text("Dont't have an account?")
                    
                    Text("Sign up")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(Color(.systemBlue))
                .fontWeight(.medium)
            }
        }
    }
}

#Preview {
    LoginView()
}
