//
//  PostViewController.swift
//  Conn
//
//  Created by Andrew Castro on 28/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var limitCharacter: UILabel!
    @IBOutlet weak var viewMainPost: UIView!
    @IBOutlet weak var stackForm: UIStackView!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var opcionalField: UITextField!
    @IBOutlet weak var secondOpcionalField: UITextField!
    @IBOutlet weak var thirdOpcionalField: UITextField!
    @IBOutlet weak var themeField: UITextField!
    @IBOutlet weak var buttonCreatePost: UIButton!
    
    var userNamePost = ""
    
    var limitChars = 25
    var viewData:PostViewData?
    
    let presenter = PostPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.attach(view: self)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.titleTextfield.textColor = UIColor.black
        self.buttonCreatePost.isEnabled = false
        self.buttonCreatePost.backgroundColor = UIColor.gray
    }

}

extension PostViewController {
    
    @IBAction func actionCreatePost(_ sender: Any) {
        self.presenter.callCreatePost()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionBackHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PostViewController {
    
    func enabledButton(_ check:Bool){
        self.buttonCreatePost.isEnabled = check
        self.viewMainPost.reloadInputViews()
    }
}

extension PostViewController: PostPresenterDelegate {
    func successValidate(_ viewDataLogin:PostViewData) {
        self.viewData = viewDataLogin
        self.enabledButton(true)
        self.colorEnabledButton(true, self.buttonCreatePost)
    }
    
    func errorValidate() {
        self.enabledButton(false)
        self.colorEnabledButton(false, self.buttonCreatePost)
    }
    
    func successService() {
        self.toastMessage("Seu card foi criado com sucesso!")
        self.dismiss(animated: true, completion: nil)
    }
    
    func errorService() {
        self.toastMessage("Algo deu errado, tente novamente!")
    }
}

extension PostViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.presenter.startValidateAndSetPost(textField.text!, textField.accessibilityIdentifier!, self.userNamePost)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.accessibilityIdentifier == "titlePost" {
            guard let text = textField.text else { return true }
            
            let count = text.count + string.count - range.length
            if count == limitChars + 1 { return false }
            self.limitCharacter.text = "\(String(limitChars - count))"

            let color = count == limitChars ? UIColor.red : UIColor.black

            self.limitCharacter.textColor = color

            if count == limitChars + 1 {
                self.limitCharacter.text = "\(limitChars - (count - 1))"
            }

            return count < limitChars + 1
        }else {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            return count <= 15
        }
    }
    
}
