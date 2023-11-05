//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Евгения Шевякова on 05.11.2023.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        var error: NSError?
        LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error {
            print(error)
            return
        }
        
        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To access data") { success, error in
            if let error = error {
                print("Try another method, \(error.localizedDescription)")
                authorizationFinished(false)
                return
            }

            print("Auth: \(success)")
            authorizationFinished(true)
        }
    }
}
