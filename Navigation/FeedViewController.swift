//
//  FeedViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 01.12.2021.
//

import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: - Properties
    
    private let feedModel = FeedModel.shared
        
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.toAutoLayout()
        
        return stackView
    }()
    
    private let firstButton = CustomButton(
        title: "First button",
        сolorOfBackground: .systemGreen
    )
    
    private let secondButton = CustomButton(
        title: "Second button",
        сolorOfBackground: .systemTeal
    )
    
    private let checkGuessButton = CustomButton(
        title: "Check guess",
        сolorOfBackground: .systemOrange
    )
    
    private var guessText: String?
    
    private let checkGuessTextField: UITextField = {
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
        textField.addTarget(self, action: #selector(guessChecked(_:)), for: .editingChanged)

        return textField
    }()
    
    private let checkGuessLabel: UILabel = {
        let label = UILabel()
        label.text = "The result will be here"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        
        return label
    }()
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
        
        firstButton.tapAction = {
            self.transitionButtonTapped()
        }
        secondButton.tapAction = {
            self.transitionButtonTapped()
        }
        checkGuessButton.tapAction = {
            self.checkGuessButtonTapped()
        }
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        view.addSubviews(
            stackView,
            firstButton,
            secondButton,
            checkGuessButton,
            checkGuessTextField,
            checkGuessLabel
        )

        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.addArrangedSubview(checkGuessTextField)
        stackView.addArrangedSubview(checkGuessLabel)
        stackView.addArrangedSubview(checkGuessButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            firstButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            firstButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            firstButton.heightAnchor.constraint(equalToConstant: 50),
            
            secondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            secondButton.heightAnchor.constraint(equalToConstant: 50),
            
            checkGuessTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            checkGuessTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkGuessTextField.heightAnchor.constraint(equalToConstant: 50),
            
            checkGuessLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            checkGuessLabel.heightAnchor.constraint(equalToConstant: 25),
            
            checkGuessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    func transitionButtonTapped() {
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func checkGuessButtonTapped() {
        if feedModel.check(word: guessText) {
            checkGuessLabel.text = "Right!"
            checkGuessLabel.textColor = .green
        } else {
            checkGuessLabel.text = "Wrong"
            checkGuessLabel.textColor = .red
        }
    }
    
    @objc
    func guessChecked(_ textField: UITextField) {
        guessText = textField.text
    }
}
