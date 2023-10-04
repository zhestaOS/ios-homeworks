//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Евгения Шевякова on 22.06.2023.
//

import UIKit

final class AppCoordinator: Coordinatable {
    private(set) var childCoordinators: [Coordinatable] = []
    
    private let factory: AppFactory
    
    init(factory: AppFactory) {
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let feedCoordinator = FeedCoordinator(moduleType: .feed, factory: factory)
        let profileCoordinator = ProfileCoordinator(moduleType: .login, factory: factory)
        let favouritesController = FavouritesViewController()
        favouritesController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star.fill"), tag: 3)
        let mapController = MapViewController()
        mapController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map.fill"), tag: 4)
        let appTabBarController = AppTabBarController(viewControllers: [
            feedCoordinator.start(),
            profileCoordinator.start(),
            UINavigationController(rootViewController: favouritesController),
            mapController,
        ])

        addChildCoordinator(feedCoordinator)
        addChildCoordinator(profileCoordinator)

        return appTabBarController
    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 === coordinator }
    }
    
}
