//
//  HomeService.swift
//  DOTCHI
//
//  Created by yubin on 2/23/24.
//

import Foundation
import Moya

class HomeViewModel: ObservableObject {
    @Published var homeResult: HomeResultDTO?
    
    private let provider = DotchiMoyaProvider<HomeRouter>(isLoggingOn: true)
    
    func fetchHome() {
        provider.request(.getMain) { result in
            switch result {
            case let .success(response):
                do {
                    let MainResponse = try response.map(HomeResultDTO.self)
                    self.homeResult = MainResponse
                } catch {
                    print("Error parsing response: \(error)")
                }
                
            case let .failure(error):
                print("Network request failed: \(error)")
            }
        }
    }
}

/*
internal protocol HomeServiceProtocol {
    func getMain(completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class HomeService: BaseService {
    static let shared = HomeService()
    private lazy var provider = DotchiMoyaProvider<HomeRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension HomeService: HomeServiceProtocol {
    
    // [GET] 메인 페이지 조회
    
    func getMain(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.getMain) { result in
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
*/
