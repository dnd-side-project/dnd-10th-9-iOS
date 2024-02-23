//
//  MyService.swift
//  DOTCHI
//
//  Created by yubin on 2/23/24.
//

import Foundation
import Moya

class MyViewModel: ObservableObject {
    @Published var myResult: MyResponseDTO?
    
    private let provider = DotchiMoyaProvider<MyRouter>(isLoggingOn: true)
    
    func fetchMy(memberId: Int, lastCardId: Int) {
        provider.request(.getMembers(memberId: memberId, lastCardId: lastCardId)) { result in
            switch result {
            case let .success(response):
                do {
                    let mainResponse = try response.map(MyResponseDTO.self)
                    self.myResult = mainResponse
                } catch {
                    self.myResult = nil
                }
                
            case let .failure(error):
                self.myResult = nil
            }
        }
    }
}
