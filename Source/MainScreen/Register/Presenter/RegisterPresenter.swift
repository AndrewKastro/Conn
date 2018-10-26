//
//  RegisterPresenter.swift
//  Conn
//
//  Created by Andrew Castro on 25/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import Foundation

protocol RegisterPresenterDelegate {
    func xxx()
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
    
    func attach(view:RegisterPresenterDelegate){
        self.delegate = view
    }
}

extension RegisterPresenter {
    
    func teste(_ text:String) {
        
    }
}
