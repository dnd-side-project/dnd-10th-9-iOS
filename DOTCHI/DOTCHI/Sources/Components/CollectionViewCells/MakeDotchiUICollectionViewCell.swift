//
//  MakeDotchiUICollectionViewCell.swift
//  DOTCHI
//
//  Created by Jungbin on 2/17/24.
//

import UIKit
import SnapKit

final class MakeDotchiUICollectionViewCell: UICollectionViewCell {
    
    private enum Text {
        static let loadPhoto = "사진을 불러와 주세요!"
    }
    
    // MARK: UIComponents
    
    private let photoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cardFrontView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let loadPhotoButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(.icnLoadPhoto, for: .normal)
        button.setTitle(Text.loadPhoto, for: .normal)
        button.tintColor = .dotchiHgray
        button.titleLabel?.font = .sub
        button.setTitleColor(.dotchiWhite.withAlphaComponent(0.5), for: .normal)
        var config: UIButton.Configuration = UIButton.Configuration.plain()
        config.imagePadding = 13
        config.imagePlacement = .top
        button.configuration = config
        return button
    }()
    
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
    }
    
    func setData(luckyType: LuckyType) {
        switch luckyType {
        case .health:
            self.cardFrontView.image = .imgHealthFront
        case .lucky:
            self.cardFrontView.image = .imgLuckyFront
        case .money:
            self.cardFrontView.image = .imgMoneyFront
        case .love:
            self.cardFrontView.image = .imgLoveFront
        }
    }
    
    func setPhoto(image: UIImage) {
        self.cardFrontView.image = image
        self.loadPhotoButton.isSelected = true
    }
}

// MARK: - Layout

extension MakeDotchiUICollectionViewCell {
    private func setLayout() {
        self.contentView.addSubviews([photoImageView, cardFrontView, loadPhotoButton])
        
        self.photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.cardFrontView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.loadPhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.885542)
            make.height.equalTo(80)
        }
    }
}
