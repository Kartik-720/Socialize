//
//  UploadPostViewModel.swift
//  Socialize
//
//  Created by Kartik Sharma on 26/08/24.
//

import Foundation
import PhotosUI
import SwiftUI
import FirebaseAuth
import Firebase

class UploadPostViewModel: ObservableObject {
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    // Loads the image from the PhotosPickerItem
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        do {
            // Attempt to load the image data from the item
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                self.uiImage = uiImage
                self.postImage = Image(uiImage: uiImage) // Update the published post image
            }
        } catch {
            print("Error loading image: \(error.localizedDescription)")
        }
    }
    
    // Uploads the image to Firebase Storage and saves the post in Firestore
    func uploadImage(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        guard let uiImage = uiImage else {
            print("No image selected")
            return
        }
        
        // Create a reference for a new post document with an auto-generated ID
        let postRef = Firestore.firestore().collection("posts").document()
        
        do {
            // Upload image to Firebase Storage
            guard let imageURL = try await ImageUploader.uploadImage(image: uiImage) else {
                print("Failed to upload image")
                return
            }
            
            // Create a post object with the document ID
            let post = Post(id: postRef.documentID, OwnerId: uid, likes: 0, ImageURL: imageURL, timeStamp: Timestamp())
            
            // Encode the post and save it in Firestore
            try postRef.setData(from: post) { error in
                if let error = error {
                    print("Error saving post data: \(error.localizedDescription)")
                } else {
                    print("Post uploaded successfully")
                }
            }
        } catch {
            print("Error uploading post: \(error.localizedDescription)")
        }
    }
}
