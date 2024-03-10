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
    case reportUser(userId: Int, data: ReportUserRequestDTO)
}

extension MemberRouter: TargetType {

    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .blockUser(let userId):
            return "/blacklists/\(userId)"
        case .reportUser(let userId, _):
            return "/reports/\(userId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .blockUser, .reportUser:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .blockUser:
            return .requestPlain
        case .reportUser(_, let data):
            return .requestJSONEncodable(data)
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(UserInfo.shared.accessToken)",
        ]
    }
}
