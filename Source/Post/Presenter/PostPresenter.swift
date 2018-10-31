//
//  PostPresenter.swift
//  Conn
//
//  Created by Andrew Castro on 29/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import Foundation

protocol PostPresenterDelegate {
    func successValidate(_ viewDataLogin:PostViewData)
    func errorValidate()
    func successService()
    func errorService()
}

struct PostViewData {
    var title = ""
    var optionalField = ""
    var secondOptionalField = ""
    var thirdOptionalField = ""
    var theme = ""
}

class PostPresenter {
    
    var username = ""
    
    var delegate:PostPresenterDelegate?
    var postViewData = PostViewData()
    
    let service = FirebaseService()
    
    func attach(view:PostPresenterDelegate){
        self.delegate = view
    }
    
}

extension PostPresenter {
    
    func startValidateAndSetPost(_ text:String, _ identifier:String, _ username:String){
        self.username = username
        self.validateFieldsAndSet(text, identifier)
        let _ = self.verifyViewData() ? self.delegate?.successValidate(self.postViewData) : self.delegate?.errorValidate()
    }
    
    func verifyViewData() -> Bool{
        if !self.postViewData.title.isEmpty, !self.postViewData.optionalField.isEmpty, !self.postViewData.secondOptionalField.isEmpty, !self.postViewData.thirdOptionalField.isEmpty, !self.postViewData.theme.isEmpty {
            return true
        }
        return false
    }
    
    func validateFieldsAndSet(_ text:String, _ identifier:String) {
        switch identifier {
        case "titlePost":
            self.postViewData.title = text
            break
        case "optionalField":
            self.postViewData.optionalField = text
            break
        case "SecondOptionalField":
            self.postViewData.secondOptionalField = text
            break
        case "ThirdOptionalField":
            self.postViewData.thirdOptionalField = text
            break
        default:
            self.postViewData.theme = text
        }
    }
    
    func callCreatePost() {
        self.service.createPost(self.postViewData.title, self.postViewData.theme, self.postViewData.optionalField, self.postViewData.secondOptionalField, self.postViewData.thirdOptionalField, self.username, errorCompletion: { (error) in
            self.delegate?.errorService()
        }, successCompletion: { (success) in
            self.delegate?.successService()
        })
    }
}
