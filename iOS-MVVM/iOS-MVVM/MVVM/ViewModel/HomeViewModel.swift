//
//  HomeViewModel.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import Foundation

class HomeViewModel: BaseViewModel {
    var userModel = Observable<LoginResponseModel?>(nil)
}
