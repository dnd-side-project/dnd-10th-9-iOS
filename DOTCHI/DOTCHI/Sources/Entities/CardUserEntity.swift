//
//  CardUserEntity.swift
//  DOTCHI
//
//  Created by Jungbin on 2/14/24.
//

import Foundation

struct CardUserEntity {
    let userId: Int
    let profileImageUrl: String
    let username: String
    
    init(userId: Int, profileImageUrl: String, username: String) {
        self.userId = userId
        self.profileImageUrl = profileImageUrl
        self.username = username
    }
    
    init() {
        self.userId = 0
        self.profileImageUrl = ""
        self.username = ""
    }
}
