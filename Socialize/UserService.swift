//
//  UserService.swift
//  Socialize
//
//  Created by Kartik Sharma on 10/09/24.
//

import Foundation
import Firebase

struct UserService {
    static func loadAllData()async throws -> [user]{
        var users=[user]()
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let doc = snapshot.documents
        for doc in doc{
            guard let user = try? doc.data(as: user.self) else{return users}
            users.append(user)
        }
        return users
    }
}
