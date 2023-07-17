//
//  LoginAPI.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import Alamofire

class LoginAPI: BaseApi {
    private let username: String
    private let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    override func path() -> String {
        return ApiPath.login.rawValue
    }
    
    override func method() -> HTTPMethod {
        return .post
    }
    
    override func parameters() -> [String : Any]? {
        LoginRequestModel(username: username, password: password).dictionary
    }
}
