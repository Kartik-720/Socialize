//
//  AuthService.swift
//  Socialize
//
//  Created by Kartik Sharma on 27/08/24.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
class AuthService{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser:user?
    static let shared = AuthService()
    init(userSession: FirebaseAuth.User? = nil) {
        Task{try await loadData()}
    }
    @MainActor
    func login(withemail email:String,password:String)async throws{
        do{
            let result = try await Auth.auth().signIn (withEmail: email, password: password)
            self.userSession=result.user
            try await loadData()
        }
        catch{
            print("DEBUG: Failed to login user \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withemail email:String,password:String,username:String)async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession=result.user
            await uploadData(uid: result.user.uid,username: username,email: email)
            print("DEBUG:Did upload users data")
        }
        catch{
            print("DEBUG: Failed to create user \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadData()async throws{
        self.userSession = userSession
        guard let currentuid = userSession?.uid else{return}
        let snapshot = try await Firestore.firestore().collection("users").document(currentuid).getDocument()
        self.currentUser = try? snapshot.data(as: user.self)
    }
    func signOut(){
        try? Auth.auth().signOut()
        self.userSession=nil
        self.currentUser=nil
    }
    private func uploadData(uid:String,username:String,email:String) async{
        let user=user(id:uid,username:username,email:email)
        self.currentUser=user
        guard let encodedUser=try? Firestore.Encoder().encode(user) else {return}
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
