//
//  EditProfileViewModel.swift
//  Socialize
//
//  Created by Kartik Sharma on 11/09/24.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase
@MainActor
class EditProfileViewModel:ObservableObject{
    @Published var user:user
    @Published var selectedImage:PhotosPickerItem?{
        didSet{Task{await loadImage(fromItem:selectedImage)}}
    }
    @Published var profileImage:Image?
    @Published var fullname = ""
    @Published var bio = ""
    private var uiimage:UIImage?
    init(user:user){
        self.user=user
        
        if let fullname = user.fullname{
            self.fullname=fullname
        }
        if let bio = user.bio{
            self.bio=bio
        }
    }
    func loadImage(fromItem item:PhotosPickerItem?) async {
        guard let item = item else{return}
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiimage=uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    func updateUserData()async throws{
        var data = [String: Any]()
        
        if let uiimage = uiimage{
            let imageurl = try? await ImageUploader.uploadImage(image: uiimage)
            data["profileImageURL"]=imageurl
        }
        
        if !fullname.isEmpty && user.fullname != fullname{
            data["fullname"]=fullname
        }
        if !bio.isEmpty && user.bio != bio{
            data["bio"]=bio
        }
        if !data.isEmpty{
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
    
}
