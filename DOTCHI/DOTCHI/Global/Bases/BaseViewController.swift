//
//  BaseViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    // MARK: UIComponents
    
    
    
    // MARK: Properties
    
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
    }
    
    // MARK: Methods
    
    private func setUI() {
        self.view.backgroundColor = .backgroundBlack
    }
}
