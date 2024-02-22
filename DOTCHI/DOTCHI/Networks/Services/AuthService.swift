//
//  AuthService.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import Foundation
import Moya

internal protocol AuthServiceProtocol {
    func requestSignIn(data: SignInRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class AuthService: BaseService {
    static let shared = AuthService()
    private lazy var provider = DotchiMoyaProvider<AuthRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension AuthService: AuthServiceProtocol {
    
    // [POST] 로그인
    
    func requestSignIn(data: SignInRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.requestSignIn(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, SignInResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
