//
//  GetCommentsResponseDTO.swift
//  DOTCHI
//
//  Created by Jungbin on 2/23/24.
//

import Foundation

struct GetCommentsResponseDTO: Decodable {
    let card: Card
    let comments: [Comment]
    let hasComment: Bool

    enum CodingKeys: String, CodingKey {
        case card = "card"
        case comments = "comments"
        case hasComment = "hasComment"
    }
    
    // MARK: - Card
    struct Card: Decodable {
        let cardID: Int
        let memberID: Int
        let memberName: String
        let cardImageURL: String
        let themeID: Int
        let backName: String
        let backMood: String
        let backContent: String
        let commentCount: Int
        let memberImageUrl: String

        enum CodingKeys: String, CodingKey {
            case cardID = "cardId"
            case memberID = "memberId"
            case memberName = "memberName"
            case cardImageURL = "cardImageUrl"
            case themeID = "themeId"
            case backName = "backName"
            case backMood = "backMood"
            case backContent = "backContent"
            case commentCount = "commentCount"
            case memberImageUrl = "memberImageUrl"
        }
        
        func toCardUserEntity() -> CardUserEntity {
            return CardUserEntity(
                userId: self.memberID,
                profileImageUrl: self.memberImageUrl,
                username: self.memberName
            )
        }
        
        func toCardFrontEntity() -> CardFrontEntity {
            return CardFrontEntity(
                cardId: self.cardID,
                imageUrl: self.cardImageURL,
                luckyType: LuckyType(rawValue: self.themeID) ?? .lucky,
                dotchiName: self.backName
            )
        }
        
        func toCardBackEntity() -> CardBackEntity {
            return CardBackEntity(
                cardId: self.cardID,
                dotchiName: self.backName,
                dotchiMood: self.backMood,
                dotchiContent: self.backContent,
                luckyType: LuckyType(rawValue: self.themeID) ?? .lucky
            )
        }
    }

    // MARK: - Comment
    struct Comment: Decodable {
        let memberID: Int
        let memberName: String
        let memberImageURL: String

        enum CodingKeys: String, CodingKey {
            case memberID = "memberId"
            case memberName = "memberName"
            case memberImageURL = "memberImageUrl"
        }
        
        func toCommentEntity() -> CommentEntity {
            return CommentEntity(
                userId: self.memberID,
                username: self.memberName,
                profileImageUrl: self.memberImageURL
            )
        }
    }
}
