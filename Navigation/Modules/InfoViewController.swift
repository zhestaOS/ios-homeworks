//
//  InfoViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 02.12.2021.
//

import UIKit

final class InfoViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var toDoTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var alertButton: CustomButton = {
        let button = CustomButton(title: "Предупреждение",
                                  сolorOfBackground: .systemGreen) {
            self.alertButtonTapped()
        }
        return button
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews()
        setConstraints()
        
        toDo { toDoText, errorText in
            DispatchQueue.main.async {
                if let errorText {
                    print(errorText)
                    self.toDoTextLabel.text = "Something went wrong"
                } else if let toDoText {
                    self.toDoTextLabel.text = toDoText
                }
            }
        }
    }
    
    // MARK: - Methods
    
    
    private func addSubviews() {
        view.addSubview(alertButton)
        view.addSubview(toDoTextLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            toDoTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toDoTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            alertButton.topAnchor.constraint(equalTo: toDoTextLabel.bottomAnchor, constant: 16),
            alertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            alertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            alertButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    func alertButtonTapped() {
        let alertController = UIAlertController(title: "Предупреждение", message: "Вы уверены, что хотите продолжить?", preferredStyle: .alert)
        let yesAlert = UIAlertAction(title: "Да", style: .default) { action in
            print("Да, я хочу продолжить")
        }
        let noAlert = UIAlertAction(title: "Нет", style: .default) { action in
            print("Нет, я не хочу продолжать")
        }
        
        alertController.addAction(yesAlert)
        alertController.addAction(noAlert)

        present(alertController, animated: true)
        
    }
}
