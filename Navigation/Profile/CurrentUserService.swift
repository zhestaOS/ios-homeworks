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
    
    private var user = User(name: "Ivan", avatar: UIImage(named: "photo3"), status: "online")
    
    func returnUser(username: String) -> User? {
        if user.name == username {
            return user
        } else {
            return nil
        }
    }
}
