//
//  Optional+Extension.swift
//  iOS - MVVM
//
//  Created by Dat Nguyen on 14/04/2022.
//

import UIKit

extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    func `let`<T>(_ transform: (Wrapped) -> T?) -> T? {
        if case .some(let value) = self {
            return transform(value)
        }
        return nil
    }
}
