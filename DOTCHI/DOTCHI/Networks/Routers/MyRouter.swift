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
    case patchMembers(data: PatchMembersRequestDTO)
}

extension MyRouter: TargetType {

    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .getMembers(let memberId, _):
            return "/members/\(memberId)"
        case .patchMembers:
            return "/members/me"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMembers:
            return .get
        case .patchMembers:
            return .patch
        }
    }

    var task: Task {
        switch self {
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
        switch self {
        case .getMembers:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserInfo.shared.accessToken)",
            ]
        case .patchMembers:
            return [
                "Content-Type": "multipart/form-data",
                "Authorization": "Bearer \(UserInfo.shared.accessToken)",
            ]
        }
    }
}

