//
//  UIColor+.swift
//  DOTCHI
//
//  Created by Jungbin on 2/23/24.
//

import UIKit.UIColor

extension UIColor {
    func toHexString() -> String {
        guard let components = cgColor.components, components.count >= 3 else {
            return "#000000"
        }
        
        let r = Int(components[0] * 255.0)
        let g = Int(components[1] * 255.0)
        let b = Int(components[2] * 255.0)
        
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
