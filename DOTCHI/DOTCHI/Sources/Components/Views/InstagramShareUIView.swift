//
//  InstagramShareUIView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/23/24.
//

import UIKit
import SnapKit

final class InstagramShareUIView: UIView {
    
    // MARK: UIComponents
    
    private let cardFrontView: CardFrontUIView = CardFrontUIView()
    private let cardBackView: CardBackUIView = CardBackUIView()
    
    // MARK: Properties
    
    private var card: CardEntity?
    
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
        self.makeRounded(cornerRadius: 18)
        self.backgroundColor = .dotchiBlack
    }
    
    func setData(data: CardEntity) {
        self.cardFrontView.setData(frontData: data.front, userData: data.user)
        self.cardBackView.setData(backData: data.back, userData: data.user)
    }
}

// MARK: - Layout

extension InstagramShareUIView {
    private func setLayout() {
        self.addSubviews([cardFrontView, cardBackView])
        
        self.cardFrontView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(12)
            make.width.equalToSuperview().multipliedBy(0.470383)
        }
        
        self.cardBackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(12)
            make.width.equalToSuperview().multipliedBy(0.470383)
//            make.leading.equalTo(self.cardFrontView.snp.trailing).offset(8)
        }
    }
}
