//
//  AppFont.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

enum CustomFontWeight {
    static let fontPrefixName = "SFProDisplay"
    case light, regular, medium, semibold, bold, italic
    
    var posFix: String {
        switch self {
        case .light:
            return "Light"
        case .regular:
            return "Regular"
        case .medium:
            return "Medium"
        case .semibold:
            return "Semibold"
        case .bold:
            return "Bold"
        case .italic:
            return "RegularItalic"
        }
    }
    
    var name: String {
        return "\(CustomFontWeight.fontPrefixName)-\(posFix)"
    }
}

extension UIFont {
    
    /// Return medium font
    /// - Parameter size: size of font
    /// - Returns: medium font with size
    static func medium(size: CGFloat = 16) -> UIFont {
        return .appFont(weight: .medium, size: size)
    }
    
    /// Return regular font
    /// - Parameter size: size of font
    /// - Returns: regular font with size
    static func regular(size: CGFloat = 16) -> UIFont {
        return .appFont(weight: .regular, size: size)
    }
    
    /// Return bold font
    /// - Parameter size: size of font
    /// - Returns: bold font with size
    static func bold(size: CGFloat = 16) -> UIFont {
        return .appFont(weight: .bold, size: size)
    }
    
    /// Return semibold font
    /// - Parameter size: size of font
    /// - Returns: semibold font with size
    static func semibold(size: CGFloat = 16) -> UIFont {
        return .appFont(weight: .semibold, size: size)
    }
    
    /// Return italic font
    /// - Parameter size: size of font
    /// - Returns: italic font with size
    static func italic(size: CGFloat = 16) -> UIFont {
        return .appFont(weight: .italic, size: size)
    }
    
    /// Return custom font
    /// - Parameters:
    ///   - weight: weight of font
    ///   - size: size of font
    /// - Returns: Font with weight and size
    static func appFont(weight: CustomFontWeight, size: CGFloat = 16) -> UIFont {
        let fontName = weight.name
        if let font = UIFont(name: fontName, size: size) {
            return font
        } else {
            switch weight {
            case .light:
                return .systemFont(ofSize: size, weight: .light)
            case .regular:
                return .systemFont(ofSize: size, weight: .regular)
            case .medium:
                return .systemFont(ofSize: size, weight: .medium)
            case .semibold:
                return .systemFont(ofSize: size, weight: .semibold)
            case .bold:
                return .systemFont(ofSize: size, weight: .bold)
            case .italic:
                return .systemFont(ofSize: size, weight: .thin)
            }
        }
    }
}
