//
//  CreateUsernameView.swift
//  Socialize
//
//  Created by Kartik Sharma on 24/08/24.
//

import SwiftUI

struct CreateUsernameView: View {
    @State private var username = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Create Username")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("Pick a username for new account.You can always change it later")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .fontWeight(.light)
                .foregroundStyle(Color(.gray))
            TextField("Enter Username",text: $username)
                .autocorrectionDisabled()
                .font(.subheadline)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal,24)
            NavigationLink {
                PasswordView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundStyle(Color.white)
                    .frame(width: 360,height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(12)
                    .padding(.top,9)
            }
            Spacer()
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    CreateUsernameView()
}
