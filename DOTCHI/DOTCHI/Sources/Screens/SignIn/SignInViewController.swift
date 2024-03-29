//
//  SignInViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/22/24.
//

import UIKit
import SwiftUI
import SnapKit
import KeychainSwift

final class SignInViewController: BaseViewController {
    
    private enum Text {
        static let title = "따봉도치야 고마워!\n나만의 따봉도치로 주고받는 행운"
        static let signInInfo = "간편하게 로그인하고 따봉도치를 이용해 보세요!"
    }
    
    // MARK: UIComponents
    
    private let logoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: .imgDotchiLogo)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Text.title
        label.numberOfLines = 2
        label.setStyle(.body, .dotchiWhite)
        return label
    }()
    
    private let signInInfoLabel: UILabel  = {
        let label: UILabel = UILabel()
        label.text = Text.signInInfo
        label.setStyle(.sSub, .dotchiWhite)
        label.textAlignment = .center
        return label
    }()
    
    private let signInAppleButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(.imgSignInApple, for: .normal)
        return button
    }()
    
    // MARK: Properties
    
    private let keychainManager: KeychainSwift = KeychainSwift()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
        self.setSignInAppleButtonAction()
    }
    
    // MARK: Methods
    
    private func setSignInAppleButtonAction() {
        self.signInAppleButton.setAction { [weak self] in
            if !(UserDefaultsManager.isSigned ?? false) {
                self?.requestSignIn(data: .init(memberId: 2), completion: { response in
                    self?.setUserDataToKeychain(data: response)
                    self?.setUserDataToUserInfo(data: response)
                    UserDefaultsManager.isSigned = true
                    self?.presentContentView()
                })
            } else {
                if let userData = self?.getUserDataFromKeychain() {
                    self?.setUserDataToUserInfo(data: userData)
                }
                self?.presentContentView()
            }
        }
    }
    
    private func setUserDataToKeychain(data: SignInResponseDTO) {
        self.keychainManager.set(data.accessToken, forKey: KeychainKeys.accessToken.rawValue)
        self.keychainManager.set("\(data.memberID)", forKey: KeychainKeys.userID.rawValue)
        self.keychainManager.set(data.memberName, forKey: KeychainKeys.username.rawValue)
        self.keychainManager.set(data.memberImageURL, forKey: KeychainKeys.profileImageUrl.rawValue)
    }
    
    private func getUserDataFromKeychain() -> SignInResponseDTO {
        return .init(
            memberID: Int(self.keychainManager.get(KeychainKeys.userID.rawValue) ?? "") ?? 0,
            memberName: self.keychainManager.get(KeychainKeys.username.rawValue) ?? "",
            memberImageURL: self.keychainManager.get(KeychainKeys.profileImageUrl.rawValue) ?? "",
            accessToken: self.keychainManager.get(KeychainKeys.accessToken.rawValue) ?? ""
        )
    }
    
    private func setUserDataToUserInfo(data: SignInResponseDTO) {
        UserInfo.shared.userID = data.memberID
        UserInfo.shared.username = data.memberName
        UserInfo.shared.profileImageUrl = data.memberImageURL
        UserInfo.shared.accessToken = data.accessToken
    }
    
    private func presentContentView() {
        debugPrint("accessToken", self.keychainManager.get(KeychainKeys.accessToken.rawValue) ?? "None")
        let contentView: ContentView = ContentView()
        let hostingController = UIHostingController(rootView: contentView)
        hostingController.modalPresentationStyle = .fullScreen
        self.present(hostingController, animated: true, completion: nil)
    }
}

// MARK: - Network

extension SignInViewController {
    private func requestSignIn(data: SignInRequestDTO, completion: @escaping (SignInResponseDTO) -> (Void)) {
        AuthService.shared.requestSignIn(data: data) { networkResult in
            switch networkResult {
            case .success(let responseData):
                if let result = responseData as? SignInResponseDTO {
                    completion(result)
                } else { debugPrint(responseData) }
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
}

// MARK: - Layout

extension SignInViewController {
    private func setLayout() {
        self.view.addSubviews([logoImageView, titleLabel, signInAppleButton, signInInfoLabel])
        
        self.logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200.adjustedH)
            make.width.equalTo(225)
            make.height.equalTo(97)
            make.leading.equalToSuperview().inset(45)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(45)
            make.height.equalTo(54)
        }
        
        self.signInAppleButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(200.adjustedH)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(self.signInAppleButton.snp.width).multipliedBy(0.154302)
        }
        
        self.signInInfoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.signInAppleButton.snp.top).offset(-16)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(12)
        }
    }
}
