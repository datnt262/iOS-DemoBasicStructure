//
//  Router.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

class Router {
    class func setRoot(vc: UIViewController) {
        kAppDelegate.window?.rootViewController = vc
        kAppDelegate.window?.makeKeyAndVisible()
    }
}
