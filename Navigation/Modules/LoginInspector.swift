//
//  LoginInspector.swift
//  Navigation
//
//  Created by Евгения Шевякова on 10.03.2023.
//

import Foundation

enum AuthError: Error {
case userNotFound, incorrectPassword
}

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(login: String, password: String) throws -> Bool {
        let isLoginValid = Checker.shared.checkLogin(login)
        guard isLoginValid else {
            throw AuthError.userNotFound
        }
        
        let isPasswordValid = Checker.shared.checkPassword(password)
        guard isPasswordValid else {
            throw AuthError.incorrectPassword
        }
        
        return true
    }
    
}
