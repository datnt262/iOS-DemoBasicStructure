//
//  Enviroment.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 02/04/2021.
//
import UIKit
import Foundation

enum EnumEnviroment {
    case DEV, UAT, PRO
}

/// Define all environments for app (DEV, UAT, PRODUCT)
class Enviroment: NSObject {
    
    /// Current environment to build
    private static let currentEnviroment: EnumEnviroment = .DEV
    
    /// Get main url string based on current environment
    /// - Returns: url string
    public static func getMainUrl() -> String {
        switch self.currentEnviroment {
        case .DEV:
            return "https://reqres.in"
        case .UAT:
            return "https://uat.demo.com/api"
        case .PRO:
            return "https://pro.demo.com/api"
        }
    }
}
