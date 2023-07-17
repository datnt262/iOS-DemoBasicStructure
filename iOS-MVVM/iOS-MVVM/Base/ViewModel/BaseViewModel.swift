//
//  BaseViewModel.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import Foundation

class BaseViewModel: NSObject {
    var isLoading: Observable<Bool> = Observable(false)
    
    override init() {
        super.init()
        
        isLoading.observe(on: self) { [weak self] in
            self?.handleLoading(isLoading: $0)
        }
    }
    
    /// Handle show / hide loading
    /// - Parameter isLoading: true if loading
    private func handleLoading(isLoading: Bool) {
        if isLoading {
            Loading.shared.show()
        } else {
            Loading.shared.hide()
        }
    }
}
