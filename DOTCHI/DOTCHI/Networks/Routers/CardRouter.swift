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
    case postComment(cardId: Int)
    case deleteCard(cardId: Int)
    case getAllCards(data: GetAllCardsRequestDTO)
}

extension CardRouter: TargetType {

    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .postCard:
            return "/cards"
        case .getComments(let cardId), .postComment(let cardId):
            return "/cards/\(cardId)/comments"
        case .deleteCard(let cardId):
            return "/cards/\(cardId)"
        case .getAllCards:
            return "/cards/all"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postCard, .postComment:
            return .post
        case .getComments, .getAllCards:
            return .get
        case .deleteCard:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case .postCard(let data):
            return .uploadMultipart(data.toMultipartFormData())
        case .getComments, .postComment, .deleteCard:
            return .requestPlain
        case .getAllCards(let data):
            return .requestParameters(parameters: data.toDictionary(), encoding: URLEncoding.default)
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
