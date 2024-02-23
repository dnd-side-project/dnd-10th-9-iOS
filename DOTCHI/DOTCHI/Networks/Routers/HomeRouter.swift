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
    case getTheme(themeId: Int, cardSortType: String, lastCardId: Int, lastCardCommentCount: Int)
}

extension HomeRouter: TargetType {

    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .getMain:
            return "/cards/main"
        case .getTheme:
            return "/cards/theme"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMain, .getTheme:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getMain:
            return .requestPlain
        case let .getTheme(themeId, cardSortType, lastCardId, lastCardCommentCount):
            let parameters: [String: Any] = [
                "themeId": themeId,
                "cardSortType": cardSortType,
                "lastCardId": lastCardId,
                "lastCardCommentCount": lastCardCommentCount
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getMain, .getTheme:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(UserInfo.shared.accessToken)",
            ]
        }
    }
}
