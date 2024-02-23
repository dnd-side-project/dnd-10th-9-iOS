//
//  HomeService.swift
//  DOTCHI
//
//  Created by yubin on 2/23/24.
//

import Foundation
import Moya

class HomeViewModel: ObservableObject {
    @Published var homeResult: HomeResponseDTO?
    
    private let provider = DotchiMoyaProvider<HomeRouter>(isLoggingOn: true)
    
    func fetchHome() {
        provider.request(.getMain) { result in
            switch result {
            case let .success(response):
                do {
                    let mainResponse = try response.map(HomeResponseDTO.self)
                    print("Decoded response: \(mainResponse)")
                    self.homeResult = mainResponse
                } catch {
                    print("Error parsing response: \(error)")
                    self.homeResult = nil
                }
                
            case let .failure(error):
                print("Network request failed: \(error)")
                self.homeResult = nil
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
