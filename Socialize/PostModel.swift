//
//  PostModel.swift
//  Socialize
//
//  Created by Kartik Sharma on 25/08/24.
//

import Foundation
import Firebase
struct Post:Identifiable,Hashable,Codable{
    let id: String
    let OwnerId:String
    var caption:String?
    var likes:Int
    let ImageURL:String
    let timeStamp:Timestamp
    var User:user?
}


extension Post{
    static var MOCK_POST:[Post]=[
        .init(id: UUID().uuidString,
              OwnerId: UUID().uuidString,
              caption: "I am Fruit",
              likes: 24,
              ImageURL: "Banana",
              timeStamp: Timestamp(),
              User: user.MOCK_USER[0])
    ]
}
