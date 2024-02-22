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
}

extension CardRouter: TargetType {

    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .postCard:
            return "/cards"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postCard:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .postCard(let data):
            return .uploadMultipart(data.toMultipartFormData())
        }
    }

    var headers: [String: String]? {
        switch self {
        case .postCard:
            return [
                "Content-Type": "multipart/form-data",
                "Authorization": "Bearer \(UserInfo.shared.accessToken)",
            ]
        }
    }
}
