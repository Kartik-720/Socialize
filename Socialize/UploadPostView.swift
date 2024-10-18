//
//  UploadPostView.swift
//  Socialize
//
//  Created by Kartik Sharma on 25/08/24.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var caption = ""
    @State private var isImagePresented = false
    @State private var isUploading = false // To track upload status
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    @StateObject private var viewModel = UploadPostViewModel()
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack {
            // Top Bar with Cancel and Upload
            HStack {
                Button {
                    clearPostDataAndReturnToFeed()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                Spacer()
                Text("New Post")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    Task {
                        await handleUpload()
                    }
                } label: {
                    Text("Upload")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(isUploading || viewModel.postImage == nil ? Color.gray : Color.blue)
                        .cornerRadius(8)
                }
                .disabled(viewModel.postImage == nil || isUploading)
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Image Preview
            VStack {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 20)
                } else {
                    // Placeholder to prompt image upload
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 350, height: 350)
                        .overlay(
                            Text("Tap to select an image")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        )
                }
            }
            .onTapGesture {
                isImagePresented.toggle() // Trigger image picker
            }
            
            // Caption Field
            TextField("Write a caption...", text: $caption, axis: .vertical)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5))
                )
                .padding(.horizontal)
                .padding(.top, 10)
            
            Spacer()
        }
        .onAppear {
            isImagePresented.toggle() // Open image picker on view appear
        }
        .photosPicker(isPresented: $isImagePresented, selection: $viewModel.selectedImage)
        .alert("Error", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    // Function to handle image upload
    func handleUpload() async {
        guard !caption.isEmpty else {
            errorMessage = "Please enter a caption."
            showErrorAlert = true
            return
        }
        
        isUploading = true
        do {
            try await viewModel.uploadImage(caption: caption)
            clearPostDataAndReturnToFeed()
        } catch {
            errorMessage = "Failed to upload post: \(error.localizedDescription)"
            showErrorAlert = true
        }
        isUploading = false
    }
    
    // Function to reset post data and return to feed
    func clearPostDataAndReturnToFeed() {
        caption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
