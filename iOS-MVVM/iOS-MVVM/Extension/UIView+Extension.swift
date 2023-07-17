//
//  UIView+Extension.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/03/2022.
//

import UIKit

extension UIView {
    
    //MARK: - @IBInspectable
    
    /// :Border color of view
    public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }
    
    /// : Border width of view
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    /// :Corner radius of view
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
//            self.clipsToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    /// : Shadow color of view
    public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// : Shadow offset of view
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// : Shadow opacity of view
    public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// : Shadow radius of view
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// Round corner
    /// - Parameters:
    ///   - corners: list corner that want to round
    ///   - radius: radius of round
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIView {
    /// Set contraint for view to fixed in super view
    /// - Parameter container: superview that want to fixed
    func fixInView(_ container: UIView) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
        ])
    }
    
    func makeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// : Add gradient for view
    func layerGradient(start: GradientPoint, end: GradientPoint, colors: [UIColor], type: CAGradientLayerType = .axial) {
        self.layer.sublayers?.forEach({ layer in
            if layer.isKind(of: CAGradientLayer.self) {
                layer.removeFromSuperlayer()
            }
        })
        let cgColors = colors.map({$0.cgColor})
        let layer: CAGradientLayer = CAGradientLayer(start: start, end: end, colors: cgColors, type: type)
        layer.frame = self.bounds
        layer.cornerRadius = self.cornerRadius
        self.layer.insertSublayer(layer, at: 0)
    }
    
    /// Drop common shadow for view
    public func dropShadow(color: UIColor, shadowOffset: CGSize = .zero, shadowOpacity: Float = 0.3, shadowRadius: CGFloat = 3.0) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = color.cgColor
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    public func dropShadowByPath(color: UIColor, shadowOffset: CGSize = .zero, shadowOpacity: Float = 0.3, shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    /// Create animation like shake
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    public func circled() {
        self.cornerRadius = self.frame.height/2
    }
}
