//
//  MemberRouter.swift
//  DOTCHI
//
//  Created by Jungbin on 3/8/24.
//

import Foundation
import Moya

enum MemberRouter {
    case blockUser(userId: Int)
}

extension MemberRouter: TargetType {

    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .blockUser(let userId):
            return "/blacklists/\(userId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .blockUser:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .blockUser:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(UserInfo.shared.accessToken)",
        ]
    }
}
