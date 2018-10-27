//
//  RegisterPresenter.swift
//  Conn
//
//  Created by Andrew Castro on 25/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import Foundation

protocol RegisterPresenterDelegate {
    func getValuesAndSet(_ viewData:TextFieldsViewDataRegister)
    func setError()
}

struct TextFieldsViewDataRegister {
    var username = ""
    var password = ""
    var email = ""
    var zipcode = ""
}

class RegisterPresenter {
    
    var delegate:RegisterPresenterDelegate?
    var fieldsViewData = TextFieldsViewDataRegister()
    var fields = [TextFieldsViewDataRegister]()
    
    func attach(view:RegisterPresenterDelegate){
        self.delegate = view
    }
}

extension RegisterPresenter {
    
    func validateFieldsAndSet(_ text:String, _ identifier:String) {
        self.setValueInProperties(text, identifier)
        self.verifyProperties()
    }
    
    func verifyProperties() {
        if !self.fieldsViewData.username.isEmpty, !self.fieldsViewData.password.isEmpty, !self.fieldsViewData.email.isEmpty, !self.fieldsViewData.zipcode.isEmpty, self.fieldsViewData.email.isValidEmail(self.fieldsViewData.email) {
            self.delegate?.getValuesAndSet(self.fieldsViewData)
        }else {
            self.delegate?.setError()
        }
    }
    
    func setValueInProperties(_ text:String, _ identifier:String) {
        switch identifier {
        case "username":
            self.fieldsViewData.username = text
            break
        case "password":
            self.fieldsViewData.password = text
            break
        case "email":
            self.fieldsViewData.email = text
            break
        default:
            self.fieldsViewData.zipcode = text
            break
        }
    }
}
