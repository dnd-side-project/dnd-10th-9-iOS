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
        let view: DotchiNavigationUIView = DotchiNavigationUIView(type: .backMore)
        return view
    }()
    
    private let cardBackgroundView: UIView = UIView()
    private let cardFrontView: CardFrontUIView = CardFrontUIView()
    private let cardBackView: CardBackUIView = CardBackUIView()
    
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
        button.setTitle(Text.commentCenter, for: .normal)
        return button
    }()
    
    // MARK: Properties
    
    private let disposeBag: DisposeBag = DisposeBag()
    private var comments: CommentsEntity = [
        .init(userId: 1, username: "초코", profileImageUrl: "."),
        .init(userId: 2, username: "뽀송이", profileImageUrl: "."),
        .init(userId: 3, username: "냥냥", profileImageUrl: ".")
    ]
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setBackButtonAction(self.navigationView.backButton)
        self.setCommentTableView()
        self.setTapGesture()
        self.setMoreButtonAction()
        self.fetchData()
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
    
    private func setData(data: CardFrontEntity) {
        self.cardFrontView.setData(data: data)
        self.cardBackView.setCommentViewData(data: data)
        self.commentButton.setTitle(data.dotchiName + Text.commentCenter + data.luckyType.nameWithHeart() + Text.commentTrail, for: .normal)
        self.totalLuckyLabel.text = Text.total + "\(33)"
        
        
        self.totalLuckyLabel.setColor(to: "\(33)", with: data.luckyType.uiColorNormal())
        self.commentButton.setBackgroundColor(data.luckyType.uiColorNormal(), for: .normal)
        self.commentButton.setBackgroundColor(data.luckyType.uiColorNormal().withAlphaComponent(0.5), for: .disabled)
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
        
        actionSheet.addAction(
            UIAlertAction(
                title: "차단하기",
                style: .default,
                handler: { _ in
                    self.makeAlertWithCancel(
                        title: "\("오뜨") 님을 차단합니다.",
                        message: nil,
                        okTitle: "차단") { _ in
                            // TODO: block user
                            self.navigationController?.popViewController(animated: true)
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
                        title: "\("오뜨") 님을 신고합니다.",
                        okTitle: "신고") { _ in
                            // TODO: report user
                        }
                }
            )
        )
        
        // TODO: 내 카드인 경우
        actionSheet.addAction(
            UIAlertAction(
                title: "삭제하기",
                style: .destructive,
                handler: { _ in
                    self.makeAlertWithCancel(
                        title: "정말 삭제할까요?",
                        okTitle: "삭제") { _ in
                            // TODO: delete
                        }
                }
            )
        )
        
        actionSheet.addAction(
            UIAlertAction(
                title: "취소",
                style: .cancel,
                handler: nil
            )
        )
        
        self.present(actionSheet, animated: true, completion: nil)
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
        
        cell.setData(data: self.comments[indexPath.row], dotchiName: "따봉도치", luckyType: .love)
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
        // TODO: 더미데이터 빼고 API 연결
        self.setData(data: .init(cardId: 0, imageUrl: ".", luckyType: .love, user: .init(userId: 0, profileImageUrl: ".", username: "오뜨"), dotchiName: "따봉도치"))
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
