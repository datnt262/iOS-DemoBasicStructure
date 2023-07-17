//
//  UITableView+Extension.swift
//  Wallpaper
//
//  Created by Dat Nguyen on 27/05/2022.
//

import UIKit

extension UITableView {
    func observeContentSize(_ observer: NSObject) {
        self.addObserver(observer, forKeyPath: ObserverKeyPath.contentSize.rawValue, options: .new, context: nil)
    }
}
