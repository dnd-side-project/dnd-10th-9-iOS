//
//  UIButton+.swift
//  DOTCHI
//
//  Created by Jungbin on 2/11/24.
//

import UIKit.UIButton

extension UIButton {
    public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(minimumSize)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: CGPoint.zero, size: minimumSize))
        }
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        
        self.clipsToBounds = true
        self.setBackgroundImage(colorImage, for: state)
    }
    
    /**
     button에 대해 addTarget해서 일일이 처리하지 않고, closure 형태로 동작을 처리하기 위해 다음과 같은 extension을 활용합니다.
     press를 작성하고, 안에 버튼이 눌렸을 때, 동작하는 함수를 만듭니다.
     */
    public func setAction(_ closure: @escaping () -> Void) {
        self.addAction( UIAction { _ in closure() }, for: UIControl.Event.touchUpInside)
    }
}
