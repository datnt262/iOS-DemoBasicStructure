//
//  BaseButton.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

class BaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    func setupUI() {
        titleLabel?.font = .semibold()
        tintColor = .systemBackground
        backgroundColor = .appColor(.primary)
        cornerRadius = 10
    }

}
