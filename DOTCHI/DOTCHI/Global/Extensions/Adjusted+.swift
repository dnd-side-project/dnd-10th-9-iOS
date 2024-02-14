//
//  Adjusted+.swift
//  DOTCHI
//
//  Created by Jungbin on 2/14/24.
//

import UIKit

/**
 - Description:
 스크린 너비 393을 기준으로 디자인이 나왔을 때 현재 기기의 스크린 사이즈에 비례하는 수치를 Return한다.
 - Note:
 기기별 대응에 사용하면 된다.
 ex) (size: 20.adjusted)
 */
extension CGFloat {
    var adjustedW: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 393
        return self * ratio
    }
    
    var adjustedH: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.height / 852
        return self * ratio
    }
}

extension Double {
    var adjustedW: Double {
        let ratio: Double = Double(UIScreen.main.bounds.width / 393)
        return self * ratio
    }
    
    var adjustedH: Double {
        let ratio: Double = Double(UIScreen.main.bounds.height / 852)
        return self * ratio
    }
}
