//
//  CommentsPresenter.swift
//  Conn
//
//  Created by Andrew Castro on 06/11/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import Foundation

protocol CommentsPresenterDelegate {
    func validateSuccess()
    func validateError()
}

struct CommentViewData {
    var comment = ""
}

class CommentsPresenter {
    
    var delegate:CommentsPresenterDelegate?
    var viewData = CommentViewData()
    
    let service = FirebaseService()
    
    func attach(view:CommentsPresenterDelegate){
        self.delegate = view
    }
}

extension CommentsPresenter {
    
    func commentValidate(_ textComment:String) {
        viewData.comment = !textComment.isEmpty ? textComment : ""
        let _ = !viewData.comment.isEmpty ? self.sendComment() : self.errorComment()
    }
    
    func sendComment() {
        self.service.createComment(viewData.comment, errorCompletion: { (error) in
            self.errorComment()
        }, successCompletion: { (success) in
            self.delegate?.validateSuccess()
        })
    }
    
    func errorComment() {
        self.delegate?.validateError()
    }
}
