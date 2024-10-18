//
//  FeedViewModel.swift
//  Socialize
//
//  Created by Kartik Sharma on 14/10/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        fetchFollowingPosts()
    }
    
    // Fetch posts from users that the current user follows
    func fetchFollowingPosts() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = Firestore.firestore().collection("users").document(currentUserId).collection("following")
        
        // Fetch the list of users the current user is following
        followingRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching following list: \(error.localizedDescription)")
                return
            }
            
            let followingIds = snapshot?.documents.compactMap({ $0.documentID }) ?? []
            
            // Fetch posts where the userId is in the followingIds
            let postsRef = Firestore.firestore().collection("posts").whereField("OwnerId", in: followingIds)
            
            postsRef.getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching posts: \(error.localizedDescription)")
                    return
                }
                
                self.posts = snapshot?.documents.compactMap({ try? $0.data(as: Post.self) }) ?? []
            }
        }
    }
}
