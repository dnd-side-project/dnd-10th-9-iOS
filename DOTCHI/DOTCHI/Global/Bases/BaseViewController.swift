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
        
        self.setBackgroundColor()
    }
    
    // MARK: Methods
    
    /// 모든 뷰의 기본 Background color 설정
    private func setBackgroundColor() {
        self.view.backgroundColor = .backgroundBlack
    }
}
