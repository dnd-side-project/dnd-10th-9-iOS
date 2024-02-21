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
    
    func setData(data: CardFrontEntity) {
        self.setFrameImageView(luckyType: data.luckyType)
        self.dotchiLuckyTypeLabel.text = data.luckyType.toYouMessage()
        self.dotchiImageView.setImageUrl(data.imageUrl)
        self.cardProfileView.setData(data: data.mapCardUserEntity(), luckyType: data.luckyType, headType: .back)
    }
}

// MARK: - Layout

extension CardBackUIView {
    private func setLayout() {
        self.addSubviews([dotchiImageView, frameImageView, cardProfileView, dotchiNameLabel, dotchiMoodLabel, dotchiContentLabel, dotchiToYouLabel, dotchiLuckyTypeLabel])
        
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
            make.top.equalTo(self.cardProfileView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(24)
        }
        
        self.dotchiMoodLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiNameLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        self.dotchiContentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiMoodLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        self.dotchiToYouLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiContentLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(24)
        }
        
        self.dotchiLuckyTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiToYouLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(24)
        }
    }
}
