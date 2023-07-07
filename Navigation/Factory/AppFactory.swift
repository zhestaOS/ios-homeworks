//
//  AppFactory.swift
//  Navigation
//
//  Created by Евгения Шевякова on 29.06.2023.
//

import UIKit

final class AppFactory {
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .login:
            let viewModel = LoginViewModel() //TestUserService() CurrentUserService()
            let viewController = LogInViewController(viewModel: viewModel)
            let nc = UINavigationController(rootViewController: viewController)
            return Module(moduleType: .login, viewModel: viewModel, view: nc)
        case .profile(let user):
            let viewModel = ProfileViewModel(user: user)
            let viewController = ProfileViewController(viewModel: viewModel)
            return Module(moduleType: .profile(user: user), viewModel: viewModel, view: viewController)
        case .feed:
            let viewModel = FeedViewModel()
            let viewController = FeedViewController(viewModel: viewModel)
            let nc = UINavigationController(rootViewController: viewController)
            return Module(moduleType: .feed, viewModel: viewModel, view: nc)
        }
    }
    
}
