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
    
    private let provider = DotchiMoyaProvider<MemberRouter>(isLoggingOn: true)
    
    func fetchMy(memberId: Int, lastCardId: Int) {
        provider.request(.getMembers(memberId: memberId, lastCardId: lastCardId)) { result in
            switch result {
            case let .success(response):
                do {
                    let myResponse = try response.map(MyResponseDTO.self)
                    self.myResult = myResponse
                } catch {
                    self.myResult = nil
                }
                
            case let .failure(error):
                self.myResult = nil
            }
        }
    }
}

class EditViewModel: ObservableObject {
    @Published var editResult: EditResponseDTO?
    
    private let provider = DotchiMoyaProvider<MemberRouter>(isLoggingOn: true)
    
    func fetchEdit(data: PatchMembersRequestDTO) {
        provider.request(.patchMembers(data: data)) { result in
            switch result {
            case let .success(response):
                do {
                    let myResponse = try response.map(EditResponseDTO.self)
                    self.editResult = myResponse
                } catch {
                    self.editResult = nil
                }
                
            case let .failure(error):
                self.editResult = nil
            }
        }
    }
}
