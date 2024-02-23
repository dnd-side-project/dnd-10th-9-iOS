//
//  MyResponseDTO.swift
//  DOTCHI
//
//  Created by yubin on 2/23/24.
//

import Foundation

struct MyResponseDTO: Codable {
    let code: Int
    let message: String
    let result: MyResultDTO
}

struct MyResultDTO: Codable {
    let member: MemberDTO
    let recentCards: [RecentCardDTO]
}

struct MemberDTO: Codable {
    let id: Int
    let memberName: String
    let memberImageUrl: String
    let description: String
    let cardCount: Int
}
