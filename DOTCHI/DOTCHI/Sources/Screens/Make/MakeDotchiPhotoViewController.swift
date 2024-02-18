//
//  MakeDotchiPhotoViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/17/24.
//

import UIKit
import SnapKit

final class MakeDotchiPhotoViewController: BaseViewController {
    
    private enum Number {
        static let cellHorizonInset = 49.0
        static let cellHeight = 493.0
        static let scale = 0.925
    }
    
    private enum Text {
        static let title = "따봉도치 만들기"
    }
    
    // MARK: UIComponents
    
    private let navigationView: DotchiNavigationUIView = {
        let view: DotchiNavigationUIView = DotchiNavigationUIView(type: .closeCenterTitle)
        view.centerTitleLabel.text = Text.title
        return view 
    }()
    
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
    
    weak var delegate: MakeDotchiPhotoViewControllerDelegate?
    private var previousCellIndex: Int = 0
    private var isFirstScroll: Bool = true
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setCloseButtonAction()
        self.setCollectionViewLayout()
        self.setCollectionView()
    }
    
    // MARK: Methods
    
    private func setCloseButtonAction() {
        self.navigationView.closeButton.setAction { [weak self] in
//            self?.delegate?.makeDotchiPhotoViewControllerDidDismiss()
            self?.dismiss(animated: true)
        }
    }
    
    private func setCollectionViewLayout() {
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = .init(
            width: (self.view.frame.width - (Number.cellHorizonInset.adjustedH * 2)),
            height: Number.cellHeight.adjustedH
        )
        collectionViewLayout.minimumLineSpacing = 12.adjustedH
        collectionViewLayout.scrollDirection = .horizontal
        
        self.collectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(cell: MakeDotchiUICollectionViewCell.self)
    }
    
    private func zoomFocusCell(cell: UICollectionViewCell, isFocus: Bool ) {
         UIView.animate( withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
             cell.transform = isFocus ? .identity : CGAffineTransform(scaleX: Number.scale, y: Number.scale)
         }, completion: nil)
     }
}

// MARK: - UICollectionViewDataSource

extension MakeDotchiPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeDotchiUICollectionViewCell.className, for: indexPath) as? MakeDotchiUICollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.setData(luckyType: LuckyType(rawValue: indexPath.row + 1) ?? .lucky)
        
        self.zoomFocusCell(cell: cell, isFocus: self.isFirstScroll ? indexPath.row == 0 : false)
        self.isFirstScroll = false
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MakeDotchiPhotoViewController: UICollectionViewDelegateFlowLayout {
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

// MARK: - Layout

extension MakeDotchiPhotoViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, collectionView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(70)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(440)
        }
    }
}
