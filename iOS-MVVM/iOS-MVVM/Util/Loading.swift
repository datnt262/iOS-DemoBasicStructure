//
//  Loading.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit
import SVProgressHUD

class Loading {
    static let shared = Loading()
    private init() {}
    
    func show(isHideLoading: Bool? = nil) {
        if isHideLoading != true{
            SVProgressHUD.setDefaultStyle(.light)
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.setDefaultAnimationType(.native)
            SVProgressHUD.show()
        }
    }
    
    func hide(isHideLoading: Bool? = nil) {
        if isHideLoading != true{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: DispatchWorkItem(block: {
                SVProgressHUD.dismiss()
            }))
        }
    }
}
