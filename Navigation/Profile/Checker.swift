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
    
    func predefinedLogin() -> String {
        login
    }
    
    func predefinedPassword() -> String {
        password
    }
}
