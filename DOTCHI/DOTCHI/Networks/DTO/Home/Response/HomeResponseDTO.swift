//
//  HomeResponseDTO.swift
//  DOTCHI
//
//  Created by yubin on 2/23/24.
//

import Foundation

struct HomeResponseDTO: Codable {
    let code: Int
    let message: String
    let result: HomeResultDTO
}

struct HomeResultDTO: Codable {
    let todayCards: [TodayCardDTO]?
    let recentCards: [RecentCardDTO]?
    let themes: [HomeThemeDTO]?
}

struct TodayCardDTO: Codable {
    let cardId: Int
    let cardImageUrl: String
    let backName: String
}

struct RecentCardDTO: Codable, Identifiable {
    let cardId: Int
    let memberId: Int
    let memberName: String
    let cardImageUrl: String
    let themeId: Int
    let backName: String
    
    var id: Int {
        return cardId
    }
    
    var themeType: LuckyType {
        return getLuckyType(forThemeId: themeId)
    }
}

struct HomeThemeDTO: Codable {
    let themeId: Int
    let lastCardCreateAt: String
}
