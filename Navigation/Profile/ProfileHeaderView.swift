//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Евгения Шевякова on 13.12.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let profileImageView: UIImageView
    let profileNameLabel: UILabel
    let profileStatusLabel: UILabel
    let showStatusButton: UIButton
    
    override init(frame: CGRect) {
        
        self.profileImageView = UIImageView(
            frame: CGRect(
                x: 16,
                y: 16,
                width: 100,
                height: 100
            )
        )
        
        self.profileNameLabel = UILabel(
            frame: CGRect(
                x: profileImageView.frame.origin.x + profileImageView.frame.width + 16,
                y: 27,
                width: 200,
                height: 20
            )
        )
        
        self.profileStatusLabel = UILabel(
            frame: CGRect(
                x: profileImageView.frame.origin.x + profileImageView.frame.width + 16,
                y: 80,
                width: 200,
                height: 20
            )
        )
        
        showStatusButton = UIButton(
            frame: CGRect(
                x: 16,
                y: profileImageView.frame.height + 32,
                width: UIScreen.main.bounds.size.width - 32,
                height: 50
            )
        )
        
        super.init(frame: frame)
        
        showStatusButton.addTarget(self, action: #selector(showStatusButtonTapped), for: .touchUpInside)
        
        addSubview(profileImageView)
        addSubview(profileNameLabel)
        addSubview(profileStatusLabel)
        addSubview(showStatusButton)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.image = UIImage(named: "hipsterCat")
        profileImageView.layer.masksToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        profileNameLabel.text = "Hipster Cat"
        profileNameLabel.textColor = .black
        profileNameLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)

        profileStatusLabel.text = "Waiting for something..."
        profileStatusLabel.textColor = .gray
        profileStatusLabel.font = UIFont(name: "Avenir Next", size: 14)

        showStatusButton.setTitle("Show status", for: .normal)
        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.titleLabel?.textColor = .white
        showStatusButton.layer.cornerRadius = 14
        showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatusButton.layer.shadowRadius = 4
        showStatusButton.layer.shadowColor = UIColor.black.cgColor
        showStatusButton.layer.shadowOpacity = 0.7
        
    }
    
    @objc
    func showStatusButtonTapped() {
        guard let text = profileStatusLabel.text else { return }
        print(text)
    }
    
}
