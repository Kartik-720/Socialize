//
//  UserStatsView.swift
//  Socialize
//
//  Created by Kartik Sharma on 21/08/24.
//

import SwiftUI

struct UserStatsView: View {
    var value:Int
    var title:String
    var body: some View {
        VStack{
            Text("\(value)")
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    UserStatsView(value: 0, title: "Posts")
}
