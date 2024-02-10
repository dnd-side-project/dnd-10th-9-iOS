//
//  BrowseViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/11/24.
//

import UIKit
import SnapKit

final class BrowseViewController: BaseViewController {
    
    // MARK: UIComponents
    
    private let navigationView: DotchiNavigationView = DotchiNavigationView(type: .back)
    
    // MARK: Properties
    
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
    }
    
    // MARK: Methods
    
    
}

// MARK: - UI

extension BrowseViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
