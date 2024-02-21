//
//  DotchiCardFrontUIView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/14/24.
//

import UIKit
import SnapKit

final class CardFrontUIView: UIView {
    
    // MARK: UIComponents
    
    private let frameImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let dotchiImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.makeRounded(cornerRadius: 16)
        return imageView
    }()
    
    private let cardProfileView: CardProfileUIView = {
        let view: CardProfileUIView = CardProfileUIView()
        view.makeRounded(cornerRadius: 34 / 2)
        return view
    }()
    
    private let dotchiNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .dotchiName
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setFrameImageView(luckyType: LuckyType) {
        switch luckyType {
        case .health:
            self.frameImageView.image = .imgHealthFront
        case .lucky:
            self.frameImageView.image = .imgLuckyFront
        case .money:
            self.frameImageView.image = .imgMoneyFront
        case .love:
            self.frameImageView.image = .imgLoveFront
        }
    }
    
    func setData(data: CardFrontEntity) {
        self.setFrameImageView(luckyType: data.luckyType)
        self.dotchiNameLabel.textColor = data.luckyType.uiColorDeep()
        self.dotchiImageView.setImageUrl(data.imageUrl)
        self.dotchiNameLabel.text = data.dotchiName
        self.cardProfileView.setData(data: data.mapCardUserEntity(), luckyType: data.luckyType, headType: .front)
    }
    
    func setData(makeDotchiData: MakeDotchiEntity) {
        self.setFrameImageView(luckyType: makeDotchiData.luckyType)
        self.dotchiNameLabel.textColor = makeDotchiData.luckyType.uiColorDeep()
        self.dotchiImageView.image = makeDotchiData.image
        self.dotchiNameLabel.text = makeDotchiData.dotchiName
        self.cardProfileView.setData(
            data: .init(
                userId: 0,
                profileImageUrl: UserInfo.shared.profileImageUrl,
                username: UserInfo.shared.username
            ),
            luckyType: makeDotchiData.luckyType,
            headType: .front
        )
    }
}

// MARK: - Layout

extension CardFrontUIView {
    private func setLayout() {
        self.addSubviews([dotchiImageView, frameImageView, cardProfileView, dotchiNameLabel])
        
        self.frameImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.dotchiImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.frameImageView)
        }
        
        self.cardProfileView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32.adjustedH)
            make.centerX.equalToSuperview()
            make.height.equalTo(34)
        }
        
        self.dotchiNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(34.adjustedH)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
    }
}
