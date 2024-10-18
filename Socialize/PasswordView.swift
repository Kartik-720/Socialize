//
//  PasswordView.swift
//  Socialize
//
//  Created by Kartik Sharma on 24/08/24.
//

import SwiftUI

struct PasswordView: View {
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Create a password")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("Your password should be atleast 6 characters in length")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .fontWeight(.light)
                .foregroundStyle(Color(.gray))
            TextField("Enter Password",text: $password)
                .autocorrectionDisabled()
                .font(.subheadline)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal,24)
            NavigationLink {
                CompleteSignupView()
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
    PasswordView()
}
