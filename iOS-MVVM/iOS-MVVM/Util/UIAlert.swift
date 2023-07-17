//
//  UIAlert.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

class UIAlert: NSObject {
    class func show(title: String? = nil, message: String?, okTitle: String?, cancelTitle: String?, okCompletion: (() -> Void)? = nil, cancelCompletion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let okTitle {
            let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
                okCompletion?()
            }
            alert.addAction(okAction)
        }

        if let cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .default) { _ in
                cancelCompletion?()
            }
            alert.addAction(cancelAction)
        }
        
        UIApplication.topViewController()?.popupAlert(alert)
    }
}
