//
//  LuckyType.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import UIKit
import SwiftUI

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
    
    func colorNormal() -> Color {
        switch self {
        case .health:
            return Color.dotchiOrange
        case .lucky:
            return Color.dotchiGreen
        case .money:
            return Color.dotchiBlue
        case .love:
            return Color.dotchiPink
        default:
            return Color.dotchiWhite
        }
    }
    
    func uiColorNormal() -> UIColor {
        switch self {
        case .health:
            return .dotchiOrange
        case .lucky:
            return .dotchiGreen
        case .money:
            return .dotchiBlue
        case .love:
            return .dotchiPink
        }
    }
    
    func uiColorLight() -> UIColor {
        switch self {
        case .health:
            return .dotchiLOrange
        case .lucky:
            return .dotchiLGreen
        case .money:
            return .dotchiLBlue
        case .love:
            return .dotchiLPink
        }
    }
    
    func uiColorDeep() -> UIColor {
        switch self {
        case .health:
            return .dotchiDeepOrange
        case .lucky:
            return .dotchiDeepGreen
        case .money:
            return .dotchiDeepBlue
        case .love:
            return .dotchiDeepPink
        }
    }
    
    func imageName() -> String {
        switch self {
        case .health:
            return "imgHealth"
        case .lucky:
            return "imgLucky"
        case .money:
            return "imgMoney"
        case .love:
            return "imgLove"
        }
    }
}
