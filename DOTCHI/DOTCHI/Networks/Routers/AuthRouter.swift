//
//  AuthRouter.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import Foundation
import Moya

enum SocialType: String {
    case apple = "APPLE"
}

enum AuthRouter {
    case requestSignIn(data: SignInRequestDTO)
}

extension AuthRouter: TargetType {

    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .requestSignIn:
            return "/members/login"
        }
    }

    var method: Moya.Method {
        switch self {
        case .requestSignIn:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .requestSignIn(let data):
            return .requestJSONEncodable(data)
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
