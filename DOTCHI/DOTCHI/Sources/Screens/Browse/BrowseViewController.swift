//
//  BrowseViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/11/24.
//

import UIKit
import SnapKit

final class BrowseViewController: BaseViewController {
    
    private enum Number {
        static let cellHorizonInset = 49.0
        static let scale = 0.925
    }
    
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
    
    private var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.isPagingEnabled = false
        collectionView.contentInset = .init(top: 0, left: 49.adjustedH, bottom: 0, right: 49.adjustedH)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.layoutMargins = .zero
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    // MARK: Properties
    
    private var cards: [CardEntity] = [
        .init(
            user: .init(
                userId: 1,
                profileImageUrl: ".",
                username: "오뜨"
            ),
            front: .init(
                cardId: 1,
                imageUrl: ".",
                luckyType: .love,
                dotchiName: "따봉냥"
            ),
            back: .init(
                cardId: 1,
                dotchiName: "따봉냥",
                dotchiMood: "엄지가 절로 올라가",
                dotchiContent: "넌 지금 따봉도치와 눈이 마주쳤어!",
                luckyType: .love
            )
        ),
        .init(
            user: .init(
                userId: 1,
                profileImageUrl: ".",
                username: "오뜨"
            ),
            front: .init(
                cardId: 1,
                imageUrl: ".",
                luckyType: .money,
                dotchiName: "따봉냥"
            ),
            back: .init(
                cardId: 1,
                dotchiName: "따봉냥",
                dotchiMood: "엄지가 절로 올라가",
                dotchiContent: "넌 지금 따봉도치와 눈이 마주쳤어!",
                luckyType: .money
            )
        )
    ]
    
    private var previousCellIndex: Int = 0
    private var isFirstScroll: Bool = true
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
        self.setButtonToggle()
        self.fetchData(isLatest: self.latestButton.isSelected)
        self.setCollectionViewLayout()
        self.setCollectionView()
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
    
    private func setCollectionViewLayout() {
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = .init(
            width: (self.view.frame.width - (Number.cellHorizonInset.adjustedH * 2)),
            height: (self.view.frame.width - (Number.cellHorizonInset.adjustedH * 2)) * 1.671186
        )
        collectionViewLayout.minimumLineSpacing = 12.adjustedH
        collectionViewLayout.scrollDirection = .horizontal
        
        self.collectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(cell: BrowseUICollectionViewCell.self)
    }
    
    private func zoomFocusCell(cell: UICollectionViewCell, isFocus: Bool ) {
         UIView.animate( withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
             cell.transform = isFocus ? .identity : CGAffineTransform(scaleX: Number.scale, y: Number.scale)
         }, completion: nil)
     }
}

// MARK: - UICollectionViewDataSource

extension BrowseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowseUICollectionViewCell.className, for: indexPath) as? BrowseUICollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.setData(data: self.cards[indexPath.row])
        cell.commentButton.removeTarget(nil, action: nil, for: .touchUpInside)
        cell.commentButton.setAction { [weak self] in
            self?.navigationController?.pushViewController(DotchiDetailViewController(cardId: self?.cards[indexPath.row].front.cardId ?? 0), animated: true)
        }
        
        self.zoomFocusCell(cell: cell, isFocus: self.isFirstScroll ? indexPath.row == 0 : false)
        self.isFirstScroll = false
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BrowseViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity:CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(
            x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
            y: scrollView.contentInset.top
        )
        targetContentOffset.pointee = offset
        
        let indexPath = IndexPath(item: Int(roundedIndex), section: 0)
        
        if let cell = self.collectionView.cellForItem(at: indexPath) {
            self.zoomFocusCell(cell: cell, isFocus: true)
        }
        
        if Int(roundedIndex) != self.previousCellIndex {
            let preIndexPath = IndexPath(item: self.previousCellIndex, section: 0)
            if let preCell = self.collectionView.cellForItem(at: preIndexPath) {
                self.zoomFocusCell(cell: preCell, isFocus: false)
            }
            self.previousCellIndex = indexPath.item
        }
    }
}

// MARK: - Network

extension BrowseViewController {
    private func fetchData(isLatest: Bool) {
        // TODO: fetchData networking
        debugPrint(#function, "isLatest \(isLatest)")
    }
}

// MARK: - Layout

extension BrowseViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, titleLabel, latestButton, popularButton, collectionView])
        
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
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.latestButton.snp.bottom).offset(0)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(48.adjustedH)
        }
    }
}
