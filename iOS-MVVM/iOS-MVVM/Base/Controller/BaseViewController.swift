//
//  BaseViewController.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupLocalize()
        setupUI()
        setupClosure()
        bindingViewModel()
    }
    
    //MARK: - Configuration
    
    /// Setup data for screen
    func setupData() {}
    
    /// Setup UI for screen
    func setupUI() {}
    
    /// Setup localize for all text.
    func setupLocalize() {}
    
    /// Binding from view model to view
    func bindingViewModel() {}
    
    /// Setup all closure for view controller
    func setupClosure() {}
    
    /// Override this to handle keyboard show / hide
    func keyboardDidUpdateFrame(frame:CGRect?) {}

    
    /// Dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        Logger.logs(type: .info, message: "deinit")
    }
}

extension BaseViewController {
    /// This will setup gesture to dismiss keyboard
    func setupDismissKeyboard() {
        self.view.isUserInteractionEnabled = true
        let dismissKeyboardAction = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardAction.cancelsTouchesInView = false
        let touchLocation = dismissKeyboardAction.location(in: view)
        if let button = view.hitTest(touchLocation, with: nil) as? UIButton, button.tag == 500 {
            // The touch occurred inside the button, so don't dismiss the keyboard
            return
        }
        view.addGestureRecognizer(dismissKeyboardAction)
    }
    
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        handleKeyboarNotification(notification: notification,isHide: false)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        handleKeyboarNotification(notification: notification,isHide: true)
    }
    
    private func handleKeyboarNotification(notification: NSNotification,isHide:Bool){
        if isHide {
            keyboardDidUpdateFrame(frame: nil)
        }else{
            guard let userInfo = notification.userInfo else { return }
            var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
            keyboardDidUpdateFrame(frame: keyboardFrame)
        }
    }
}
