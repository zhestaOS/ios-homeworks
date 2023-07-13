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
    struct UserAuthData {
        let login: String
        let password: String
    }
    
    enum State {
        case initial
        case errorLogin
        case errorPassword
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
    
    init(
        userService: UserService = CurrentUserService(),
        contentFactory: LoginViewControllerDelegate = ContentFactory().makeLoginInspector()
    ) {
        self.userService = userService
        self.loginDelegate = contentFactory
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .loginButtonTapped(let authData):
            var isValidUser = false
            do {
                isValidUser = try loginDelegate.check(login: authData.login, password: authData.password)
            } catch {
                if let error  = error as? AuthError {
                    handleError(error)
                }
            }
            
            guard isValidUser, let user = userService.returnUser(username: authData.login) else {
                state = .errorLogin
                return
            }
            coordinator?.pushProfileViewController(for: user)
        }
    }
    
    func handleError(_ error: AuthError) {
        switch error {
        case .userNotFound:
            state = .errorLogin
        case .incorrectPassword:
            state = .errorPassword
        }
    }
}
