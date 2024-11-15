//
//  ImageUploader.swift
//  Socialize
//
//  Created by Kartik Sharma on 12/09/24.
//

import Foundation
import Firebase
import FirebaseStorage

struct ImageUploader{
    static func uploadImage(image:UIImage)async throws -> String?{
        guard let imageData = image.jpegData(compressionQuality: 0.5)else{return nil}
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images \(filename)")
        do{
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        }catch{
            print("DEBUG: failed to upload image")
            return nil
        }
    }
}
