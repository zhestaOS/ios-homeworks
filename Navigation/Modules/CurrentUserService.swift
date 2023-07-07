//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Евгения Шевякова on 26.04.2022.
//

import Foundation
import UIKit

protocol UserService {
    func returnUser(username: String) -> User?
}

final class CurrentUserService: UserService {
    func returnUser(username: String) -> User? {
        let user = User(name: username, avatar: UIImage(named: "photo17"), status: "online")
        return user
    }
}
