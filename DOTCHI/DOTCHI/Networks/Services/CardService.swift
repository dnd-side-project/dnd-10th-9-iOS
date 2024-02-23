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
    func postComment(cardId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
    func deleteCard(cardId: Int, completion: @escaping (NetworkResult<Any>) -> (Void))
    func getAllCards(data: GetAllCardsRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
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
    
    // [POST] 댓글 작성
    
    func postComment(cardId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.postComment(cardId: cardId)) { result in
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
    
    // [DELETE] 카드 삭제
    
    func deleteCard(cardId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.deleteCard(cardId: cardId)) { result in
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
    
    // [GET] 전체 카드 조회
    
    func getAllCards(data: GetAllCardsRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getAllCards(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, GetAllCardsResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
