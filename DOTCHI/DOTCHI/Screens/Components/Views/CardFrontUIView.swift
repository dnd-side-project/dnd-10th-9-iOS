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
    
    func setData(data: CardFrontEntity) {
        switch data.luckyType {
        case .health:
            self.dotchiNameLabel.textColor = .dotchiDeepOrange
            self.frameImageView.image = .imgHealthFront
        case .lucky:
            self.dotchiNameLabel.textColor = .dotchiDeepGreen
            self.frameImageView.image = .imgLuckyFront
        case .money:
            self.dotchiNameLabel.textColor = .dotchiDeepBlue
            self.frameImageView.image = .imgMoneyFront
        case .love:
            self.dotchiNameLabel.textColor = .dotchiDeepPink
            self.frameImageView.image = .imgLoveFront
        }
        
        self.dotchiImageView.setImageUrl(data.imageUrl)
        self.dotchiNameLabel.text = data.dotchiName
        self.cardProfileView.setData(data: data.mapCardUserEntity(), luckyType: data.luckyType, headType: .front)
    }
}

// MARK: - UI

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
