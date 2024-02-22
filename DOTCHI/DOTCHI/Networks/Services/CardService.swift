//
//  CardService.swift
//  DOTCHI
//
//  Created by Jungbin on 2/22/24.
//

import Foundation
import Moya

internal protocol CardServiceProtocol {
    func postCard(data: PostCardRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
    func getComments(cardId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class CardService: BaseService {
    static let shared = CardService()
    private lazy var provider = DotchiMoyaProvider<CardRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension CardService: CardServiceProtocol {
    
    // [POST] 카드 작성
    
    func postCard(data: PostCardRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.postCard(data: data)) { result in
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
    
    // [GET] 댓글 조회 (따봉도치 상세)
    
    func getComments(cardId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getComments(cardId: cardId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, GetCommentsResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
