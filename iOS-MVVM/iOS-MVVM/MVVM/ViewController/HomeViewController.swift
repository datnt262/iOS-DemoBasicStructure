//
//  HomeViewController.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

class HomeViewController: BaseViewController {

    //Properties
    let viewModel = HomeViewModel()
    
    //LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Functions
    override func bindingViewModel() {
        viewModel.userModel.observe(on: self, forceObserverFirstTime: true) { [weak self] user in
            self?.title = user?.fullName
        }
    }
    
    override func setupUI() {
        view.backgroundColor = .appColor(.primary)
    }

}
