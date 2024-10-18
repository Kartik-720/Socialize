//
//  CurrentUserProfileView.swift
//  Socialize
//
//  Created by Kartik Sharma on 25/08/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    private let grid:[GridItem]=[
        .init(.flexible(),spacing:2),
        .init(.flexible(),spacing:2),
        .init(.flexible(),spacing:2)
    ]
    let User:user
    private var posts:[Post]{
        return Post.MOCK_POST.filter({$0.User?.username==User.username})
    }
    private let imageDimension :CGFloat = (UIScreen.main.bounds.width/3)-1
    var body: some View {
        
        NavigationStack {
            ScrollView {
                HStack{
                    VStack(alignment: .leading,spacing: 6){
                        Image("Banana")
                            .resizable()
                            .frame(width: 60,height: 60)
                            .scaledToFit()
                            .clipShape(Circle())
                        Text("It's Banana")
                            .font(.subheadline)
                            .fontDesign(.rounded)
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
            .navigationTitle("\(User.username)")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar{
                ToolbarItem{
                    Button{
                        
                    }label:{
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView(User: user.MOCK_USER[0])
}
