//
//  UICollectionView+Extension.swift
//  iOS - MVVM
//
//  Created by Dat Nguyen on 26/05/2022.
//

import UIKit

extension UICollectionView {
    var currentIndexPath: IndexPath? {
        Logger.logs(message: self.indexPathsForVisibleItems)
        if let indexPath = self.indexPathsForVisibleItems.first {
            return indexPath
        } else {
            return nil
        }
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = BaseLabel()
        messageLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        messageLabel.text = message
        if #available(iOS 13.0, *) {
            messageLabel.textColor = .label
        } else {
            messageLabel.textColor = .appColor(.textPrimary)
        }
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}
