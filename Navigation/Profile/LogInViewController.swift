//
//  LogInViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 31.01.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

final class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    var loginDelegate: LoginViewControllerDelegate?
        
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
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Username"
        
        textField.text = Checker.shared.predefinedLogin()
        
        textField.textColor = .black
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
        textField.placeholder = "Password"
        
        textField.text = Checker.shared.predefinedPassword()
        
        textField.textColor = .black
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
        let button = CustomButton(title: "Log In",
                                  сolorOfBackground: .systemGreen) {
            self.logInButtonTapped()
        }
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            vkLogoImageView,
            loginTextField,
            passwordTextField,
            logInButton
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
            
            loginTextField.topAnchor.constraint(equalTo: vkLogoImageView.bottomAnchor, constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
            
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
        
        guard let username = loginTextField.text, let password = passwordTextField.text else { return }
        
        var userService: UserService
        
//        #if DEBUG
//        userService = TestUserService()
//        #else
        userService = CurrentUserService()
//        #endif
        
        guard let loginDelegate = loginDelegate, loginDelegate.check(login: username, password: password) else {
            showLoginError()
            return
        }

        guard let user = userService.returnUser(username: username) else { return }
        
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func tapGesture(_ gesture: UITapGestureRecognizer) {
        print("Did catch tap action")
    }
    
    private func showLoginError() {
        let alertController = UIAlertController(title: "", message: "Введены некорректные данные, попробуйте еще раз", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Попробовать", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
}
