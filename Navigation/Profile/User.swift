//
//  User.swift
//  Navigation
//
//  Created by Евгения Шевякова on 26.04.2022.
//

import Foundation
import UIKit

final class User {
    
    // MARK: - Properties
    
    var name: String
    var avatar: UIImage?
    var status: String?
    
    // MARK: - Life cycle
    
    init(name: String, avatar: UIImage? = nil, status: String? = nil) {
        self.name = name
        self.avatar = avatar
        self.status = status
    }
}
