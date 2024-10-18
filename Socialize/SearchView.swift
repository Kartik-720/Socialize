//
//  SearchView.swift
//  Socialize
//
//  Created by Kartik Sharma on 21/08/24.
//

import SwiftUI

struct SearchView: View {
    @State private var search = ""
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVStack(spacing:9){
                    ForEach(user.MOCK_USER){user in
                        NavigationLink(value: user) {
                            HStack() {
                                Image(user.profileImageurl ?? "")
                                    .resizable()
                                    .frame(width: 40,height: 40)
                                    .clipShape(Circle())
                                VStack(alignment:.leading){
                                    Text(user.username)
                                        .font(.subheadline)
                                        .fontDesign(.rounded)
                                        .fontWeight(.semibold)
                                    Text(user.fullname ?? "")
                                        .font(.footnote)
                                }
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.horizontal)
                        }
                    }
                }
                .searchable(text: $search,prompt: "Search...")
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: user.self,destination: { user in
                ProfileView(user: user)
            })
            .foregroundStyle(Color(.black))
        }
    }
}

#Preview {
    SearchView()
}
