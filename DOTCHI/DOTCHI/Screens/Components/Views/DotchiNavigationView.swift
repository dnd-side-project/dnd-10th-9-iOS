//
//  DotchiNavigationView.swift
//  DOTCHI
//
//  Created by Jungbin on 2/11/24.
//

import UIKit

final class DotchiNavigationView: UIView {
    
    enum NavigationType {
        case back
    }
    
    // MARK: UIComponents
    
    lazy var backButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(.icnBack, for: .normal)
        return button
    }()
}
