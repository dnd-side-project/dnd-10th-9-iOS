//
//  MakeDotchiLuckyTitleUIView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/19/24.
//

import UIKit
import SnapKit

final class MakeDotchiLuckyTitleUIView: UIView {
    
    private enum Text {
        static let description = "을 나눠요"
    }
    
    // MARK: UIComponents
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.bigButton, .dotchiWhite)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Initializer
    
    init(luckyType: LuckyType) {
        super.init(frame: .zero)
        
        self.setLayout()
        self.setUI(luckyType: luckyType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.makeRounded(cornerRadius: self.frame.height / 2)
    }
    
    private func setUI(luckyType: LuckyType) {
        self.backgroundColor = .dotchiMgray
        self.titleLabel.text = luckyType.name() + Text.description
        self.titleLabel.setColor(to: luckyType.name(), with: luckyType.uiColorNormal())
    }
    
    func setTitle(luckyType: LuckyType) {
        self.titleLabel.text = luckyType.name() + Text.description
        self.titleLabel.setColor(to: luckyType.name(), with: luckyType.uiColorNormal())
    }
}

// MARK: - Layout

extension MakeDotchiLuckyTitleUIView {
    private func setLayout() {
        self.addSubview(titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.verticalEdges.equalToSuperview().inset(12)
        }
    }
}
