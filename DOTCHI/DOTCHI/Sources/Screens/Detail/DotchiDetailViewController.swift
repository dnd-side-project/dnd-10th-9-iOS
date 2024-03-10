//
//  DotchiDetailViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/21/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class DotchiDetailViewController: BaseViewController {
    
    private enum Text {
        static let total = "총 행운 "
        static let commentCenter = "님 저에게도 "
        static let commentTrail = "을 나눠 주세요!"
    }
    
    // MARK: UIComponents
    
    private let navigationView: DotchiNavigationUIView = {
        let view: DotchiNavigationUIView = DotchiNavigationUIView(type: .closeMore)
        return view
    }()
    
    private let cardBackgroundView: UIView = UIView()
    private let cardFrontView: CardFrontUIView = CardFrontUIView()
    private let cardBackView: CardBackUIView = CardBackUIView()
    var browseViewController: BrowseViewController?
    
    private let commentBackgroundView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .dotchiMgray
        view.makeRounded(cornerRadius: 25)
        return view
    }()
    
    private let totalLuckyLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.head2, .dotchiWhite)
        label.text = Text.total
        return label
    }()
    
    private let commentTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let commentButton: DotchiDoneUIButton = {
        let button: DotchiDoneUIButton = DotchiDoneUIButton()
        return button
    }()
    
    // MARK: Properties
    
    private var cardId: Int = 0
    private var luckyType: LuckyType = .lucky
    private let disposeBag: DisposeBag = DisposeBag()
    private var comments: CommentsEntity = []
    private var user: CardUserEntity = CardUserEntity()
    private var card: CardEntity?
    
    // MARK: Initializer
    
    init(cardId: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.cardId = cardId
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setCloseButtonAction(self.navigationView.closeButton)
        self.setCommentTableView()
        self.setTapGesture()
        self.setMoreButtonAction()
        self.fetchData()
        self.setCommentButtonAction()
    }
    
    // MARK: Methods
    
    private func setCommentTableView() {
        self.commentTableView.delegate = self
        self.commentTableView.dataSource = self
        self.commentTableView.register(cell: CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.className)
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.rx.event
            .bind { [weak self] _ in
                self?.flipCard()
            }
            .disposed(by: self.disposeBag)
        
        self.cardBackgroundView.addGestureRecognizer(tapGesture)
    }
    
    private func flipCard() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if !self.cardFrontView.isHidden {
                UIView.transition(from: self.cardFrontView, to: self.cardBackView, duration: 0.5, options: transitionOptions)
            } else {
                UIView.transition(from: self.cardBackView, to: self.cardFrontView, duration: 0.5, options: transitionOptions)
            }
        }
    }
    
    private func setData(data: CardEntity) {
        self.card = data
        self.cardFrontView.setData(frontData: data.front, userData: data.user)
        self.cardBackView.setCommentViewData(backData: data.back, userData: data.user)
        self.commentButton.setTitle(data.front.dotchiName + Text.commentCenter + data.front.luckyType.nameWithHeart() + Text.commentTrail, for: .normal)
        self.totalLuckyLabel.text = Text.total + "\(self.comments.count)"
        
        
        self.totalLuckyLabel.setColor(to: "\(self.comments.count)", with: data.front.luckyType.uiColorNormal())
        self.commentButton.setBackgroundColor(data.front.luckyType.uiColorNormal(), for: .normal)
        self.commentButton.setBackgroundColor(data.front.luckyType.uiColorNormal().withAlphaComponent(0.5), for: .disabled)
        self.commentButton.titleLabel?.font = .button
    }
    
    private func setMoreButtonAction() {
        self.navigationView.moreButton.setAction { [weak self] in
            self?.openMoreButtonActionSheet()
        }
    }
    
    private func openMoreButtonActionSheet() {
        let actionSheet: UIAlertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        if UserInfo.shared.userID != self.user.userId {
            actionSheet.addAction(
                UIAlertAction(
                    title: "차단하기",
                    style: .default,
                    handler: { _ in
                        self.makeAlertWithCancel(
                            title: "\(self.user.username) 님을 차단합니다.",
                            message: nil,
                            okTitle: "차단") { _ in
                                self.requestBlockUser(userId: self.user.userId) {
                                    self.dismiss(animated: true)
                                }
                            }
                    }
                )
            )
            
            actionSheet.addAction(
                UIAlertAction(
                    title: "신고하기",
                    style: .default,
                    handler: { _ in
                        self.makeAlertWithCancel(
                            title: "\(self.user.username) 님을 신고합니다.",
                            okTitle: "신고") { _ in
                                self.present(self.reportActionSheet(userId: self.user.userId), animated: true)
                            }
                    }
                )
            )
        }
        
        if UserInfo.shared.userID == self.user.userId {
            actionSheet.addAction(
                UIAlertAction(
                    title: "삭제하기",
                    style: .destructive,
                    handler: { _ in
                        self.makeAlertWithCancel(
                            title: "정말 삭제할까요?",
                            okTitle: "삭제") { _ in
                                self.deleteCard()
                            }
                    }
                )
            )
        }
        
        actionSheet.addAction(
            UIAlertAction(
                title: "취소",
                style: .cancel,
                handler: nil
            )
        )
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func setCommentButtonAction() {
        self.commentButton.setAction { [weak self] in
            self?.postComment()
        }
    }
}

// MARK: - UITableViewDataSource

extension DotchiDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.className, for: indexPath) as? CommentTableViewCell 
        else { return UITableViewCell() }
        
        cell.setData(data: self.comments[indexPath.row], dotchiName: self.card?.front.dotchiName ?? "따봉도치", luckyType: self.luckyType)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DotchiDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.commentTableView.frame.height / 3
    }
}

// MARK: - Network

extension DotchiDetailViewController {
    private func fetchData() {
        CardService.shared.getComments(cardId: self.cardId) { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? GetCommentsResponseDTO {
                    self.comments = result.comments.map({ comment in
                        comment.toCommentEntity()
                    })
                    self.user = result.card.toCardUserEntity()
                    self.luckyType = LuckyType(rawValue: result.card.themeID) ?? .lucky
                    self.commentButton.isEnabled = !result.hasComment
                    self.commentTableView.reloadData()
                    
                    self.setData(
                        data: CardEntity(
                            user: result.card.toCardUserEntity(),
                            front: result.card.toCardFrontEntity(),
                            back: result.card.toCardBackEntity()
                        )
                    )
                }
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
    
    private func postComment() {
        CardService.shared.postComment(cardId: self.cardId) { networkResult in
            switch networkResult {
            case .success:
                self.fetchData()
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
    
    private func deleteCard() {
        CardService.shared.deleteCard(cardId: self.cardId) { networkResult in
            switch networkResult {
            case .success:
                self.dismiss(animated: true) {
                    self.browseViewController?.resetAndFetchData()
                }
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
}

// MARK: - Layout

extension DotchiDetailViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, cardBackgroundView, commentBackgroundView, totalLuckyLabel, commentButton, commentTableView])
        self.cardBackgroundView.addSubviews([cardBackView, cardFrontView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.cardBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(248.adjustedH)
            make.height.equalTo(366.adjustedH)
        }
        
        self.cardFrontView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.cardBackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.commentBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.cardBackgroundView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(25)
        }
        
        self.totalLuckyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.commentBackgroundView).inset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        
        self.commentButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(32)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(52)
        }
        
        self.commentTableView.snp.makeConstraints { make in
            make.top.equalTo(self.totalLuckyLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.commentButton.snp.top).offset(-16)
        }
    }
}
