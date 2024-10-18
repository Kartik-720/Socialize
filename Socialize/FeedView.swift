//
//  FeedView.swift
//  Socialize
//
//  Created by Kartik Sharma on 21/08/24.
//
import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.posts) { post in
                        FeedCellView(post: post)
                    }
                }
                .padding(.top, 8) // Slight padding for comfortable scrolling
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Socialize")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.leading, 16)  // Add some leading padding to give space
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 20) {
                        Image(systemName: "heart.fill")
                            .imageScale(.large)
                            .foregroundColor(.red)
                            .frame(width: 24, height: 24)  // Ensure consistent sizing
                        
                        Image(systemName: "paperplane.fill")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                            .frame(width: 24, height: 24)
                    }
                    .padding(.trailing, 16)  // Padding to keep elements away from screen edge
                }
            }
        }
    }
}


#Preview {
    FeedView()
}

