//
//  TestUserService.swift
//  Navigation
//
//  Created by Евгения Шевякова on 27.04.2022.
//

import Foundation
import UIKit

final class TestUserService: UserService {

    private var testUser = User(name: "Roman", avatar: UIImage(named: "photo9"), status: "offline")
    
    func returnUser(username: String) -> User? {
        if testUser.name == username {
            return testUser
        } else {
            return nil
        }
    }
}
