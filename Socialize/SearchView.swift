//
//  SearchView.swift
//  Socialize
//
//  Created by Kartik Sharma on 21/08/24.
//

import SwiftUI

struct SearchView: View {
    @State private var search = ""
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                // Custom search bar with rounded background
                HStack {
                    TextField("Search...", text: $search)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .onChange(of: search) { newValue in
                            viewModel.filterUsers(by: newValue)
                        }
                }
                .padding(.top)
                
                // Display users with filtered search results
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.filteredUsers, id: \.id) { user in
                            NavigationLink(destination: ProfileView(user: user)) {
                                HStack {
                                    AsyncImage(url: URL(string: user.profileImageurl ?? "")) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Circle()
                                            .fill(Color.gray.opacity(0.5))
                                    }
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(user.username)
                                            .font(.headline)
                                            .fontDesign(.rounded)
                                            .fontWeight(.semibold)
                                        Text(user.fullname ?? "")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 10)
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .foregroundColor(.black)
    }
}

#Preview {
    SearchView()
}
