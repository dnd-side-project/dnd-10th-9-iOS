//
//  DotchiDoneUIButton.swift
//  DOTCHI
//
//  Created by Jungbin on 2/19/24.
//

import UIKit

final class DotchiDoneUIButton: UIButton {
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.makeRounded(cornerRadius: 8)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        
        self.titleLabel?.font = .bigButton
    }
    
    private func setUI() {
        self.setTitleColor(.dotchiWhite, for: .normal)
        self.setTitleColor(.dotchiWhite.withAlphaComponent(0.5), for: .disabled)
        self.setBackgroundColor(.dotchiGreen, for: .normal)
        self.setBackgroundColor(.dotchiGreen.withAlphaComponent(0.5), for: .disabled)
    }
}
