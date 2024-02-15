//
//  LuckyType.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import Foundation

enum LuckyType: Int {
    case health = 1
    case lucky
    case money
    case love
}

extension LuckyType {
    
    func name() -> String {
        switch self {
        case .health:
            return "건강운"
        case .lucky:
            return "행운"
        case .money:
            return "재물운"
        case .love:
            return "애정운"
        }
    }
    
    func toYouMessage() -> String {
        switch self {
        case .health:
            return "건강운을 나눠 줄게!"
        case .lucky:
            return "행운을 나눠 줄게!"
        case .money:
            return "재물운을 나눠 줄게!"
        case .love:
            return "애정운을 나눠 줄게!"
        }
    }
}
