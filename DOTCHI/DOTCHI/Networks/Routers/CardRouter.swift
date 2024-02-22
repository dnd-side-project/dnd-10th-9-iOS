//
//  CardRouter.swift
//  DOTCHI
//
//  Created by Jungbin on 2/22/24.
//

import Foundation
import Moya

enum CardRouter {
    case postCard(data: PostCardRequestDTO)
    case getComments(cardId: Int)
}

extension CardRouter: TargetType {

    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .postCard:
            return "/cards"
        case .getComments(let cardId):
            return "/cards/\(cardId)/comments"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postCard:
            return .post
        case .getComments:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .postCard(let data):
            return .uploadMultipart(data.toMultipartFormData())
        case .getComments:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .postCard:
            return [
                "Content-Type": "multipart/form-data",
                "Authorization": "Bearer \(UserInfo.shared.accessToken)",
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserInfo.shared.accessToken)",
            ]
        }
    }
}
