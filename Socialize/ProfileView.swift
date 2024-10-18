//
//  ProfileView.swift
//  Socialize
//
//  Created by Kartik Sharma on 17/08/24.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    func fetchPosts(for user: user) {
        let postsRef = Firestore.firestore().collection("posts")
        
        postsRef.whereField("OwnerId", isEqualTo: user.id)
            .order(by: "timeStamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching posts: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                self.posts = documents.compactMap { try? $0.data(as: Post.self) }
            }
    }
}
struct ProfileView: View {
    let user: user
    @ObservedObject private var viewModel = ProfileViewModel()
    @State private var isFollowing = false
    @State private var followerCount = 0
    @State private var followingCount = 0
    private let grid: [GridItem] = [
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        ScrollView {
            HStack {
                CircularProfileImageView(User: user)
                Spacer()
                UserStatsView(value: viewModel.posts.count, title: "Posts")  // Use fetched posts
                Spacer()
                UserStatsView(value: followerCount, title: "Followers")
                Spacer()
                UserStatsView(value: followingCount, title: "Following")
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            if let bio = user.bio {
                Text(bio)
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 8)
            }
            
            HStack {
                Button {
                    if isFollowing {
                        FollowService.unfollow(user: user) { success in
                            if success {
                                isFollowing = false
                                fetchFollowerCount() // Update follower count after unfollowing
                            }
                        }
                    } else {
                        FollowService.follow(user: user) { success in
                            if success {
                                isFollowing = true
                                fetchFollowerCount() // Update follower count after following
                            }
                        }
                    }
                } label: {
                    Text(isFollowing ? "Unfollow" : "Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 150, height: 32)
                        .background(isFollowing ? .white : Color(.systemBlue))
                        .foregroundColor(isFollowing ? .black : .white)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(isFollowing ? .gray : .clear, lineWidth: 1))
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
                ForEach(viewModel.posts) { post in
                    AsyncImage(url: URL(string: post.ImageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageDimension, height: imageDimension)
                            .clipped()
                    }
                placeholder: {
                        Color.gray // Placeholder while loading image
                    }
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.automatic)
        .onAppear {
            viewModel.fetchPosts(for: user)  // Fetch posts for the current user
            checkIfFollowing()
            fetchFollowerCount()
            fetchFollowingCount()
        }
    }
    
    private func checkIfFollowing() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let followersRef = Firestore.firestore().collection("users").document(user.id).collection("followers")
        followersRef.document(currentUserId).getDocument { snapshot, error in
            if let error = error {
                print("Error checking if following: \(error.localizedDescription)")
                return
            }
            
            isFollowing = snapshot?.exists ?? false
        }
    }
    
    private func fetchFollowerCount() {
        let followersRef = Firestore.firestore().collection("users").document(user.id).collection("followers")
        followersRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching followers: \(error.localizedDescription)")
                return
            }
            followerCount = snapshot?.documents.count ?? 0
        }
    }
    
    private func fetchFollowingCount() {
        let followingRef = Firestore.firestore().collection("users").document(user.id).collection("following")
        followingRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching following: \(error.localizedDescription)")
                return
            }
            followingCount = snapshot?.documents.count ?? 0
        }
    }
}


#Preview {
    ProfileView(user: user.MOCK_USER[0])
}
