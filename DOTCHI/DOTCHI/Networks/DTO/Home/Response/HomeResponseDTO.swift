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

struct RecentCardDTO: Codable {
    let cardId: Int
    let memberId: Int
    let memberName: String
    let cardImageUrl: String
    let themeId: Int
    let backName: String
}

struct HomeThemeDTO: Codable {
    let themeId: Int
    let lastCardCreateAt: String
}
