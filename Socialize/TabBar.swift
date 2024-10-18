//
//  TabView.swift
//  Socialize
//
//  Created by Kartik Sharma on 21/08/24.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        TabView{
            Text("Home")
                .tabItem { Image("house") }
            Text("Search")
            
            Text("Likes")
            
            Text("Profile")
        }
    }
}

#Preview {
    TabView()
}
