//
//  UITextView+Extension.swift
//  iOS - MVVM
//
//  Created by Dat Nguyen on 29/07/2022.
//

import UIKit

extension UITextView {
    
    private class PlaceholderLabel: UILabel { }
    
    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
            return label
        } else {
            let label = PlaceholderLabel(frame: .zero)
            label.font = font
            addSubview(label)
            return label
        }
    }
    
    var placeholder: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            textContainer.lineFragmentPadding = 0
            let placeholderLabel = self.placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.textColor = self.textColor?.withAlphaComponent(0.3)
            placeholderLabel.numberOfLines = 0
            let width = frame.width - textContainer.lineFragmentPadding * 2
            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            placeholderLabel.frame.size.height = size.height
            placeholderLabel.frame.size.width = width
            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainerInset.top)
            
            textStorage.delegate = self
        }
    }
    
}

extension UITextView: NSTextStorageDelegate {
    
    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
    
}

extension UITextView {
    func insertImage(_ image: UIImage, at location: Int?) {
        let currentFont = self.font
        
        let totalSpace = 16.0
        let attachment = NSTextAttachment()
        attachment.image = image
        //calculate new size.  (-20 because I want to have a litle space on the right of picture)
        let newImageWidth = (self.bounds.size.width - totalSpace)
        let scale = newImageWidth/image.size.width
        let newImageHeight = image.size.height * scale
        //resize this
        attachment.bounds = CGRect.init(x: totalSpace/2, y: 0, width: newImageWidth, height: newImageHeight)
        //put your NSTextAttachment into and attributedString
        let attString = NSAttributedString(attachment: attachment)
        //add this attributed string to the current position.
        if let location = location {
            self.textStorage.insert(attString, at: location)
        } else {
            self.textStorage.insert(attString, at: self.selectedRange.location)
        }
        
        self.font = currentFont
    }
    
    func moveCursorToEnd() {
        let newPosition = self.endOfDocument
        self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
    }
}
