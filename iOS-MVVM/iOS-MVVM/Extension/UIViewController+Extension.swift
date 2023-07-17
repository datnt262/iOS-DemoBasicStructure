//
//  UIViewController+Extension.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 28/07/2022.
//

import UIKit

extension UIViewController {
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func push(vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func showNavigationBar() {
        navigationController?.isNavigationBarHidden = false
    }
    
    func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func commonPresent(vc: UIViewController, animated: Bool = true) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: animated)
    }
    
    func commonPopup(vc: UIViewController, animated: Bool = true) {
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: animated)
    }
    
    func heroPresent(vc: UIViewController, animated: Bool = true) {
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: animated)
    }
    
    func popupAlert(_ alertVC: UIAlertController, completion: (() -> Void)? = nil) {
        if let popoverPresentationController = alertVC.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = self.view.bounds
            popoverPresentationController.permittedArrowDirections = []
        }
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: completion)
        }
    }
}
