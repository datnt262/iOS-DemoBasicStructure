//
//  LoginViewController.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import UIKit

class LoginViewController: BaseViewController {

    //UIs
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var btnLogin: BaseButton!
    @IBOutlet weak var lblError: UILabel!
    
    @IBOutlet weak var centerMainStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomBtnLoginConstraint: NSLayoutConstraint!
    //Properties
    let viewModel = LoginViewModel()
    
    //Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Functions
    override func setupLocalize() {
        title = "login_title_welcome".localized
        btnLogin.setTitle("login_title".localized, for: .normal)
        textFieldUsername.placeholder = "login_username".localized
        textFieldPassword.placeholder = "login_password".localized
    }
    
    override func bindingViewModel() {
        viewModel.errorMessage.observe(on: self) { [weak self] text in
            guard let self else {
                return
            }
            self.lblError.isHidden = text.isNil
            self.lblError.text = text
        }
        
        viewModel.loginResult.observe(on: self) { [weak self] result in
            guard let self else {
                return
            }
            if let result {
                //Login success
                self.showHomeVC(model: result)
            } else {
                //Login failed
                UIAlert.show(title: "login_error_title".localized,
                             message: "login_error_message".localized,
                             okTitle: "ok".localized,
                             cancelTitle: nil) {
                    Logger.event(message: "Alert OK clicked")
                } cancelCompletion: {
                    Logger.event(message: "Alert Cancel clicked")
                }
            }
        }
    }
    
    override func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        textFieldUsername.clearButtonMode = .whileEditing
        textFieldUsername.setLeftIcon(UIImage(systemName: "person.crop.circle.fill"))
        textFieldUsername.addTarget(self, action: #selector(textFieldBeginEdit), for: .editingDidBegin)

        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.setLeftIcon(UIImage(systemName: "lock"))
        textFieldPassword.setRightIcon(UIImage(systemName: "eye"))
        textFieldPassword.addTarget(self, action: #selector(textFieldBeginEdit), for: .editingDidBegin)
        
        lblError.textColor = .appColor(.error)
        lblError.font = .regular(size: 12)
        
        setupDismissKeyboard()
        addKeyboardObserver()
    }
    
    
    /// Move to home screen
    /// - Parameter model: login response model
    private func showHomeVC(model: LoginResponseModel) {
        let homeVC = HomeViewController.instantiate(from: .Main)
        homeVC.viewModel.userModel.value = model
        let navigationVC = BaseNavigationController(rootViewController: homeVC)
        Router.setRoot(vc: navigationVC)
    }
    
    override func keyboardDidUpdateFrame(frame: CGRect?) {
        let height = frame?.height ?? 0
        centerMainStackConstraint.constant = height == 0 ? -40 : -120
        bottomBtnLoginConstraint.constant = height == 0 ? 16 : height - 16
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    //@objc functions
    @objc
    func textFieldBeginEdit() {
        viewModel.errorMessage.value = nil
    }

    @IBAction func btnShowHidePasswordClicked(_ sender: Any) {
        Logger.event(message: "Show / Hide password clicked")
        if let button = sender as? UIButton {
            button.isSelected.toggle()
            let icon = button.isSelected ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
            textFieldPassword.setRightIcon(icon)
            textFieldPassword.isSecureTextEntry = !button.isSelected
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        Logger.event(message: "Button Login clicked")
        guard let username = textFieldUsername.text,
              let password = textFieldPassword.text else {
            Logger.error(message: "textFieldUsername / textFieldPassword is nil")
            return
        }
        viewModel.login(username: username, password: password)
    }
}
