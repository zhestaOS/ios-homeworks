//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Евгения Шевякова on 26.06.2023.
//

import UIKit

final class ProfileCoordinator: ModuleCoordinatable {
    let moduleType: Module.ModuleType
    
    private let factory: AppFactory
    
    private(set) var childCoordinators: [Coordinatable] = []
    private(set) var module: Module?
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? LoginViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func pushProfileViewController(for user:User) {
        let module = factory.makeModule(ofType: .profile(user: user))
        let viewController = module.view
        (self.module?.view as? UINavigationController)?.pushViewController(viewController, animated: true)
    }
}
