//
//  CompleteSignupView.swift
//  Socialize
//
//  Created by Kartik Sharma on 24/08/24.
//

import SwiftUI

struct CompleteSignupView: View {
    @State private var username = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Spacer()
            Text("Welcome to instagram")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("Click below to complete registration and start using instagram")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .fontWeight(.light)
                .foregroundStyle(Color(.gray))
            NavigationLink {
                FeedView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Complete Sign Up")
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
    CompleteSignupView()
}
