//
//  AppColor.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

/// App color
enum AppColor {
    case primary, subPrimary
    case secondary, subSecondary
    case tertiary, subTertiary
    case textPrimary, subTextPrimary
    case textSecondary, subTextSecond
    case textTertiary, subTextTertiary
    case highlight, unHighlight
    case backgroundPrimary, backgroundSecondary
    case success, error
    case positive, negative
    case separator
    case white, black
    case shadow
    
    var color: UIColor {
        switch self {
        case .primary:
            return UIColor.systemGreen
        case .subPrimary:
            return UIColor.systemGreen
        case .secondary:
            return UIColor.systemBlue
        case .subSecondary:
            return UIColor.systemBlue
        case .tertiary:
            return UIColor.systemOrange
        case .subTertiary:
            return UIColor.systemTeal
        case .textPrimary:
            return UIColor.label
        case .subTextPrimary:
            return UIColor.label
        case .textSecondary:
            return UIColor.secondaryLabel
        case .subTextSecond:
            return UIColor.secondaryLabel
        case .textTertiary:
            return UIColor.tertiaryLabel
        case .subTextTertiary:
            return UIColor.tertiaryLabel
        case .highlight:
            return UIColor.systemBlue
        case .unHighlight:
            return UIColor.systemGray2
        case .backgroundPrimary:
            return UIColor.systemGroupedBackground
        case .backgroundSecondary:
            return UIColor.secondarySystemGroupedBackground
        case .success:
            return UIColor.systemBlue
        case .error:
            return UIColor.systemRed
        case .positive:
            return UIColor.systemGreen
        case .negative:
            return UIColor.systemRed
        case .separator:
            return UIColor.opaqueSeparator
        case .white:
            return .white
        case .black:
            return .black
        case .shadow:
            return .secondaryLabel
        }
    }
}

extension UIColor {
    /// Get color for custom enum
    /// - Parameters:
    ///   - appColor: custom color by enum
    ///   - alpha: alpha of this color
    /// - Returns: color result
    static func appColor(_ appColor: AppColor, alpha: CGFloat? = 1) -> UIColor {
        return appColor.color.withAlphaComponent(alpha ?? 1)
    }
}
