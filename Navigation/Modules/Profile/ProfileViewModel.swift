//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Евгения Шевякова on 29.06.2023.
//

import Foundation

protocol ProfileViewModelProtocol: ViewModelProtocol {
    var user: User { get }
}

final class ProfileViewModel: ProfileViewModelProtocol {
    var user: User
    
    init(user: User) {
        self.user = user
    }
}
