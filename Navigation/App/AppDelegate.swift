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
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let appFactory = AppFactory()
        let appCoordinator = AppCoordinator(factory: appFactory)
        
        let appConfiguration: AppConfiguration = .people(URL(string: "https://swapi.dev/api/people/8")!)
        
        self.appCoordinator = appCoordinator
        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
        
        NetworkManager.request(for: appConfiguration)
        
        return true
    }
}
