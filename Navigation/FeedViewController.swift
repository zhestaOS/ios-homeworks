//
//  FeedViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 01.12.2021.
//

import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: - Properties
        
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.toAutoLayout()
        
        return stackView
    }()
    
    private let firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("First button", for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 14
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(transitionButtonTapped), for: .touchUpInside)
        button.toAutoLayout()
        
        return button
    }()
    
    private let secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Second button", for: .normal)
        button.backgroundColor = .systemTeal
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 14
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(transitionButtonTapped), for: .touchUpInside)
        button.toAutoLayout()
        
        return button
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        view.addSubviews(
            stackView,
            firstButton,
            secondButton
        )

        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            firstButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            firstButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            firstButton.heightAnchor.constraint(equalToConstant: 50),
            
            secondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            secondButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    func transitionButtonTapped() {
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
