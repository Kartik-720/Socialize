//
//  AddEmailView.swift
//  Socialize
//
//  Created by Kartik Sharma on 24/08/24.
//

import SwiftUI

struct AddEmailView: View {
    @State private var email = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Add your email")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("This email id will be used for instagram account")
                .font(.footnote)
                .fontWeight(.light)
                .foregroundStyle(Color(.gray)) 
            TextField("Enter you email",text: $email)
                .autocorrectionDisabled()
                .font(.subheadline)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal,24)
            
            NavigationLink {
                CreateUsernameView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundStyle(Color.white)
                    .frame(width: 360,height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(12)
            }
            .padding(.vertical)
            Spacer()
        }
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
    AddEmailView()
}
