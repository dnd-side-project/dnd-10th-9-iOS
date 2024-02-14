//
//  BrowseViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/11/24.
//

import UIKit
import SnapKit

final class BrowseViewController: BaseViewController {
    
    private enum Text {
        static let title = "따봉도치 둘러보기"
    }
    
    // MARK: UIComponents
    
    private let navigationView: DotchiNavigationUIView = DotchiNavigationUIView(type: .back)
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.title
        label.setStyle(.bigTitle, .white)
        return label
    }()
    
    private let latestButton: DotchiSortUIButton = DotchiSortUIButton(sortType: .latest)
    
    private let popularButton: DotchiSortUIButton = DotchiSortUIButton(sortType: .hot)
    
    // MARK: Properties
    
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
        self.setButtonToggle()
        self.fetchData(isLatest: self.latestButton.isSelected)
    }
    
    // MARK: Methods
    
    private func setButtonToggle() {
        self.latestButton.isSelected = true
        
        [self.latestButton, self.popularButton].forEach({ button in
            button.setAction { [weak self] in
                self?.latestButton.isSelected.toggle()
                self?.popularButton.isSelected.toggle()
                
                self?.fetchData(isLatest: self?.latestButton.isSelected ?? true)
            }
        })
    }
}

// MARK: - Network

extension BrowseViewController {
    private func fetchData(isLatest: Bool) {
        // TODO: fetchData networking
        debugPrint(#function, "isLatest \(isLatest)")
    }
}

// MARK: - UI

extension BrowseViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, titleLabel, latestButton, popularButton])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(32)
        }
        
        self.latestButton.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(28)
            make.width.equalTo(42)
            make.height.equalTo(22)
        }
        
        self.popularButton.snp.makeConstraints { make in
            make.top.width.height.equalTo(self.latestButton)
            make.leading.equalTo(self.latestButton.snp.trailing).offset(9)
        }
    }
}
