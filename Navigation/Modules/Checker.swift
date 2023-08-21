//
//  Checker.swift
//  Navigation
//
//  Created by Евгения Шевякова on 12.05.2022.
//

import Foundation

final class Checker {
    
    // MARK: - Properties
    
    static let shared = Checker()
    
    private let email = "vera@mail.ru"
    private let password = "123"
    
    // MARK: - Life cycle
    
    private init() {}
    
    // MARK: - Methods
    
    func check(email: String, password: String) -> Bool {
        email == self.email && password == self.password
    }
    
    func checkEmail(_ email: String) -> Bool {
        email == self.email
    }
    
    func checkPassword(_ password: String) -> Bool {
        password == self.password
    }
    
    func predefinedEmail() -> String {
        email
    }
    
    func predefinedPassword() -> String {
        password
    }
}
