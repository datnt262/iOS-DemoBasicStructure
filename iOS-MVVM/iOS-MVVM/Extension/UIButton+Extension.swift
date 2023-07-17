//
//  UIButton+Extension.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 19/05/2022.
//

import UIKit

extension UIButton {
    public func setImage(named: String, color: UIColor) {
        let image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
        self.tintColor = color
    }
}
