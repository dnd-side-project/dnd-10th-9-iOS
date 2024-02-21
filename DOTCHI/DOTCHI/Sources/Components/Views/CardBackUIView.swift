//
//  CardBackUIView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/15/24.
//

import UIKit
import SnapKit

final class CardBackUIView: UIView {
    
    private enum Text {
        static let nameGuide = "나는 "
        static let moodGuide = "오늘따라 "
        static let toYouGuide = "나를 만난 너에게"
    }
    
    // MARK: UIComponents
    
    private let frameImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let cardProfileView: CardProfileUIView = {
        let view: CardProfileUIView = CardProfileUIView()
        view.makeRounded(cornerRadius: 34 / 2)
        return view
    }()
    
    private let dotchiNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.nameGuide
        label.setStyle(.head, .dotchiBlack)
        return label
    }()
    
    private let dotchiMoodLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.moodGuide
        label.setStyle(.head, .dotchiBlack)
        label.numberOfLines = 2
        return label
    }()
    
    private let dotchiContentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "일이삼사오육칠팔구십\n일이삼사오육칠팔구십"
        label.setStyle(.head, .dotchiBlack)
        label.numberOfLines = 2
        return label
    }()
    
    private let dotchiToYouLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.toYouGuide
        label.setStyle(.head, .dotchiBlack)
        return label
    }()
    
    private let dotchiLuckyTypeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .head
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
            self.frameImageView.image = .imgHealthBack
        case .lucky:
            self.frameImageView.image = .imgLuckyBack
        case .money:
            self.frameImageView.image = .imgMoneyBack
        case .love:
            self.frameImageView.image = .imgLoveBack
        }
    }
    
    func setData(backData: CardBackEntity, userData: CardUserEntity) {
        self.setFrameImageView(luckyType: backData.luckyType)
        
        self.dotchiNameLabel.text = Text.nameGuide + backData.dotchiName
        self.dotchiNameLabel.setColor(to: backData.dotchiName, with: backData.luckyType.uiColorNormal())
        
        self.dotchiMoodLabel.text = Text.moodGuide + backData.dotchiMood
        self.dotchiMoodLabel.setColor(to: backData.dotchiMood, with: backData.luckyType.uiColorNormal())
        
        self.dotchiContentLabel.text = backData.dotchiContent
        
        self.dotchiLuckyTypeLabel.textColor = backData.luckyType.uiColorNormal()
        self.dotchiLuckyTypeLabel.text = backData.luckyType.toYouMessage()
        self.cardProfileView.setData(data: userData, luckyType: backData.luckyType, headType: .back)
    }
    
    func setCommentViewData(backData: CardBackEntity, userData: CardUserEntity) {
        self.setData(backData: backData, userData: userData)
        [self.dotchiNameLabel, self.dotchiMoodLabel, self.dotchiContentLabel, self.dotchiToYouLabel, self.dotchiLuckyTypeLabel].forEach { label in
            label.font = .body
        }
    }
    
    func setData(makeDotchiData: MakeDotchiEntity) {
        self.setFrameImageView(luckyType: makeDotchiData.luckyType)
        
        self.dotchiNameLabel.text = Text.nameGuide + makeDotchiData.dotchiName
        self.dotchiNameLabel.setColor(to: makeDotchiData.dotchiName, with: makeDotchiData.luckyType.uiColorNormal())
        
        self.dotchiMoodLabel.text = Text.moodGuide + makeDotchiData.dotchiMood
        self.dotchiMoodLabel.setColor(to: makeDotchiData.dotchiMood, with: makeDotchiData.luckyType.uiColorNormal())
        
        self.dotchiContentLabel.text = makeDotchiData.dotchiContent
        
        self.dotchiLuckyTypeLabel.textColor = makeDotchiData.luckyType.uiColorNormal()
        self.dotchiLuckyTypeLabel.text = makeDotchiData.luckyType.toYouMessage()
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

extension CardBackUIView {
    private func setLayout() {
        self.addSubviews([frameImageView, cardProfileView, dotchiNameLabel, dotchiMoodLabel, dotchiContentLabel, dotchiToYouLabel, dotchiLuckyTypeLabel])
        
        self.frameImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.cardProfileView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.245)
            make.centerX.equalToSuperview()
            make.height.equalTo(34)
        }
        
        self.dotchiNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cardProfileView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(24)
        }
        
        self.dotchiMoodLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiNameLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
        
        self.dotchiContentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiMoodLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
        
        self.dotchiToYouLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiContentLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(24)
        }
        
        self.dotchiLuckyTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiToYouLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(24)
        }
    }
}
