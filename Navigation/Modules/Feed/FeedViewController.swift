//
//  FeedViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 01.12.2021.
//

import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: FeedViewModelProtocol
            
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.toAutoLayout()
        
        return stackView
    }()

    private lazy var firstButton: CustomButton = {
        let button = CustomButton(title: "feed_first_button".localized,
                                  сolorOfBackground: .systemGreen) {
            self.transitionButtonTapped()
        }
        return button
    }()

    private lazy var secondButton: CustomButton = {
        let button = CustomButton(title: "feed_second_button".localized,
                                  сolorOfBackground: .systemTeal) {
            self.transitionButtonTapped()
        }
        return button
    }()

    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "feed_check_guess_button".localized,
                                  сolorOfBackground: .systemOrange) {
            self.checkGuessButtonTapped()
        }
        return button
    }()
    
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
        textField.addTarget(FeedViewController.self, action: #selector(guessChecked(_:)), for: .editingChanged)

        return textField
    }()
    
    private let checkGuessLabel: UILabel = {
        let label = UILabel()
        label.text = "feed_result_info_label".localized
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        
        return label
    }()
    
    private var timer: Timer?
    
    
    // MARK: - Life cycle
    
    init(viewModel: FeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
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
        if viewModel.checkWord(word: guessText) {
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
    
    private func setupTimer() {
        let timeInterval: Double = 60 * 15
        timer = Timer(timeInterval: timeInterval, repeats: true, block: { timer in
            print("fired")
            let alertController = UIAlertController(title: "Предепреждение", message: "Желательно давать глазам отдыхать каждые 15 минут.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alertController, animated: true)
        })
        RunLoop.main.add(timer!, forMode: .default)
    }
}
