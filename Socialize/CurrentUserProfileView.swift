//
//  CurrentUserProfileView.swift
//  Socialize
//
//  Created by Kartik Sharma on 25/08/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CurrentUserProfileView: View {
    @State private var showEditProfileView = false
    @State private var followersCount = 0
    @State private var followingCount = 0
    @State private var posts: [Post] = [] // Store fetched posts from Firestore
    
    private let grid: [GridItem] = [
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2)
    ]
    
    let user: user
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        CircularProfileImageView(User: user)
                        if let bio = user.bio {
                            Text(bio)
                                .font(.subheadline)
                                .fontDesign(.rounded)
                        }
                    }
                    Spacer()
                    UserStatsView(value: posts.count, title: "Posts")
                    Spacer()
                    UserStatsView(value: followersCount, title: "Followers")
                    Spacer()
                    UserStatsView(value: followingCount, title: "Following")
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                HStack {
                    Button {
                        showEditProfileView.toggle()
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 150, height: 32)
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
                    }
                    
                    Button {
                        // Share Profile Action
                    } label: {
                        Text("Share Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 150, height: 32)
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
                    }
                }
                .padding(.vertical)
                
                Divider()
                
                LazyVGrid(columns: grid, spacing: 2) {
                    ForEach(posts) { post in
                        AsyncImage(url: URL(string: post.ImageURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: imageDimension, height: imageDimension)
                                .clipped()
                        } placeholder: {
                            Color.gray // Placeholder while image loads
                        }
                    }
                }
            }
            .navigationTitle("\(user.username)")
            .navigationBarTitleDisplayMode(.automatic)
            .fullScreenCover(isPresented: $showEditProfileView) {
                EditProfileView(user: user)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
            .onAppear {
                fetchFollowersCount()
                fetchFollowingCount()
                fetchUserPosts() // Fetch posts on appear
            }
        }
    }
    
    // Fetch the number of followers
    private func fetchFollowersCount() {
        let followersRef = Firestore.firestore().collection("users").document(user.id).collection("followers")
        
        followersRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching followers count: \(error.localizedDescription)")
                return
            }
            
            followersCount = snapshot?.documents.count ?? 0
        }
    }
    
    // Fetch the number of people the user is following
    private func fetchFollowingCount() {
        let followingRef = Firestore.firestore().collection("users").document(user.id).collection("following")
        
        followingRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching following count: \(error.localizedDescription)")
                return
            }
            
            followingCount = snapshot?.documents.count ?? 0
        }
    }
    
    // Fetch the current user's posts from Firestore
    private func fetchUserPosts() {
        let postsRef = Firestore.firestore().collection("posts").whereField("OwnerId", isEqualTo: user.id)
        
        postsRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching posts: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self) })
        }
    }
}

#Preview {
    CurrentUserProfileView(user: user.MOCK_USER[0])
}

