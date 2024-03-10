//
//  BaseViewController.swift
//  DOTCHI
//
//  Created by Jungbin on 2/5/24.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private enum Text {
        static let cancel = "취소하기"
    }
    
    // MARK: UIComponents
    
    
    
    // MARK: Properties
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let reportReasons: [String] = ["유해한 콘텐츠", "스팸/홍보", "도배", "도용", "기타"]
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackgroundColor()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: Methods
    
    /// 모든 뷰의 기본 Background color 설정
    private func setBackgroundColor() {
        self.view.backgroundColor = .dotchiBlack
    }
    
    /// BackButton에 pop Action을 간편하게 주는 메서드.
    /// - 필요 시 override하여 사용
    @objc
    func setBackButtonAction(_ button: UIButton) {
        button.setAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    /// CloseButton에 dismiss Action을 간편하게 주는 메서드.
    /// - 필요 시 override하여 사용
    @objc
    func setCloseButtonAction(_ button: UIButton) {
        button.setAction { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    /// 화면 터치 시 키보드 내리는 메서드
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func showNetworkErrorAlert() {
        self.makeAlert(title: Message.networkError.text)
    }
    
    /// 신고 사유 선택 action sheet
    func reportActionSheet(userId: Int) -> UIAlertController {
        let reportActionSheet: UIAlertController = UIAlertController(
            title: "신고 사유를 선택해 주세요.",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        var reportUserRequestDTO: ReportUserRequestDTO = ReportUserRequestDTO()
        
        self.reportReasons.forEach { reason in
            reportActionSheet.addAction(
                UIAlertAction(
                    title: reason,
                    style: .default,
                    handler: { action in
                        reportUserRequestDTO.reason = reason
                        self.requestReportUser(userId: userId, data: reportUserRequestDTO) {
                            self.makeAlert(title: "", message: Message.completedReport.text)
                        }
                    }
                )
            )
        }
        
        reportActionSheet.addAction(
            UIAlertAction(
                title: Text.cancel,
                style: .cancel
            )
        )
        
        return reportActionSheet
    }
}

// MARK: - Network

extension BaseViewController {
    
    /// 유저 차단
    func requestBlockUser(userId: Int, completion: @escaping () -> ()) {
        MemberService.shared.blockUser(userId: userId) { networkResult in
            switch networkResult {
            case .success:
                completion()
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
    
    /// 유저 신고
    func requestReportUser(userId: Int, data: ReportUserRequestDTO, completion: @escaping () -> ()) {
        MemberService.shared.reportUser(userId: userId, data: data) { networkResult in
            switch networkResult {
            case .success:
                completion()
            default:
                self.showNetworkErrorAlert()
            }
        }
    }
}
