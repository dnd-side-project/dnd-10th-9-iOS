//
//  MakeDotchiContentViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/20/24.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class MakeDotchiContentViewController: BaseViewController {
    
    private enum Text {
        static let title = "따봉도치 만들기"
        static let next = "다음"
        static let dotchiNameInfo = "따봉네임 (7자)"
        static let dotchiNameGuide = "나는"
        static let dotchiNamePlaceholder = "Ex) 따봉도치"
        static let dotchiMoodInfo = "따봉도치의 컨디션 (15자)"
        static let dotchiMoodGuide = "나는 오늘 좀"
        static let dotchiMoodPlaceholder = "Ex) 엄지가 절로 올라가"
        static let dotchiContentInfo = "자유롭게 따봉도치 디테일을 적어 보세요 (20자)"
        static let dotchiContentPlaceholder = "Ex) 넌 지금 따봉도치와 눈이 마주쳤어!"
        static let luckyDescriptionHead = "나를 만난 너에게 "
        static let luckyDescriptionTrail = "을 나눠 줄게!"
    }
    
    // MARK: UIComponents
    
    private let navigationView: DotchiNavigationUIView = {
        let view: DotchiNavigationUIView = DotchiNavigationUIView(type: .backCenterTitle)
        view.centerTitleLabel.text = Text.title
        return view
    }()
    
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    
    private let dotchiNameInfoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.sub, .dotchiWhite.withAlphaComponent(0.5))
        label.text = Text.dotchiNameInfo
        return label
    }()
    
    private let dotchiNameGuideLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.body, .dotchiWhite)
        label.text = Text.dotchiNameGuide
        return label
    }()
    
    private let dotchiNameTextField: DotchiUITextField = {
        let textField: DotchiUITextField = DotchiUITextField()
        textField.setDotchiPlaceholder(Text.dotchiNamePlaceholder)
        return textField
    }()
    
    private let dotchiMoodInfoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.sub, .dotchiWhite.withAlphaComponent(0.5))
        label.text = Text.dotchiMoodInfo
        return label
    }()
    
    private let dotchiMoodGuideLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.body, .dotchiWhite)
        label.text = Text.dotchiMoodGuide
        return label
    }()
    
    private let dotchiMoodTextField: DotchiUITextField = {
        let textField: DotchiUITextField = DotchiUITextField()
        textField.setDotchiPlaceholder(Text.dotchiMoodPlaceholder)
        return textField
    }()
    
    private let dotchiContentInfoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.sub, .dotchiWhite.withAlphaComponent(0.5))
        label.text = Text.dotchiContentInfo
        return label
    }()
    
    private let dotchiContentTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.backgroundColor = .dotchiMgray
        textView.font = .head2
        textView.textColor = .dotchiLgray
//        textView.text = Text.dotchiContentPlaceholder
        textView.textContainerInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        textView.contentInset = .zero
        textView.textContainer.lineFragmentPadding = .zero
        textView.makeRounded(cornerRadius: 8)
        return textView
    }()
    
    private let dotchiContentPlaceholderLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.head2, .dotchiWhite.withAlphaComponent(0.3))
        label.text = Text.dotchiContentPlaceholder
        return label
    }()
    
    private let luckyDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.body, .dotchiWhite)
        return label
    }()
    
    private let nextButton: DotchiDoneUIButton = {
        let button: DotchiDoneUIButton = DotchiDoneUIButton()
        button.setTitle(Text.next, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    // MARK: Properties
    
    private var makeDotchiData: MakeDotchiEntity = MakeDotchiEntity()
    private var keyboardHeight: CGFloat = 0
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
        self.setLuckyDescriptionLabel()
        self.setDotchiNameTextField()
        self.setDotchiMoodTextField()
        self.setDotchiContentTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addKeyboardObserver(willShow: #selector(self.keyboardWillShow(_:)), willHide: #selector(self.keyboardWillHide(_:)))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.removeKeyboardObserver()
    }
    
    // MARK: Methods
    
    private func setLuckyDescriptionLabel() {
        self.luckyDescriptionLabel.text = Text.luckyDescriptionHead + self.makeDotchiData.luckyType.name() + Text.luckyDescriptionTrail
        self.luckyDescriptionLabel.setColor(to: self.makeDotchiData.luckyType.name(), with: self.makeDotchiData.luckyType.uiColorNormal())
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
            if self.dotchiNameTextField.isEditing {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: self.dotchiNameInfoLabel.frame.minY - 10), animated: true)
            } else if self.dotchiMoodTextField.isEditing {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: self.dotchiMoodInfoLabel.frame.minY - 10), animated: true)
            } else {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: self.dotchiContentInfoLabel.frame.minY - 10), animated: true)
            }
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        self.keyboardHeight = 0
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    
    private func setDotchiNameTextField() {
        self.dotchiNameTextField.rx.text
            .orEmpty
            .asDriver(onErrorJustReturn: "")
            .drive(with: self, onNext: { owner, changedText in
                if changedText.count > 7 {
                    owner.dotchiNameTextField.deleteBackward()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setDotchiMoodTextField() {
        self.dotchiMoodTextField.rx.text
            .orEmpty
            .asDriver(onErrorJustReturn: "")
            .drive(with: self, onNext: { owner, changedText in
                if changedText.count > 15 {
                    owner.dotchiMoodTextField.deleteBackward()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setDotchiContentTextView() {
        self.dotchiContentTextView.rx.text
            .orEmpty
            .distinctUntilChanged()
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { (owner, changedText) in
                self.dotchiContentPlaceholderLabel.isHidden = changedText.count > 0
                if changedText.count > 20 {
                    self.dotchiContentTextView.deleteBackward()
                }
                
                if changedText.isSubstringRepeatedTwice("\n") {
                    self.dotchiContentTextView.deleteBackward()
                }
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Layout

extension MakeDotchiContentViewController {
    private func setLayout() {
        self.view.addSubviews([navigationView, scrollView, nextButton])
        self.scrollView.addSubviews([contentView])
        self.contentView.addSubviews([
            dotchiNameInfoLabel, dotchiNameGuideLabel, dotchiNameTextField,
            dotchiMoodInfoLabel, dotchiMoodGuideLabel, dotchiMoodTextField,
            dotchiContentInfoLabel, dotchiContentTextView, dotchiContentPlaceholderLabel,
            luckyDescriptionLabel
        ])
        
        self.navigationView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        self.dotchiNameInfoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(14)
        }
        
        self.dotchiNameGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiNameInfoLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(22)
        }
        
        self.dotchiNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiNameGuideLabel.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(40)
        }
        
        self.dotchiMoodInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiNameTextField.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(14)
        }
        
        self.dotchiMoodGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiMoodInfoLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(22)
        }
        
        self.dotchiMoodTextField.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiMoodGuideLabel.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(40)
        }
        
        self.dotchiContentInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiMoodTextField.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(14)
        }
        
        self.dotchiContentTextView.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiContentInfoLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(104)
        }
        
        self.dotchiContentPlaceholderLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.dotchiContentTextView).inset(12)
            make.trailing.equalTo(self.dotchiContentTextView).inset(12)
        }
        
        self.luckyDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dotchiContentTextView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(22)
            make.bottom.equalToSuperview().inset(32)
        }
        
        self.nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().inset(32)
        }
    }
}
