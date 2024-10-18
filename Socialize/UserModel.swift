//
//  UserModel.swift
//  Socialize
//
//  Created by Kartik Sharma on 24/08/24.
//

import Foundation
import Firebase
import FirebaseAuth

struct user:Identifiable,Hashable, Codable{
    let id: String
    var username:String
    var profileImageurl:String?
    var fullname:String?
    var bio:String?
    let email:String
    
    var isCurrentUser:Bool{
        guard let currentuid = Auth.auth().currentUser?.uid else {return false}
        return currentuid == id
    }
}

extension user{
    static var MOCK_USER:[user] = [
        .init(id: UUID().uuidString, username: "Banana", profileImageurl: nil, fullname: "Fruit Banana", bio: "I am a Banana", email: "banana@gmail.com")
    ]
}
