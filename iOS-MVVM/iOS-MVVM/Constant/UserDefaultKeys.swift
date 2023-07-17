//
//  UserDefaults+Key.swift
//  AirHorn
//
//  Created by Dat Nguyen on 01/04/2022.
//

import Foundation

class UserDefaultKey {
    static let hasInstalled                 = "hasInstalled"
    static let reviewWorthyActionCount      = "lastReviewRequestAppVersion"
    static let lastReviewRequestAppVersion  = "lastReviewRequestAppVersion"
}

//MARK: - App settings
extension UserDefaultKey {
    static let appAppearance = "appAppearance"
    static let enableVibration = "enableVibration"
}
