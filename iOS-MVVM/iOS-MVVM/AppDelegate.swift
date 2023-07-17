//
//  AppDelegate.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        NetworkManager.shared.startChecking()
        
        let loginVC = LoginViewController.instantiate(from: .Registration)
        let navigationVC = BaseNavigationController(rootViewController: loginVC)
        Router.setRoot(vc: navigationVC)
        
        return true
    }

}

