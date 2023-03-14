//
//  AppDelegate.swift
//  Navigation
//
//  Created by Евгения Статива on 27.11.2021.
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let contentFactory = ContentFactory()
        
        let tabBarController = UITabBarController()

        let feedVC = FeedViewController()
        let feedNC = UINavigationController(rootViewController: feedVC)
        
        let profileVC = LogInViewController()
        
        let loginInspector = contentFactory.makeLoginInspector()
        profileVC.loginDelegate = loginInspector
        
        let profileNC = UINavigationController(rootViewController: profileVC)
        profileNC.view.backgroundColor = .white
        
        feedVC.tabBarItem.image = UIImage(systemName: "house.fill")
        feedVC.tabBarItem.title = "Feed"
        profileVC.tabBarItem.image = UIImage(systemName: "person.fill")
        profileVC.tabBarItem.title = "Profile"
        
        tabBarController.viewControllers = [feedNC, profileNC]

        tabBarController.tabBar.backgroundColor = .white
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
