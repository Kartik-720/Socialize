//
//  CommentModel.swift
//  Socialize
//
//  Created by Kartik Sharma on 14/10/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct Comment: Identifiable,Codable {
    @DocumentID var id: String?
    let postId: String
    let userId: String
    let text: String
    let timestamp: Timestamp
    enum CodingKeys: String, CodingKey {
        case id
        case postId
        case userId
        case text
        case timestamp
    }
}
