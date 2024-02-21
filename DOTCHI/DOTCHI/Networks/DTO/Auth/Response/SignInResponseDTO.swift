//
//  SignInResponseDTO.swift
//  DOTCHI
//
//  Created by Jungbin on 2/22/24.
//

import Foundation

struct SignInResponseDTO: Decodable {
    let memberID: Int
    let memberName: String
    let memberImageURL: String
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case memberName = "memberName"
        case memberImageURL = "memberImageUrl"
        case accessToken = "accessToken"
    }
}
