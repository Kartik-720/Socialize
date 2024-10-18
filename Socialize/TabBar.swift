//
//  TabView.swift
//  Socialize
//
//  Created by Kartik Sharma on 21/08/24.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedIndex = 0
    let user : user
    var body: some View {
        TabView(selection:$selectedIndex){
            FeedView()
                .onAppear{
                    selectedIndex = 0
                }
                .tabItem { Image(systemName:"house")
                    .imageScale(.large)}
                .tag(0)
            
            SearchView()
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem { Image(systemName:"magnifyingglass")
                    .imageScale(.large)}
                .tag(1)
            
            UploadPostView(tabIndex: $selectedIndex)
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem { Image(systemName:"plus.square")
                    .imageScale(.large)}
                .tag(2)
            
            CurrentUserProfileView(user: user)
                .onAppear{
                    selectedIndex = 3
                }
                .tabItem { Image(systemName: "person")
                    .imageScale(.large)}
                .tag(3)
        }
        .accentColor(.black)
    }
}

#Preview {
    TabBar(user: user.MOCK_USER[0])
}
