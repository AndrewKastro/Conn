//
//  LoginPresenter.swift
//  Conn
//
//  Created by Andrew Castro on 24/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import Foundation

protocol LoginPresenterDelegate {
    func validateFields(_ viewDataLogin:TextFieldsViewDataLogin)
    func verifyValidate(_ validation:Bool)
}

struct TextFieldsViewDataLogin {
    var username = ""
    var password = ""
}

class LoginPresenter {
    
    var delegate:LoginPresenterDelegate?
    var fieldsViewData = TextFieldsViewDataLogin()
    
    func attach(view:LoginPresenterDelegate){
        self.delegate = view
    }
}

extension LoginPresenter {
    
    public func validateFieldsAndSet(_ field:String, _ identifier:String) {
        self.verifyIdentifier(field, identifier)
        if !self.fieldsViewData.username.isEmpty, !self.fieldsViewData.password.isEmpty {
            self.delegate?.validateFields(fieldsViewData)
        }else {
            self.delegate?.verifyValidate(false)
        }
    }
    
    func verifyIdentifier(_ field:String, _ identifier:String) {
        switch identifier {
        case "username":
            self.fieldsViewData.username = field
            break
        default:
            self.fieldsViewData.password = field
            break
        }
    }
}
