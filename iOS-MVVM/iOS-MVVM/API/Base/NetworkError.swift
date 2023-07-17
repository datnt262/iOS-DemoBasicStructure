//
//  NetworkError.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 02/04/2021.
//

import Foundation

/// Custom class network error.
class NetworkError: Error {
    var code: Int
    var message: String

    init(_ code: Int, message: String) {
        self.code = code
        self.message = message
    }
}
