//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Евгения Шевякова on 13.12.2021.
//

import UIKit

final class ProfileTableHeaderView: UIView {
    
    private enum Constants {
        static let spacing: CGFloat = 16
    }
    
    private var statusText: String?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "hipsterCat")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.toAutoLayout()
        
        return label
    }()
    
    private let profileStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.toAutoLayout()
        
        return label
    }()
    
    private let profileStatusTextField: UITextField = {
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
        textField.toAutoLayout()
        
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
        button.toAutoLayout()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
        backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubviews(
            profileImageView,
            profileNameLabel,
            profileStatusLabel,
            setStatusButton,
            profileStatusTextField
        )
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.spacing),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            profileNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.spacing),
            profileNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.spacing),
            
            profileStatusLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 20),
            profileStatusLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.spacing),
            profileStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.spacing),
            
            profileStatusTextField.topAnchor.constraint(equalTo: profileStatusLabel.bottomAnchor, constant: 8),
            profileStatusTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.spacing),
            profileStatusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.spacing),
            profileStatusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.topAnchor.constraint(equalTo: profileStatusTextField.bottomAnchor, constant: Constants.spacing),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.spacing),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.spacing)
        ])
    }
    
    @objc
    func setStatusButtonTapped() {
        profileStatusLabel.text = statusText
    }
    
    @objc
    func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }
    
}
