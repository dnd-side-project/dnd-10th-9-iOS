//
//  DotchiUITextField.swift
//  DOTCHI
//
//  Created by Jungbin on 2/20/24.
//

import UIKit
import SnapKit

final class DotchiUITextField: UITextField {
    
    // MARK: Properties
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setUI() {
        self.backgroundColor = .dotchiMgray
        self.font = .head2
        self.textColor = .dotchiLgray
        self.addLeftPadding(12)
        self.addRightPadding(12)
        self.makeRounded(cornerRadius: 8)
    }
}
