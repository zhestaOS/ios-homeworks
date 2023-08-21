//
//  LoginInspector.swift
//  Navigation
//
//  Created by Евгения Шевякова on 10.03.2023.
//

import Foundation

enum AuthSuccessType {
    case signIn, signUp
}

enum AuthError: Error {
    case emptyFields
    case incorrectEmail
    case incorrectPassword
    
    case fbRegEmailAlreadyInUse(desc: String)
    case fbRegInvalidEmail(desc: String)
    case fbRegWeakPassword(desc: String)
    case fbRegUnexpected(desc: String)
    
    case fbAuthInvalidCredential(desc: String)
    case fbAuthInvalidEmail(desc: String)
    case fbAuthWrongPassword(desc: String)
    case fbAuthUnexpected(desc: String)
}

class LoginInspector: LoginViewControllerDelegate {
    func check(email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        CheckerService.shared.checkCredentials(withEmail: email, password: password) { result in
            completion(result)
        }
    }
}
