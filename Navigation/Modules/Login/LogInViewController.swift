//
//  LogInViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 31.01.2022.
//

import UIKit
import FirebaseAuth

protocol LoginViewControllerDelegate: AnyObject {
    func check(email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void)
}

final class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: LoginViewModelProtocol
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    private var frameGuide = UILayoutGuide()
    private var contentGuide = UILayoutGuide()
    
    private let contentView: UIView = {
      let contentView = UIView()
      contentView.backgroundColor = .white
      contentView.toAutoLayout()

      return contentView
    }()
    
    private let vkLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.toAutoLayout()

        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "login_email_placeholder".localized
        textField.textColor = .vkTextMainColor
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor.red
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 14, height: 0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.toAutoLayout()
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "login_password_placeholder".localized
        textField.textColor = .vkTextMainColor
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor.red
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 14, height: 0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.toAutoLayout()
        
        return textField
    }()
    
    private let imgForNormalState = UIImage(named: "blue_pixel")?.alpha(1.0)
    private let imgForOtherState = UIImage(named: "blue_pixel")?.alpha(0.8)
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: "login_enter_button".localized,
                                  сolorOfBackground: .systemGreen) {
            self.logInButtonTapped()
        }
        return button
    }()
    
    lazy var biometryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "touchid"), for: .normal)
        button.addTarget(self, action: #selector(biometryTapped), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    // MARK: - Life cycle
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        view.backgroundColor = .white
        
        frameGuide = scrollView.frameLayoutGuide
        contentGuide = scrollView.contentLayoutGuide
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.backgroundTap))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationController?.navigationBar.isHidden = true
        
        logInButton.setBackgroundImage(imgForNormalState, for: .normal)
        logInButton.setBackgroundImage(imgForOtherState, for: .selected)
        logInButton.setBackgroundImage(imgForOtherState, for: .highlighted)
        logInButton.setBackgroundImage(imgForOtherState, for: .disabled)
        
        addSubviews()
        setConstraints()
        
        view.backgroundColor = .vkBackgroundColor
        scrollView.backgroundColor = .vkBackgroundColor
        contentView.backgroundColor = .vkBackgroundColor
    }
    
    // MARK: - Methods
    
    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self else {
                return
            }
            switch state {
            case .errorEmail:
                Alert.shared.showError(with: "alert_incorrect_email".localized, vc: self)
            case .errorPassword:
                Alert.shared.showError(with: "alert_incorrect_password".localized, vc: self)
            case .unexpectedError(desc: let desc):
                Alert.shared.showError(with: desc, vc: self)
            case .emptyFields:
                Alert.shared.showError(with: "alert_incorrect_clear".localized, vc: self)
            case .initial:
                break
            }
        }
    }
  
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            vkLogoImageView,
            emailTextField,
            passwordTextField,
            logInButton,
            biometryButton
        )
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
            
            vkLogoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogoImageView.widthAnchor.constraint(equalToConstant: 100),
            vkLogoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            emailTextField.topAnchor.constraint(equalTo: vkLogoImageView.bottomAnchor, constant: 120),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            biometryButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            biometryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            biometryButton.heightAnchor.constraint(equalToConstant: 66),
            biometryButton.widthAnchor.constraint(equalToConstant: 66),
            biometryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc
    private func backgroundTap(_ sender: UITapGestureRecognizer) {
        // go through all of the textfield inside the view, and end editing thus resigning first responder
        // ie. it will trigger a keyboardWillHide notification
        self.view.endEditing(true)
    }
    
    @objc
    private func logInButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        viewModel.updateState(viewInput: .loginButtonTapped(authData: .init(email: email, password: password)))
    }
    
    @objc
    func tapGesture(_ gesture: UITapGestureRecognizer) {
        print("Did catch tap action")
    }
    
    @objc
    func biometryTapped() {
        LocalAuthorizationService().authorizeIfPossible { [weak self] success in
            if success {
                self?.viewModel.updateState(viewInput: .loginButtonTapped(authData: .init(email: "321@321.com", password: "321321")))
            }
        }
    }
}
