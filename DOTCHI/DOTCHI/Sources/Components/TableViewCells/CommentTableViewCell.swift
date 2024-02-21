//
//  CommentTableViewCell.swift
//  DOTCHI
//
//  Created by Jungbin on 2/21/24.
//

import UIKit

final class CommentTableViewCell: UITableViewCell {
    
    private enum Text {
        static let total = "총 행운"
        static let commentCenter = "님 저에게도 "
        static let commentTrail = "을 나눠 주세요!"
    }
    
    // MARK: UIComponents
    
    private let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameBackgroundView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .dotchiHgray
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.sSub, .dotchiWhite)
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.setStyle(.subSbold, .dotchiWhite)
        return label
    }()
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        DispatchQueue.main.async {
            self.usernameBackgroundView.makeRounded(cornerRadius: self.usernameBackgroundView.frame.height / 2)
            self.profileImageView.makeRounded(cornerRadius: self.profileImageView.frame.height / 2)
        }
    }
    
    func setData(data: CommentEntity, dotchiName: String, luckyType: LuckyType) {
        self.profileImageView.setImageUrl(data.profileImageUrl)
        self.usernameLabel.text = data.username
        self.commentLabel.text = dotchiName + Text.commentCenter + luckyType.nameWithHeart() + Text.commentTrail
        
        self.commentLabel.setColor(to: luckyType.nameWithHeart(), with: luckyType.uiColorNormal())
    }
}

// MARK: - Layout

extension CommentTableViewCell {
    private func setLayout() {
        self.usernameBackgroundView.addSubview(usernameLabel)
        self.contentView.addSubviews([profileImageView, usernameBackgroundView, commentLabel])
        
        self.profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(28)
            make.verticalEdges.equalToSuperview().inset(10)
            make.width.equalTo(self.profileImageView.snp.height)
        }
        
        self.usernameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview().inset(4)
        }
        
        self.usernameBackgroundView.snp.makeConstraints { make in
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(8)
            make.top.equalTo(self.profileImageView.snp.top)
        }
        
        self.commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(28)
            make.bottom.equalTo(self.profileImageView.snp.bottom)
        }
    }
}
