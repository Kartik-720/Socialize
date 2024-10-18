//
//  FeedCellView.swift
//  Socialize
//
//  Created by Kartik Sharma on 21/08/24.
//

import SwiftUI

struct FeedCellView: View {
    let post:Post
    var body: some View {
        VStack{
            HStack(){
                if let user = post.User{
                    Image(user.profileImageurl ?? "")
                        .resizable()
                        .frame(width: 40,height: 40)
                        .clipShape(Circle())
                    Text(user.username)
                        .font(.footnote)
                        .fontDesign(.rounded)
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            // Image
            Image(post.ImageURL)
                .resizable()
                .frame(width:.infinity,height: 350)
                .scaledToFit()
            
            HStack(spacing:14){
                Button{}label:{
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .foregroundColor(.black)
                    Text("\(post.likes) likes")
                        .foregroundColor(.black)
                }
                Button{}label:{
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                        .foregroundColor(.black)
                    Text("12")
                        .foregroundColor(.black)
                }
                Button{}label:{
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                        .foregroundColor(.black)
                    Text("12")
                        .foregroundColor(.black)
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            
            HStack(){
                Text("\(post.User?.username  ?? "")").font(.subheadline).fontWeight(.semibold) +
                Text( post.caption ?? "")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            .padding(.top,4)
        }
    }
}

#Preview {
    FeedCellView(post: Post.MOCK_POST[0])
}
