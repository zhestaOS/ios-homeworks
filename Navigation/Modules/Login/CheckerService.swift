//
//  CheckerService.swift
//  Navigation
//
//  Created by Евгения Шевякова on 14.08.2023.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(withEmail email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void)
}

class CheckerService: CheckerServiceProtocol {
    
    static let shared = CheckerService()

    let firebaseAuth = Auth.auth()

    func checkCredentials(withEmail email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        guard !email.isEmpty || !password.isEmpty else {
            print("Пустое поле")
            completion(.failure(.emptyFields))
            return
        }
        
        guard isValidEmail(email) else {
            print("Email введен некорректно")
            completion(.failure(.incorrectEmail))
            return
        }
        
        guard password.count >= 6 else {
            print("Пароль введен некорректно")
            completion(.failure(.incorrectPassword))
            return
        }
        
        if firebaseAuth.currentUser == nil {
            
            signUp(withEmail: email, password: password) { result in
                switch result {
                case .success(let email):
                    completion(.success(email))
                case .failure(let error):
                    if case AuthError.fbRegEmailAlreadyInUse = error {
                        self.signIn(withEmail: email, password: password) { result in
                            completion(result)
                        }
                        return
                    }
                    completion(.failure(error))
                }
            }
        } else {
            
            self.signIn(withEmail: email, password: password) { result in
                completion(result)
            }
        }

    }
    
    func signUp(withEmail email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print(error.localizedDescription)
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(.failure(AuthError.fbRegEmailAlreadyInUse(desc: err.localizedDescription)))
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.failure(AuthError.fbRegInvalidEmail(desc: err.localizedDescription)))
                case AuthErrorCode.weakPassword.rawValue:
                    completion(.failure(AuthError.fbRegWeakPassword(desc: err.localizedDescription)))
                default:
                    completion(.failure(AuthError.fbRegUnexpected(desc: err.localizedDescription)))
                }
                return
            }
            if let email = authDataResult?.user.email {
                completion(.success(email))
            } else {
                completion(.failure(.fbRegUnexpected(desc: "Unexpected error")))
            }
        }
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error, authDataResult?.user == nil {
                print(error.localizedDescription)
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.invalidCredential.rawValue:
                    completion(.failure(AuthError.fbAuthInvalidCredential(desc: err.localizedDescription)))
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.failure(AuthError.fbAuthInvalidEmail(desc: err.localizedDescription)))
                case AuthErrorCode.wrongPassword.rawValue:
                    completion(.failure(AuthError.fbAuthWrongPassword(desc: err.localizedDescription)))
                default:
                    completion(.failure(AuthError.fbAuthUnexpected(desc: err.localizedDescription)))
                }
                return
            }
            
            if let email = authDataResult?.user.email {
                completion(.success(email))
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
