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
    
    @IBOutlet weak var viewRegister: UIView!
    @IBOutlet weak var stackViewRegister: UIStackView!
    @IBOutlet weak var stackViewButton: UIStackView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var createRegister: UIButton!
    @IBOutlet weak var cancelRegister: UIButton!
    
    var delegate:RegisterViewControllerDelegate?
    var viewDataRegister:TextFieldsViewDataRegister?
    
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
        self.presenter.attach(view: self)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.createRegister.isEnabled = false
        self.createRegister.backgroundColor = UIColor.gray
    }
}

extension RegisterViewController {
    func enabledButton(_ enabled:Bool) {
        self.createRegister.isEnabled = enabled
        self.viewRegister.reloadInputViews()
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.presenter.validateFieldsAndSet(textField.text!, textField.accessibilityIdentifier!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if zipCode.tag == textField.tag {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            if updatedText.count == 6 && !currentText.contains("-"){
                textField.text = currentText.insert(string: "-", index: 5)
                return true
            }
            return updatedText.count < 10
        }
        return true
    }
}

extension RegisterViewController: RegisterPresenterDelegate {
    func getValuesAndSet(_ viewData: TextFieldsViewDataRegister) {
        self.viewDataRegister = viewData
        self.enabledButton(true)
        self.colorEnabledButton(true, self.createRegister)
    }
    
    func setError() {
        self.enabledButton(true)
        self.colorEnabledButton(false, self.createRegister)
    }
 
}
