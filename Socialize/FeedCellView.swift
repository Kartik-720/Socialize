//
//  FeedCellView.swift
//  Socialize
//
//  Created by Kartik Sharma on 21/08/24.
//
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct FeedCellView: View {
    let post: Post
    @State private var likes: Int = 0
    @State private var isLiked: Bool = false
    @State private var comments: [Comment] = [] // Assuming you have a Comment model
    @State private var newComment: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Profile image and username
            HStack {
                if let user = post.User, let profileImageUrl = user.profileImageurl, let url = URL(string: profileImageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 40, height: 40)
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        case .failure:
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    Text(user.username)
                        .font(.footnote)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            // Post image
            if let imageUrl = URL(string: post.ImageURL) {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 350)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 350)
                            .cornerRadius(12)
                            .shadow(radius: 8)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 350)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .transition(.scale)
            }
            
            // Like, comment, and share buttons
            HStack(spacing: 20) {
                Button(action: toggleLike) {
                    HStack(spacing: 8) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .imageScale(.large)
                            .foregroundColor(isLiked ? .red : .black)
                        Text("\(likes)")
                            .font(.footnote)
                            .fontWeight(.medium)
                    }
                }
                
                Button(action: {}) {
                    HStack(spacing: 8) {
                        Image(systemName: "bubble.right")
                            .imageScale(.large)
                            .foregroundColor(.black)
                        Text("\(comments.count)")
                            .font(.footnote)
                            .fontWeight(.medium)
                    }
                }
                
                Button(action: {}) {
                    HStack(spacing: 8) {
                        Image(systemName: "paperplane")
                            .imageScale(.large)
                            .foregroundColor(.black)
                        Text("Share")
                            .font(.footnote)
                            .fontWeight(.medium)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            
            // Post caption
            HStack {
                Text(post.User?.username ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                +
                Text(" \(post.caption ?? "")")
                    .font(.subheadline)
            }
            .padding(.horizontal)
            
            // Comments section
            VStack(alignment: .leading, spacing: 8) {
                // ForEach(comments) { comment in
                //     HStack {
                //         Text(comment.username).fontWeight(.bold)
                //         Text(comment.content)
                //     }
                // }
                TextField("Add a comment...", text: $newComment, onCommit: addComment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 6)
        .padding()
        .onAppear {
            fetchLikes()
            fetchComments()
        }
    }
    
    // Toggle like/unlike functionality
    private func toggleLike() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let likesRef = Firestore.firestore().collection("posts").document(post.id).collection("likes").document(userID)
        
        if isLiked {
            likesRef.delete { error in
                if let error = error {
                    print("Error removing like: \(error.localizedDescription)")
                } else {
                    isLiked = false
                    likes -= 1
                }
            }
        } else {
            likesRef.setData([:]) { error in
                if let error = error {
                    print("Error adding like: \(error.localizedDescription)")
                } else {
                    isLiked = true
                    likes += 1
                }
            }
        }
    }
    
    // Fetch likes count and check if the user has already liked the post
    private func fetchLikes() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let likesRef = Firestore.firestore().collection("posts").document(post.id).collection("likes")
        
        likesRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching likes: \(error.localizedDescription)")
            } else {
                likes = snapshot?.documents.count ?? 0
                isLiked = snapshot?.documents.contains(where: { $0.documentID == userID }) ?? false
            }
        }
    }
    
    // Fetch comments for the post
    private func fetchComments() {
        let commentsRef = Firestore.firestore().collection("posts").document(post.id).collection("comments")
        
        commentsRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching comments: \(error.localizedDescription)")
            } else {
                comments = snapshot?.documents.compactMap { document in
                    try? document.data(as: Comment.self)
                } ?? []
            }
        }
    }
    
    // Add a new comment to the post
    private func addComment() {
        guard !newComment.isEmpty, let userID = Auth.auth().currentUser?.uid else { return }
        let commentsRef = Firestore.firestore().collection("posts").document(post.id).collection("comments").document()
        
        let commentData: [String: Any] = [
            "id": commentsRef.documentID,
            "content": newComment,
            "userID": userID,
            "timestamp": Timestamp()
        ]
        
        commentsRef.setData(commentData) { error in
            if let error = error {
                print("Error adding comment: \(error.localizedDescription)")
            } else {
                newComment = ""
                fetchComments() // Refresh comments
            }
        }
    }
}

#Preview {
    FeedCellView(post: Post.MOCK_POST[0])
}
