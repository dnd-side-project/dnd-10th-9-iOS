//
//  GetAllCardsResponseDTO.swift
//  DOTCHI
//
//  Created by Jungbin on 2/23/24.
//

import Foundation

struct GetAllCardsResponseDTO: Decodable {
    let cards: [Card]

    enum CodingKeys: String, CodingKey {
        case cards = "cards"
    }
    
    // MARK: - RecentCard
    struct Card: Decodable {
        let cardID: Int
        let memberID: Int
        let memberName: String
        let memberImageURL: String
        let cardImageURL: String
        let themeID: Int
        let backName: String
        let backMood: String
        let backContent: String
        let commentCount: Int

        enum CodingKeys: String, CodingKey {
            case cardID = "cardId"
            case memberID = "memberId"
            case memberName = "memberName"
            case memberImageURL = "memberImageUrl"
            case cardImageURL = "cardImageUrl"
            case themeID = "themeId"
            case backName = "backName"
            case backMood = "backMood"
            case backContent = "backContent"
            case commentCount = "commentCount"
        }
        
        func toCardEntity() -> CardEntity {
            return CardEntity(
                user: CardUserEntity(
                    userId: self.memberID,
                    profileImageUrl: self.memberImageURL,
                    username: self.memberName
                ),
                front: CardFrontEntity(
                    cardId: self.cardID,
                    imageUrl: self.cardImageURL,
                    luckyType: LuckyType(rawValue: self.themeID) ?? .lucky,
                    dotchiName: self.backName
                ),
                back: CardBackEntity(
                    cardId: self.cardID,
                    dotchiName: self.backName,
                    dotchiMood: self.backMood,
                    dotchiContent: self.backContent,
                    luckyType: LuckyType(rawValue: self.themeID) ?? .lucky
                )
            )
        }
    }
}
