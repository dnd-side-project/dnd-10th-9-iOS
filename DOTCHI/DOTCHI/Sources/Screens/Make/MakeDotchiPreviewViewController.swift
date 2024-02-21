//
//  MakeDotchiPreviewViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/21/24.
//

import UIKit
import SnapKit

final class MakeDotchiPreviewViewController: BaseViewController {
    
    private enum Text {
        static let title = "따봉도치 만들기"
        static let upload = "따봉도치 올리기"
    }
    
    // MARK: UIComponents
    
    private let navigationView: DotchiNavigationUIView = {
        let view: DotchiNavigationUIView = DotchiNavigationUIView(type: .backCenterTitle)
        view.centerTitleLabel.text = Text.title
        return view
    }()
    
    // MARK: Properties
    
    private var makeDotchiData: MakeDotchiEntity = MakeDotchiEntity()
    
    // MARK: Initializer
    
    init(makeDotchiData: MakeDotchiEntity) {
        super.init(nibName: nil, bundle: nil)
        
        self.makeDotchiData = makeDotchiData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
    }
    
    // MARK: Methods
    
    
}

// MARK: - Layout

extension MakeDotchiPreviewViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
