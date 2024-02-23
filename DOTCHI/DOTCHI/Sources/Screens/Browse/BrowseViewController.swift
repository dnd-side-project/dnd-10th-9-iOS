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
    
    private let instagramShareView: InstagramShareUIView = InstagramShareUIView(frame: CGRect(x: 0, y: 0, width: 570, height: 424))
    
    // MARK: Properties
    
    private var cards: [CardEntity] = []
    private var previousCellIndex: Int = 0
    private var currentCellIndex: Int = 0
    private var isLoadingData: Bool = false
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
        self.setButtonToggle()
        self.fetchData(
            isLatest: self.latestButton.isSelected,
            lastCardId: self.cards.last?.front.cardId ?? APIConstants.pagingDefaultValue,
            lastCommentCount: self.cards.last?.commentsCount ?? APIConstants.pagingDefaultValue
        )
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
                self?.cards = []
                self?.collectionView.reloadData()
                self?.fetchData(
                    isLatest: self?.latestButton.isSelected ?? true,
                    lastCardId: self?.cards.last?.front.cardId ?? APIConstants.pagingDefaultValue,
                    lastCommentCount: self?.cards.last?.commentsCount ?? APIConstants.pagingDefaultValue
                )
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
    
    private func shareInstagram(data: CardEntity) {
        self.instagramShareView.setData(data: data)
        
        if let storiesUrl = URL(string: "instagram-stories://share?source_application=\(APIConstants.facebookAppId)") {
            if UIApplication.shared.canOpenURL(storiesUrl) {
                let imageData = self.instagramShareView.toUIImage().png()
                let pasteboardItems: [String: Any] = [
                    "com.instagram.sharedSticker.stickerImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor": UIColor.dotchiBlack.toHexString(),
                    "com.instagram.sharedSticker.backgroundBottomColor": UIColor.dotchiBlack.toHexString()
                ]
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)
                ]
                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
            } else {
                print("User doesn't have instagram on their device.")
                if let openStore = URL(string: "itms-apps://itunes.apple.com/app/instagram/id389801252"), UIApplication.shared.canOpenURL(openStore) {
                    UIApplication.shared.open(openStore, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    private func makeGetAllCardsRequestData(isLatest: Bool, lastCardId: Int, lastCommentCount: Int) -> GetAllCardsRequestDTO {
        return GetAllCardsRequestDTO(
            cardSortType: (isLatest ? CardSortType.latest : CardSortType.hot).rawValue,
            lastCardID: lastCardId,
            lastCardCommentCount: lastCommentCount
        )
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
            self?.present(DotchiDetailViewController(cardId: self?.cards[indexPath.row].front.cardId ?? 0), animated: true)
        }
        
        cell.shareButton.removeTarget(nil, action: nil, for: .touchUpInside)
        cell.shareButton.setAction { [weak self] in
            if let card = self?.cards[indexPath.row] {
                self?.shareInstagram(data: card)
            }
        }
        
        self.zoomFocusCell(cell: cell, isFocus: indexPath.row == self.currentCellIndex)
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
        self.currentCellIndex = Int(roundedIndex)
        
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width
        
        if offsetX > contentWidth - scrollView.frame.width {
            self.fetchData(
                isLatest: self.latestButton.isSelected,
                lastCardId: self.cards.last?.front.cardId ?? APIConstants.pagingDefaultValue,
                lastCommentCount: self.cards.last?.commentsCount ?? APIConstants.pagingDefaultValue
            )
        }
    }
}

// MARK: - Network

extension BrowseViewController {
    private func fetchData(isLatest: Bool, lastCardId: Int, lastCommentCount: Int) {
        guard !self.isLoadingData else { return }
        self.isLoadingData = true
        
        CardService.shared.getAllCards(data: self.makeGetAllCardsRequestData(isLatest: isLatest, lastCardId: lastCardId, lastCommentCount: lastCommentCount)) { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? GetAllCardsResponseDTO {
                    self.cards.append(contentsOf: result.cards.map({ card in
                        card.toCardEntity()
                    }))
                    
                    /// 최신순/인기순으로 불러올 때
                    if lastCardId == APIConstants.pagingDefaultValue {
                        self.currentCellIndex = 0
                        self.previousCellIndex = 0
                        self.collectionView.reloadData()
                        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                    }
                    
                    /// 페이징으로 다음 데이터 불러올 때
                    else {
                        self.collectionView.reloadData()
                    }
                }
            default:
                self.showNetworkErrorAlert()
            }
            self.isLoadingData = false
        }
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
