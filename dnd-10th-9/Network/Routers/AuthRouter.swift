//
//  AuthRouter.swift
//  dnd-10th-9
//
//  Created by Jungbin on 2/5/24.
//

import Foundation
import Moya

enum SocialType: String {
    case apple = "APPLE"
}

enum AuthRouter {
//    case requestSocialLogin(data: SocialLoginRequestDTO)
//    case requestRefreshToken(data: RefreshTokenRequestDTO)
//    case requestLogout(data: LogoutRequestDTO)
}

//extension AuthRouter: TargetType {
//    
//    var baseURL: URL {
//        return URL(string: APIConstants.baseURL)!
//    }
//    
//    var path: String {
//        switch self {
//        case .requestSocialLogin:
//            return "/social/login"
//        case .requestRefreshToken:
//            return "/social/refresh"
//        case .requestLogout:
//            return "social/logout"
//        }
//    }
//    
//    var method: Moya.Method {
//        switch self {
//        case .requestSocialLogin, .requestRefreshToken, .requestLogout:
//            return .post
//        }
//    }
//    
//    var task: Task {
//        switch self {
//        case .requestSocialLogin(let data):
//            let body: [String: Any] = [
//                "token": data.token,
//                "providerType": data.socialType,
//                "deviceToken": data.deviceToken
//            ]
//            return .requestParameters(parameters: body, encoding: JSONEncoding.prettyPrinted)
//        case .requestRefreshToken(let data):
//            return .requestJSONEncodable(data)
//        case .requestLogout(let data):
//            return .requestJSONEncodable(data)
//        }
//    }
//    
//    var headers: [String: String]? {
//        switch self {
//        default:
//            return ["Content-Type": "application/json"]
//        }
//    }
//}
