//
//  MakeDotchiUICollectionViewCell.swift
//  DOTCHI
//
//  Created by Jungbin on 2/17/24.
//

import UIKit
import SnapKit

final class MakeDotchiUICollectionViewCell: UICollectionViewCell {
    
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
    
    private let loadPhotoView: LoadPhotoUIView = LoadPhotoUIView()
    
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
        self.photoImageView.image = image
    }
}

// MARK: - Layout

extension MakeDotchiUICollectionViewCell {
    private func setLayout() {
        self.contentView.addSubviews([loadPhotoView, photoImageView, cardFrontView])
        
        self.photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.cardFrontView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.loadPhotoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.885542)
        }
    }
}
