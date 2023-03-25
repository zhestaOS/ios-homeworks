//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Евгения Шевякова on 13.12.2021.
//

import UIKit
import SnapKit

final class ProfileTableHeaderView: UIView {
    
    private enum Constants {
        static let spacing: CGFloat = 16
        static let closeButtonSize: CGFloat = 20
    }
    
    // MARK: - Properties
    
    private var statusText: String?
    
    private let backView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.alpha = 0
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.frame = CGRect(
            x: UIScreen.main.bounds.width - Constants.spacing - Constants.closeButtonSize,
            y: Constants.spacing,
            width: Constants.closeButtonSize,
            height: Constants.closeButtonSize
        )
        button.alpha = 0
        
        return button
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "hipsterCat")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont(name: "Avenir Next", size: 14)
        
        return label
    }()
    
    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont(name: "Avenir Next", size: 15)
        textField.layer.cornerRadius = 14
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 14, height: 0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    private let setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 14
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(setStatusButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(tapGesture(_:)))
        avatarImageView.addGestureRecognizer(recognizer)
        
        addSubviews()
        setConstraints()
        
        bringSubviewToFront(backView)
        bringSubviewToFront(avatarImageView)
        bringSubviewToFront(closeButton)
        
        backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func update(user: User) {
        usernameLabel.text = user.name
        avatarImageView.image = user.avatar
        statusLabel.text = user.status
    }
    
    private func addSubviews() {
        addSubviews(
            backView,
            avatarImageView,
            usernameLabel,
            statusLabel,
            setStatusButton,
            statusTextField
        )
        backView.addSubview(closeButton)
    }
    
    private func setConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Constants.spacing)
            make.width.height.equalTo(100)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Constants.spacing)
            make.trailing.equalToSuperview().offset(-Constants.spacing)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Constants.spacing)
            make.trailing.equalToSuperview().offset(-Constants.spacing)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Constants.spacing)
            make.trailing.equalToSuperview().offset(-Constants.spacing)
            make.height.equalTo(40)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(statusTextField.snp.bottom).offset(Constants.spacing)
            make.leading.trailing.bottom.equalToSuperview().inset(Constants.spacing)
            make.height.equalTo(50)
        }
    }
    
    @objc
    func setStatusButtonTapped() {
        statusLabel.text = statusText
    }
    
    @objc
    func closeButtonTapped() {
        hideImageViewAnimation()
    }
    
    @objc
    func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }
    
    @objc
    func tapGesture(_ gesture: UITapGestureRecognizer) {
        showImageViewAnimation()
    }
    
    private func showImageViewAnimation() {
        guard
            let midX = superview?.bounds.midX,
            let midY = superview?.bounds.midY,
            let superWidth = superview?.bounds.width
        else { return }
        
        let superviewCenter = CGPoint(x: midX, y: midY)
        
        UIView.animateKeyframes(
            withDuration: 0.8,
            delay: 0,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.5) {
                        self.backView.alpha = 1

                        self.avatarImageView.center = superviewCenter
                        self.avatarImageView.layer.bounds.size.width = superWidth
                        self.avatarImageView.layer.bounds.size.height = superWidth
                        self.avatarImageView.layer.cornerRadius = 0
                    }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.5,
                    relativeDuration: 0.3) {
                        self.closeButton.alpha = 1
                    }
            },
            completion: nil)
    }
    
    private func hideImageViewAnimation() {

        UIView.animateKeyframes(
            withDuration: 0.8,
            delay: 0,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.3) {
                        self.closeButton.alpha = 0
                    }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.3,
                    relativeDuration: 0.5) {
                        self.backView.alpha = 0
                        
                        self.avatarImageView.frame = CGRect(x: Constants.spacing, y: Constants.spacing, width: 100, height: 100)
                        self.avatarImageView.layer.cornerRadius = 50

                    }
            },
            completion: nil)
    }
    
}
