//
//  CircularProfileImageView.swift
//  Socialize
//
//  Created by Kartik Sharma on 12/09/24.
//

import SwiftUI
import Kingfisher
struct CircularProfileImageView: View {
    let User:user
    var body: some View {
        if let imageUrl = User.profileImageurl{
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 80,height: 80)
                .clipShape(Circle())
        }
        else{
            Image(systemName:"person")
                .resizable()
                .frame(width: 60,height: 60)
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(User: user.MOCK_USER[0])
}
