//
//  LoginViewController.swift
//  Conn
//
//  Created by Andrew Castro on 24/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit

//MARK: - PROTOCOL -

protocol LoginViewControllerDelegate {
    func cancelLogin()
}

//MARK: - CLASS, VARIABLES, LETS & IBOUTLETS -

class LoginViewController: UIViewController {
    
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var stackViewLogin: UIStackView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var cancelLogin: UIButton!
    
    let presenter = LoginPresenter()
    let service = FirebaseService()
    
    var delegate:LoginViewControllerDelegate?
    var viewData:TextFieldsViewDataLogin?

}

//MARK: - LYFE CICLE -

extension LoginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.attach(view: self)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loginButton.isEnabled = false
        self.loginButton.backgroundColor = UIColor.gray
    }
}

//MARK: - IBACTIONS -

extension LoginViewController {

    @IBAction func actionLogin(_ sender: Any) {
        self.presenter.signInUser()
    }
    
    @IBAction func actionCancelLogin(_ sender: Any) {
        self.delegate?.cancelLogin()
    }
}

extension LoginViewController {
    
    func enabledButton(_ enabled:Bool) {
        self.loginButton.isEnabled = enabled
        self.viewLogin.reloadInputViews()
    }
}

//MARK: - DELEGATES -

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.presenter.validateFieldsAndSet(textField.text!, textField.accessibilityIdentifier!)
    }
}

extension LoginViewController: LoginPresenterDelegate {
    func successLogin() {
        let controller = UIStoryboard.init(name: "HomeViewController", bundle: nil).instantiateViewController(withIdentifier: "homepage") as? HomeViewController
        controller?.userNamePost = self.viewData!.username
        self.present(controller ?? UIViewController(), animated: true, completion: nil)
    }
    
    func failLogin() {
        self.toastMessage("Email ou senha inválidos!!")
    }
    
    func validateFields(_ viewDataLogin:TextFieldsViewDataLogin) {
        self.viewData = viewDataLogin
        self.enabledButton(true)
        self.colorEnabledButton(true, self.loginButton)
    }
    
    func verifyValidate(_ validation:Bool) {
        self.enabledButton(validation)
        self.colorEnabledButton(false, self.loginButton)
    }
}
