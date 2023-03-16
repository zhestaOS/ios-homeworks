//
//  Checker.swift
//  Navigation
//
//  Created by Евгения Шевякова on 12.05.2022.
//

import Foundation

final class Checker {

    static let shared = Checker()
    
    private let login = "Vera"
    private let password = "123"
    
    private init() {}
    
    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }
}
