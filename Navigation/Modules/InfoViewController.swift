//
//  InfoViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 02.12.2021.
//

import UIKit

final class InfoViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.toAutoLayout()
        
        return stackView
    }()
    
    private lazy var alertButton: CustomButton = {
        let button = CustomButton(title: "Предупреждение",
                                  сolorOfBackground: .systemGreen) {
            self.alertButtonTapped()
        }
        return button
    }()
    
    private lazy var toDoTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var planetOrbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.toAutoLayout()
        
        return label
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews()
        setConstraints()
        
        getPlanetInfo { name, orbitalPeriod, errorText in
            DispatchQueue.main.async {
                if let errorText {
                    print(errorText)
                    self.planetOrbitalPeriodLabel.text = "Something went wrong"
                } else if let name = name, let orbitalPeriod = orbitalPeriod {
                    self.planetOrbitalPeriodLabel.text = "\(name) orbital period: \(orbitalPeriod)"
                }
            }
        }
        
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
        view.addSubviews(
            stackView,
            alertButton,
            toDoTextLabel,
            planetOrbitalPeriodLabel
        )
        
        stackView.addArrangedSubview(alertButton)
        stackView.addArrangedSubview(toDoTextLabel)
        stackView.addArrangedSubview(planetOrbitalPeriodLabel)
        
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            alertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            alertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            alertButton.heightAnchor.constraint(equalToConstant: 50),
            
            toDoTextLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            toDoTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            planetOrbitalPeriodLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            planetOrbitalPeriodLabel.heightAnchor.constraint(equalToConstant: 25)
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
