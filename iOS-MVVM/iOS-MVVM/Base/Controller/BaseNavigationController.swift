//
//  BaseNavigationController.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = appearance
    }
}
