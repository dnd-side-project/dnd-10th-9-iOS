//
//  GetAllCardsRequestDTO.swift
//  DOTCHI
//
//  Created by Jungbin on 2/23/24.
//

import Foundation

struct GetAllCardsRequestDTO: Codable {
    let cardSortType: String
    let lastCardID: Int
    let lastCardCommentCount: Int

    enum CodingKeys: String, CodingKey {
        case cardSortType = "cardSortType"
        case lastCardID = "lastCardId"
        case lastCardCommentCount = "lastCardCommentCount"
    }
}
