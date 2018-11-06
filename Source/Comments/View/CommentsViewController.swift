//
//  CommentsViewController.swift
//  Conn
//
//  Created by Andrew Castro on 31/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    let presenter = CommentsPresenter()
    
    @IBOutlet weak var commentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.attach(view: self)
    }
}

extension CommentsViewController {
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addComment(_ sender: Any) {
        self.presenter.commentValidate(commentTextView.text)
    }
}

extension CommentsViewController: CommentsPresenterDelegate {
    func validateSuccess() {
        self.toastMessage("Comentário criado com sucesso!!!")
    }
    
    func validateError() {
        self.toastMessage("Preencha o campo!!!")
    }
    
    
    
}
