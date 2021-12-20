//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Евгения Статива on 28.11.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeader: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me", for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.textColor = .white
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(profileHeader)
        view.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            profileHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeader.heightAnchor.constraint(equalToConstant: 220),
            
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        title = "Profile"
        
        navigationController?.navigationBar.isTranslucent = false
     
    }
}
