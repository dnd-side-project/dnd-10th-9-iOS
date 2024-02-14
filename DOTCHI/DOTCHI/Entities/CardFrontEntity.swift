//
//  DotchiCardFrontEntity.swift
//  DOTCHI
//
//  Created by Jungbin on 2/14/24.
//

import Foundation

struct CardFrontEntity {
    let cardId: Int
    let imageUrl: String
    let luckyType: LuckyType
    let user: CardUserEntity
    let dotchiName: String
    
    func mapCardUserEntity() -> CardUserEntity {
        return CardUserEntity(
            userId: user.userId,
            profileImageUrl: user.profileImageUrl,
            username: user.username
        )
    }
}
