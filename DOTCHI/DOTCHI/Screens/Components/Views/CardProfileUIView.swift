//
//  CardProfileUIView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/14/24.
//

import UIKit
import SnapKit

final class CardProfileUIView: UIView {
    
    // MARK: UIComponents
    
    private let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.makeRounded(cornerRadius: 24 / 2)
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.sub, .dotchiWhite)
        return label
    }()
    
    // MARK: Properties
    
    var userId: Int = 0
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setUI(luckyType: LuckyType, headType: CardHeadType) {
        switch luckyType {
        case .health:
            self.backgroundColor = headType == .front ? .dotchiDeepOrange : .dotchiOrange
        case .lucky:
            self.backgroundColor = headType == .front ? .dotchiDeepGreen : .dotchiGreen
        case .money:
            self.backgroundColor = headType == .front ? .dotchiDeepBlue : .dotchiBlue
        case .love:
            self.backgroundColor = headType == .front ? .dotchiDeepPink : .dotchiPink
        }
    }
    
    func setData(data: CardUserEntity, luckyType: LuckyType, headType: CardHeadType) {
        self.profileImageView.setImageUrl(data.profileImageUrl)
        self.usernameLabel.text = data.username
        self.userId = data.userId
        
        self.setUI(luckyType: luckyType, headType: headType)
    }
}

extension CardProfileUIView {
    private func setLayout() {
        self.addSubviews([profileImageView, usernameLabel])
        
        self.profileImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(self.profileImageView.snp.height)
        }
        
        self.usernameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.profileImageView)
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(12)
        }
    }
}
