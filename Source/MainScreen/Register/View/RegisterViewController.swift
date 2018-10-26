//
//  RegisterViewController.swift
//  Conn
//
//  Created by Andrew Castro on 24/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit

//MARK: - PROTOCOL -

protocol RegisterViewControllerDelegate {
    func cancelRegister()
}

//MARK: - CLASS, VARIABLES, LETS & IBOUTLETS -

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var stackViewRegister: UIStackView!
    @IBOutlet weak var stackViewButton: UIStackView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var createRegister: UIButton!
    @IBOutlet weak var cancelRegister: UIButton!
    
    var delegate:RegisterViewControllerDelegate?
    
    let presenter = RegisterPresenter()
    let username = "username"
    let password = "password"
    let email = "email"

}

//MARK: - IBACTIONS -

extension RegisterViewController {
    
    @IBAction func actionCreateRegister(_ sender: Any) {
        
    }
    
    @IBAction func actionCancelRegister(_ sender: Any) {
        self.delegate?.cancelRegister()
    }
}

//MARK: - LYFE CICLE -

extension RegisterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.createRegister.isEnabled = false
        self.createRegister.backgroundColor = UIColor.gray
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField.accessibilityIdentifier {
        case self.username:
            self.presenter.teste(usernameTextField.text!)
            break
        case self.password:
            self.presenter.teste(passwordTextField.text!)
            break
        case self.email:
            self.presenter.teste(emailTextField.text!)
            break
        default:
            self.presenter.teste(zipCode.text!)
            break
        }
    }
    
}
