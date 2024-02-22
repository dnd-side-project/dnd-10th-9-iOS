//
//  UIImage+.swift
//  DOTCHI
//
//  Created by Jungbin on 2/22/24.
//

import UIKit.UIImage

extension UIImage {
    func jpeg() -> Data {
        return self.jpegData(compressionQuality: 0.8) ?? Data()
    }
    
    func png() -> Data {
        return self.pngData() ?? Data()
    }
}
