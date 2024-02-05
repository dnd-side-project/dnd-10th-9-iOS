//
//  DotchiMoyaProvider.swift
//  dnd-10th-9
//
//  Created by Jungbin on 2/2/24.
//

import Foundation
import Moya

final class DotchiMoyaProvider<TargetRouter: TargetType>: MoyaProvider<TargetRouter> {
    convenience init(isLoggingOn: Bool = false) {
        self.init(plugins: [NetworkLoggerPlugin()])
    }
}
