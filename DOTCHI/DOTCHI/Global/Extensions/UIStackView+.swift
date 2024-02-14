//
//  UIStackView+.swift
//  DOTCHI
//
//  Created by Jungbin on 2/14/24.
//

import UIKit.UIStackView

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    func removeAllArrangedSubviews() {
            let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
                self.removeArrangedSubview(subview)
                return allSubviews + [subview]
            }
            // Deactivate all constraints
            NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
            // Remove the views from self
            removedSubviews.forEach({ $0.removeFromSuperview() })
        }
}
