//
//  DotchiNavigationView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/11/24.
//

import UIKit

final class DotchiNavigationUIView: UIView {
    
    enum NavigationType {
        case back
        case close
    }
    
    // MARK: UIComponents
    
    lazy var backButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(.icnBack, for: .normal)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(.icnClose, for: .normal)
        return button
    }()
    
    // MARK: Initializer
    
    init(type: NavigationType) {
        super.init(frame: .zero)
        
        self.setDefaultLayout()
        
        switch type {
        case .back: self.setBackLayout()
        case .close: self.setCloseLayout()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout

extension DotchiNavigationUIView {
    private func setDefaultLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    private func setBackLayout() {
        self.addSubviews([backButton])
        
        self.setLeftButtonLayout(button: self.backButton)
    }
    
    private func setCloseLayout() {
        self.addSubviews([closeButton])
        
        self.setLeftButtonLayout(button: self.closeButton)
    }
    
    private func setLeftButtonLayout(button: UIButton) {
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.width.height.equalTo(32)
        }
    }
}
