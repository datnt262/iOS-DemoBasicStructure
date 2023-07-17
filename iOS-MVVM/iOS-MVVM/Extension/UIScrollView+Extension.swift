//
//  UIScrollView+Extension.swift
//  iOS - MVVM
//
//  Created by Dat Nguyen on 07/09/2022.
//

import UIKit

extension UIScrollView {
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height + self.contentInset.bottom)
        self.setContentOffset(bottomOffset, animated: animated)
    }
    
    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool? = true) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? 0)
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }
    
    func getCurrentIndex(pageWidth: CGFloat) -> Int {
        return Int(self.contentOffset.x / pageWidth)
    }
}
