//
//  CommentsViewController.swift
//  Conn
//
//  Created by Andrew Castro on 31/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit

protocol CommentsViewControllerDelegate {
    func showMessage()
}

class CommentsViewController: UIViewController {
    
    let presenter = CommentsPresenter()
    var delegate:CommentsViewControllerDelegate?
    
    @IBOutlet weak var commentTextView: UITextView!
    
    func attach(view:CommentsViewControllerDelegate){
        self.delegate = view
    }

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
        self.dismiss(animated: true, completion: nil)
        self.delegate?.showMessage()
    }
    
    func validateError() {
        self.toastMessage("Preencha o campo!!!")
    }
}
