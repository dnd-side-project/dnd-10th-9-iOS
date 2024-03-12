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
    case getMembers(memberId: Int, lastCardId: Int)
    case patchMembers(data: PatchMembersRequestDTO)
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
        case .getMembers(let memberId, _):
            return "/members/\(memberId)"
        case .patchMembers:
            return "/members/me"
        }
    }

    var method: Moya.Method {
        switch self {
        case .blockUser, .reportUser:
            return .post
        case .getMembers:
            return .get
        case .patchMembers:
            return .patch
        }
    }

    var task: Task {
        switch self {
        case .blockUser:
            return .requestPlain
        case .reportUser(_, let data):
            return .requestJSONEncodable(data)
        case .getMembers(_, let lastCardId):
            let parameters: [String: Any] = [
                "lastCardId": lastCardId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .patchMembers(let data):
            return .uploadMultipart(data.toMultipartFormData())
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(UserInfo.shared.accessToken)",
        ]
    }
}
