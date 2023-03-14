//
//  LoginInspector.swift
//  Navigation
//
//  Created by Евгения Шевякова on 10.03.2023.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {

    func check(login: String, password: String) -> Bool {
        let checker = Checker.shared.check(login: login, password: password)
        return checker
    }
}
