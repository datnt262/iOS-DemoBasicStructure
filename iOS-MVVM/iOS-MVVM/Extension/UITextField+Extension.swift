//
//  UITextField+Extension.swift
//  iOS - MVVM
//
//  Created by Dat Nguyen on 07/10/2022.
//

import UIKit

extension UITextField {
    /// Set right view for textfield
    /// - Parameter named: name of icon
    func setRightIcon(_ icon: UIImage?, color: UIColor? = nil) {
        let size = self.frame.size.height
        let rView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        let riView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 16))
        riView.center = rView.center
        riView.image = icon
        riView.contentMode = .scaleAspectFit
        if let color = color {
            riView.maskWith(color: color)
        }
        rView.addSubview(riView)
        rightView = rView
        rightViewMode = .always
    }
    
    /// Set right view for textfield
    /// - Parameter named: name of icon
    func setLeftIcon(_ icon: UIImage?, color: UIColor? = nil) {
        let size = self.frame.size.height
        let lView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        let liView = UIImageView(frame: CGRect(x: 5, y: 12, width: 20, height: 16))
        liView.center = lView.center
        liView.image = icon
        liView.contentMode = .scaleAspectFit
        if let color = color {
            liView.maskWith(color: color)
        }
        lView.addSubview(liView)
        leftView = lView
        leftViewMode = .always
    }
}

class BaseTextField: UITextField {
    /// Allow user to select there actions
    var allowedActions: [ResponderStandardEditActions] = [] {
        didSet {
            if !allowedActions.isEmpty && !notAllowedActions.isEmpty {
                notAllowedActions = []
            }
        }
    }
    
    /// Not allow user to select there actions
    var notAllowedActions: [ResponderStandardEditActions] = [] {
        didSet {
            if !allowedActions.isEmpty && !notAllowedActions.isEmpty {
                allowedActions = []
            }
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        if !allowedActions.isEmpty {
            return allowedActions.map{ $0.selector }.contains(action)
        }
        
        if !notAllowedActions.isEmpty {
            return !notAllowedActions.map{ $0.selector }.contains(action)
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
}

enum ResponderStandardEditActions {
    case cut, copy, paste, select, selectAll, delete
    var selector: Selector {
        switch self {
        case .cut:
            return #selector(UIResponderStandardEditActions.cut)
        case .copy:
            return #selector(UIResponderStandardEditActions.copy)
        case .paste:
            return #selector(UIResponderStandardEditActions.paste)
        case .select:
            return #selector(UIResponderStandardEditActions.select)
        case .selectAll:
            return #selector(UIResponderStandardEditActions.selectAll)
        case .delete:
            return #selector(UIResponderStandardEditActions.delete)
        }
    }
}
