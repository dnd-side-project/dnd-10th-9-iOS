//
//  ThemeResponseDTO.swift
//  DOTCHI
//
//  Created by yubin on 2/23/24.
//

import Foundation

struct ThemeResponseDTO: Codable {
    let code: Int
    let message: String
    let result: CardResultDTO
}

struct CardResultDTO: Codable {
    let cards: [Card]
}

struct Card: Codable, Identifiable {
    let cardId: Int
    let memberId: Int
    let memberName: String
    let memberImageUrl: String
    let cardImageUrl: String
    let themeId: Int
    let backName: String
    let commentCount: Int
    
    var id: Int {
        return cardId
    }
    
    var themeType: LuckyType {
        return getLuckyType(forThemeId: themeId)
    }
}
