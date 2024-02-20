//
//  LoadPhotoUIView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/20/24.
//

import UIKit

final class LoadPhotoUIView: UIView {
    
    private enum Text {
        static let loadPhoto = "사진을 불러와 주세요!"
    }

    // MARK: UIComponents
    
    private let photoIconImageView: UIImageView = UIImageView(image: .icnLoadPhoto)
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.loadPhoto
        label.setStyle(.sub, .dotchiWhite.withAlphaComponent(0.5))
        label.textAlignment = .center
        return label
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
        
    }
    
    private func setLayout() {
        self.addSubviews([photoIconImageView, titleLabel])
        
        self.photoIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.photoIconImageView.snp.bottom).offset(12)
            make.horizontalEdges.centerX.bottom.equalToSuperview()
        }
    }
}
