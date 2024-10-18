//
//  FollowUnfollowFunc.swift
//  Socialize
//
//  Created by Kartik Sharma on 13/10/24.
//

import Foundation
import Firebase
import FirebaseAuth
class FollowService {
    
    static func follow(user: user, completion: @escaping (Bool) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        // Update current user following list
        let followingRef = Firestore.firestore().collection("users").document(currentUserId).collection("following")
        followingRef.document(user.id).setData([:]) { error in
            if let error = error {
                print("Error following user: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Update followed user's followers list
            let followersRef = Firestore.firestore().collection("users").document(user.id).collection("followers")
            followersRef.document(currentUserId).setData([:]) { error in
                if let error = error {
                    print("Error updating followers: \(error.localizedDescription)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
    
    static func unfollow(user: user, completion: @escaping (Bool) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        // Remove user from current user's following list
        let followingRef = Firestore.firestore().collection("users").document(currentUserId).collection("following")
        followingRef.document(user.id).delete { error in
            if let error = error {
                print("Error unfollowing user: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Remove current user from followed user's followers list
            let followersRef = Firestore.firestore().collection("users").document(user.id).collection("followers")
            followersRef.document(currentUserId).delete { error in
                if let error = error {
                    print("Error removing follower: \(error.localizedDescription)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
}
