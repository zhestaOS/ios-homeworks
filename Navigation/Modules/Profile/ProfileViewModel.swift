//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Евгения Шевякова on 29.06.2023.
//

import Foundation
import StorageService

protocol ProfileViewModelProtocol: ViewModelProtocol {
    var user: User { get }
    func addPostToFavs(post: Post)
}

final class ProfileViewModel: ProfileViewModelProtocol {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func addPostToFavs(post: Post) {
        CoreDataManager.shared.savePost(post: post)
    }
}
