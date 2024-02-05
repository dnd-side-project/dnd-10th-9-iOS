//
//  DotchiMoyaProvider.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import Foundation
import Moya

final class DotchiMoyaProvider<TargetRouter: TargetType>: MoyaProvider<TargetRouter> {
    convenience init(isLoggingOn: Bool = false) {
        self.init(plugins: [NetworkLoggerPlugin()])
    }
}
