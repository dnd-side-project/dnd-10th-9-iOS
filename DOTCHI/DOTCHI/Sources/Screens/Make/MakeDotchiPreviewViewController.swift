//
//  MakeDotchiPreviewViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/21/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MakeDotchiPreviewViewController: BaseViewController {
    
    private enum Text {
        static let title = "따봉도치 만들기"
        static let upload = "따봉도치 올리기"
        static let info = "카드를 탭해서 뒤집어 보세요"
    }
    
    // MARK: UIComponents
    
    private let navigationView: DotchiNavigationUIView = {
        let view: DotchiNavigationUIView = DotchiNavigationUIView(type: .backCenterTitle)
        view.centerTitleLabel.text = Text.title
        return view
    }()
    
    private let cardBackgroundView: UIView = UIView()
    private let cardFrontView: CardFrontUIView = CardFrontUIView()
    private let cardBackView: CardBackUIView = CardBackUIView()
    
    private let infoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.sub, .dotchiWhite.withAlphaComponent(0.5))
        label.text = Text.info
        label.textAlignment = .center
        return label
    }()
    
    private let uploadButton: DotchiDoneUIButton = {
        let button: DotchiDoneUIButton = DotchiDoneUIButton()
        button.setTitle(Text.upload, for: .normal)
        return button
    }()
    
    // MARK: Properties
    
    private var makeDotchiData: MakeDotchiEntity = MakeDotchiEntity()
    private let disposeBag: DisposeBag = DisposeBag()
    
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
        self.setTapGesture()
        self.setData(makeDotchiData: self.makeDotchiData)
        self.setUploadButtonAction()
    }
    
    // MARK: Methods
    
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
    
    private func setData(makeDotchiData: MakeDotchiEntity) {
        self.cardFrontView.setData(makeDotchiData: makeDotchiData)
        self.cardBackView.setData(makeDotchiData: makeDotchiData)
    }
    
    private func setUploadButtonAction() {
        self.uploadButton.setAction { [weak self] in
            self?.postCard(data: self?.makeDotchiData ?? .init(), completion: {
                self?.dismiss(animated: true)
            })
        }
    }
}

// MARK: - Network

extension MakeDotchiPreviewViewController {
    private func postCard(data: MakeDotchiEntity, completion: @escaping () -> (Void)) {
        CardService.shared.postCard(data: data.toPostCardRequestData()) { networkResult in
            switch networkResult {
            case .success:
                completion()
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
}

// MARK: - Layout

extension MakeDotchiPreviewViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, cardBackgroundView, infoLabel, uploadButton])
        self.cardBackgroundView.addSubviews([cardBackView, cardFrontView])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.cardBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(271.adjustedH)
            make.height.equalTo(400.adjustedH)
        }
        
        self.cardFrontView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.cardBackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.infoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cardBackgroundView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
        
        self.uploadButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().inset(32)
        }
    }
}
