//
//  FeedView.swift
//  Socialize
//
//  Created by Kartik Sharma on 21/08/24.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack(spacing:12){
                    ForEach(Post.MOCK_POST){post in
//                        Divider()
                        FeedCellView(post: post)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Image("Instagram")
                        .resizable()
                        .frame(width: 125,height: 50)
                        .scaledToFit()
                }
                ToolbarItem(){
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .padding(.horizontal)
                }
                ToolbarItem(){
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
            }
        }
    }
}

#Preview {
    FeedView()
}

