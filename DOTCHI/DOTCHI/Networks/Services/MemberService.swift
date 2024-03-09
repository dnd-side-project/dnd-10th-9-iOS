//
//  MemberService.swift
//  DOTCHI
//
//  Created by Jungbin on 3/8/24.
//

import Foundation
import Moya

internal protocol MemberServiceProtocol {
    func blockUser(userId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class MemberService: BaseService {
    static let shared = MemberService()
    private lazy var provider = DotchiMoyaProvider<MemberRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension MemberService: MemberServiceProtocol {
    
    // [POST] 유저 차단
    
    func blockUser(userId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.blockUser(userId: userId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, String.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
