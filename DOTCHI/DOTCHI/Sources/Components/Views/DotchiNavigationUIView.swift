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
        case closeCenterTitle
        case backCenterTitle
        case backMore
        case closeMore
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
    
    lazy var centerTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.subTitle, .dotchiWhite)
        label.textAlignment = .center
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(.icnMore, for: .normal)
        return button
    }()
    
    // MARK: Initializer
    
    init(type: NavigationType) {
        super.init(frame: .zero)
        
        self.setDefaultLayout()
        
        switch type {
        case .back: self.setBackLayout()
        case .closeCenterTitle: self.setCloseCenterTitleLayout()
        case .backCenterTitle: self.setBackCenterTitleLayout()
        case .backMore: self.setBackMoreLayout()
        case .closeMore: self.setCloseMoreLayout()
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
    
    private func setCloseCenterTitleLayout() {
        self.addSubviews([closeButton, centerTitleLabel])
        
        self.setLeftButtonLayout(button: self.closeButton)
        self.setCenterTitleLabelLayout()
    }
    
    private func setBackCenterTitleLayout() {
        self.addSubviews([backButton, centerTitleLabel])
        
        self.setLeftButtonLayout(button: self.backButton)
        self.setCenterTitleLabelLayout()
    }
    
    private func setBackMoreLayout() {
        self.addSubviews([backButton, moreButton])
        
        self.setLeftButtonLayout(button: self.backButton)
        self.setRightButtonLayout(button: self.moreButton)
    }
    
    private func setCloseMoreLayout() {
        self.addSubviews([closeButton, moreButton])
        
        self.setLeftButtonLayout(button: self.closeButton)
        self.setRightButtonLayout(button: self.moreButton)
    }
    
    private func setLeftButtonLayout(button: UIButton) {
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.width.height.equalTo(32)
        }
    }
    
    private func setRightButtonLayout(button: UIButton) {
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
            make.width.height.equalTo(32)
        }
    }
    
    private func setCenterTitleLabelLayout() {
        self.centerTitleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
