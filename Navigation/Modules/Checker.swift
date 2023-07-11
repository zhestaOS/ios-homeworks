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
    
    private let login = "Vera"
    private let password = "123"
    
    // MARK: - Life cycle
    
    private init() {}
    
    // MARK: - Methods
    
    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }
    
    func checkLogin(_ login: String) -> Bool {
        login == self.login
    }
    
    func checkPassword(_ password: String) -> Bool {
        password == self.password
    }
    
    func predefinedLogin() -> String {
        login
    }
    
    func predefinedPassword() -> String {
        password
    }
}
