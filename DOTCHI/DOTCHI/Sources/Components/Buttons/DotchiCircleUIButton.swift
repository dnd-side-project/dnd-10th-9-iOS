//
//  DotchiCircleButton.swift
//  DOTCHI
//
//  Created by Jungbin on 2/9/24.
//

import UIKit
import SnapKit

final class DotchiCircleUIButton: UIButton {
    
    enum ButtonType {
        case share
        case comment
    }
    
    // MARK: Initializer
    
    init(type: ButtonType) {
        super.init(frame: .zero)
        
        self.setUI(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setUI(type: ButtonType) {
        self.tintColor = .clear
        switch type {
        case .share:
            self.setImage(.icnShare, for: .normal)
        case .comment:
            self.setImage(.icnComment, for: .normal)
        }
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
    }
}
