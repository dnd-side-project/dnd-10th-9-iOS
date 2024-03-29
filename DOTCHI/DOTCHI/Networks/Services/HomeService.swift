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
                    self.homeResult = mainResponse
                } catch {
                    self.homeResult = nil
                }
                
            case let .failure(error):
                self.homeResult = nil
            }
        }
    }
}

class ThemeViewModel: ObservableObject {
    @Published var themeResult: ThemeResponseDTO?
    
    private let provider = DotchiMoyaProvider<HomeRouter>(isLoggingOn: true)
    
    func fetchTheme(themeId: Int, cardSortType: String, lastCardId: Int, lastCardCommentCount: Int ) {
        provider.request(.getTheme(themeId: themeId, cardSortType: cardSortType, lastCardId: lastCardId, lastCardCommentCount: lastCardCommentCount)) { result in
            switch result {
            case let .success(response):
                do {
                    let mainResponse = try response.map(ThemeResponseDTO.self)
                    self.themeResult = mainResponse
                } catch {
                    self.themeResult = nil
                }
                
            case let .failure(error):
                self.themeResult = nil
            }
        }
    }
}
