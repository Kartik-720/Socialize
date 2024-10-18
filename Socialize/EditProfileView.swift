//
//  EditProfileView.swift
//  Socialize
//
//  Created by Kartik Sharma on 10/09/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: user) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            // Top bar
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                Spacer()
                Text("Edit Profile")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    Task {
                        try await viewModel.updateUserData()
                        dismiss()
                    }
                }) {
                    Text("Save")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            
            // Profile Image Picker
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(radius: 5)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                        Text("Select Image")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 30)
            }
            
            // Edit profile fields
            VStack(spacing: 16) {
                EditProfileRowView(title: "Name", placeholder: "New Name", text: $viewModel.fullname)
                EditProfileRowView(title: "Bio", placeholder: "Tell something about you...", text: $viewModel.bio)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
                .frame(width: 100, alignment: .leading)
                .padding(.leading, 8)
            
            VStack {
                TextField(placeholder, text: $text)
                    .padding(.vertical, 4)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 44)
    }
}

#Preview {
    EditProfileView(user: user.MOCK_USER[0])
}
