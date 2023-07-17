//
//  ObserverKeyPath.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import Foundation

enum ObserverKeyPath:String {
    case contentSize
    var rawValue: String{
        switch self {
        case .contentSize:
            return "contentSize"
        }
    }
}
