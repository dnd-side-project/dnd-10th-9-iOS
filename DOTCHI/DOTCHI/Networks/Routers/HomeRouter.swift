//
//  HomeRouter.swift
//  DOTCHI
//
//  Created by yubin on 2/23/24.
//

import Foundation
import Moya

enum HomeRouter {
    case getMain
}

extension HomeRouter: TargetType {

    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .getMain:
            return "cards/main"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMain:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getMain:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getMain:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserInfo.shared.accessToken)",
            ]
        }
    }
}
