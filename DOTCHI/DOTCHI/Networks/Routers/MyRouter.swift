//
//  MyRouter.swift
//  DOTCHI
//
//  Created by yubin on 2/23/24.
//

import Foundation
import Moya

enum MyRouter {
    case getMembers(memberId: Int, lastCardId: Int)
}

extension MyRouter: TargetType {

    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .getMembers(let memberId, _):
            return "/members/\(memberId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMembers:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getMembers(_, let lastCardId):
            let parameters: [String: Any] = [
                "lastCardId": lastCardId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getMembers:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserInfo.shared.accessToken)",
            ]
        }
    }
}

