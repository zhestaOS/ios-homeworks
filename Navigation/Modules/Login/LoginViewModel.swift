//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Евгения Шевякова on 30.06.2023.
//

import Foundation

protocol LoginViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((LoginViewModel.State) -> Void)? { get set }
    func updateState(viewInput: LoginViewModel.ViewInput)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    // MARK: - Properties
    
    struct UserAuthData {
        let email: String
        let password: String
    }
    
    enum State: Equatable {
        case initial
        case errorEmail
        case errorPassword
        case emptyFields
        case unexpectedError(desc: String)
    }
    
    enum ViewInput {
        case loginButtonTapped(authData: UserAuthData)
    }
    
    private let userService: UserService
    private let loginDelegate: LoginViewControllerDelegate
    weak var coordinator: ProfileCoordinator?
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    // MARK: - Life cycle
    
    init(
        userService: UserService = CurrentUserService(),
        contentFactory: LoginViewControllerDelegate = ContentFactory().makeLoginInspector()
    ) {
        self.userService = userService
        self.loginDelegate = contentFactory
    }
    
    // MARK: - Methods
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .loginButtonTapped(let authData):
            loginDelegate.check(email: authData.email, password: authData.password) { [weak self] result in
                switch result {
                case .success(let email):
                    guard let user = self?.userService.returnUser(username: email) else {
                        self?.handleError(.incorrectEmail)
                        return
                    }
                    self?.coordinator?.pushProfileViewController(for: user)
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }
    
    func handleError(_ error: AuthError) {
        switch error {
        case .incorrectEmail:
            state = .errorEmail
        case .incorrectPassword:
            state = .errorPassword
        case .fbRegEmailAlreadyInUse(let desc), .fbRegInvalidEmail(let desc), .fbRegWeakPassword(let desc), .fbRegUnexpected(let desc),
                .fbAuthInvalidCredential(let desc), .fbAuthInvalidEmail(let desc), .fbAuthWrongPassword(let desc), .fbAuthUnexpected(let desc):
            state = .unexpectedError(desc: desc)
        case .emptyFields:
            state = .emptyFields
        }
    }
}

