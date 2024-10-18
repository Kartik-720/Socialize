//
//  ProfileView.swift
//  Socialize
//
//  Created by Kartik Sharma on 17/08/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore


struct ProfileView: View {
    let user:user
    private let grid:[GridItem]=[
        .init(.flexible(),spacing:2),
        .init(.flexible(),spacing:2),
        .init(.flexible(),spacing:2)
    ]
    var posts:[Post]{
        return Post.MOCK_POST.filter({$0.User?.username==user.username})
    }
    private let imageDimension :CGFloat = (UIScreen.main.bounds.width/3)-1
    var body: some View {
        ScrollView {
            HStack{
                VStack(alignment: .leading,spacing: 6){
                    Image(user.profileImageurl ?? "")
                        .resizable()
                        .frame(width: 60,height: 60)
                        .scaledToFit()
                        .clipShape(Circle())
                }
                Spacer()
                UserStatsView(value: 0, title: "Posts")
                Spacer()
                UserStatsView(value: 1, title: "Followers")
                Spacer()
                UserStatsView(value: 3, title: "Following")
                Spacer()
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            if let bio=user.bio{
                Text(bio)
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,8)
            }
            HStack {
                Button(action: {}, label: {
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 150,height: 32)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray,lineWidth: 1))
                })
                
                Button {
                    
                } label: {
                    Text("Share Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 150,height: 32)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
                }
            }
            .padding(.vertical)
            Divider()
            LazyVGrid(columns: grid,spacing: 2, content: {
                ForEach(posts){post in
                    Image("Banana")
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimension,height: imageDimension)
                        .clipped()
                    //                        .overlay(Color.red)
                }
            })
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.automatic)
    }
}
#Preview {
    ProfileView(user: user.MOCK_USER[0])
}
