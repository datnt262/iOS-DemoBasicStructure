//
//  UIImage+Extension.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 12/05/2022.
//

import UIKit

extension UIImageView {
    
    /// Change color of image view
    /// - Parameter color: color will change to of image
    func maskWith(color: UIColor) {
         if let img = self.image {
              self.image = img.withRenderingMode(.alwaysTemplate)
              self.tintColor = color
         }
    }
}

extension UIImage {
    /// Resize image to expect size
    /// - Parameter newSize: new size that want to resize
    /// - Returns: new image with new size
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /// Rotate image
    /// - Parameter radians: radians that want to rotate
    /// - Returns: image after rotate
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}
