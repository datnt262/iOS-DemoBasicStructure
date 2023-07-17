//
//  LoginViewModel.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

class LoginViewModel: BaseViewModel {
    var errorMessage: Observable<String?> = Observable(nil)
    var loginResult: Observable<LoginResponseModel?> = Observable(nil)
    
    func login(username: String, password: String) {
        if username.isEmpty {
            errorMessage.value = "login_username_empty".localized
            return
        }
        if password.isEmpty {
            errorMessage.value = "login_password_empty".localized
            return
        }
        isLoading.value = true
        let api = LoginAPI(username: username, password: password)
        api.request(modelType: LoginResponseModel.self) { [weak self] result in
            self?.isLoading.value = false
            self?.performDemoFlow(username: username)
            
            //For purpose demo, will comment these lines
//            switch result {
//            case .success(let model):
//                Logger.debug(message: "Login response: \(model)")
//                self?.loginResult.value = model
//            case .failure(let error):
//                Logger.error(message: "Login failed: \(error.localizedDescription)")
//                self?.loginResult.value = nil
//            }
        }
    }
    
    private func performDemoFlow(username: String) {
        let result = LoginResponseModel(fullName: username)
        self.loginResult.value = result
    }
}



