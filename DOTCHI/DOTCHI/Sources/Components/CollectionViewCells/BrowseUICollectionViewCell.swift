//
//  BrowseUICollectionViewCell.swift
//  DOTCHI
//
//  Created by Jungbin on 2/14/24.
//

import UIKit
import SnapKit

final class BrowseUICollectionViewCell: UICollectionViewCell {
    
    // MARK: UIComponents
    
    let cardBackgroundView: UIView = UIView()
    let cardFrontView: CardFrontUIView = CardFrontUIView()
    let cardBackView: CardBackUIView = CardBackUIView()
    
    private let buttonStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let shareButton: DotchiCircleUIButton = DotchiCircleUIButton(type: .share)
    
    private let commentButton: DotchiCircleUIButton = DotchiCircleUIButton(type: .comment)
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.buttonStackView.addArrangedSubviews([shareButton, commentButton])
    }
    
    func setData(data: CardFrontEntity) {
        self.cardFrontView.setData(data: data)
    }
}

// MARK: - Layout

extension BrowseUICollectionViewCell {
    private func setLayout() {
        self.contentView.addSubviews([cardBackgroundView, buttonStackView])
        self.cardBackgroundView.addSubviews([cardBackView, cardFrontView])
        
        self.cardBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(270.adjustedH)
            make.height.equalTo(400.adjustedH)
        }
        
        self.cardFrontView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.cardBackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(self.cardFrontView.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
        }
    }
}
