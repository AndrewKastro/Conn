//
//  ViewController.swift
//  Conn
//
//  Created by Andrew Castro on 23/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit

//MARK: - CLASS, VARIABLE, LETS & IBOUTLETS -

class InitialScreenViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var firstGenericButton: UIButton!
    @IBOutlet weak var secondGenericButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    let presenter = LoginPresenter()
    
    private lazy var loginUser = LoginViewController()
    private lazy var registerUser = RegisterViewController()

}

//MARK: - LYFE CICLE -

extension InitialScreenViewController {
    
    override func viewDidLoad() {
        self.animateTransition()
        self.animateComponents(self.titlePage, self.firstGenericButton, self.secondGenericButton)
    }
}

//MARK: - IBACTIONS -

extension InitialScreenViewController {
    
    @IBAction func actionFirstGenericButton(_ sender: Any) {
        self.showLogin()
        self.hiddenButtons(self.firstGenericButton, self.secondGenericButton)
    }
    
    @IBAction func actionSecondGenericButton(_ sender: Any) {
        self.showRegister()
        self.hiddenButtons(self.firstGenericButton, self.secondGenericButton)
    }
}

//MARK: - AUX FUNCTIONS -

extension InitialScreenViewController {
    
    private func showLogin() {
        self.loginUser = LoginViewController()
        self.loginUser.delegate = self
        self.stackView.addArrangedSubview(self.loginUser.view)
    }
    
    private func showRegister() {
        self.registerUser = RegisterViewController()
        self.registerUser.delegate = self
        self.stackView.addArrangedSubview(self.registerUser.view)
        
    }
    
    private func deleteAllSubViewsIfNeeded() {
        let subviews = stackView.subviews
        if subviews.count > 0 {
            for subview in subviews {
                subview.removeFromSuperview()
            }
        }
    }
}

//MARK: - ANIMATE FUNCTIONS -

extension InitialScreenViewController {
    
    func animateTransition() {
        UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
            let transition = CATransition()
            transition.duration = CFTimeInterval(3.5)
            transition.type = CATransitionType.fade
            self.image.layer.add(transition, forKey: "transition")
            self.image.transform = CGAffineTransform(translationX: 0, y: 2.0)
        })
    }
}

//MARK: - DELEGATES -

extension InitialScreenViewController: RegisterViewControllerDelegate {
    
    func successRegister() {
        self.deleteAllSubViewsIfNeeded()
        self.animateComponents(self.titlePage, self.firstGenericButton, self.secondGenericButton)
        self.toastMessage("Conta criada com sucesso!")
    }
    
    func failRegister(_ context:Bool) {
        if !context{
            self.deleteAllSubViewsIfNeeded()
            self.animateComponents(self.titlePage, self.firstGenericButton, self.secondGenericButton)
        }else {
            self.toastMessage("Erro ao criar conta. \n Tente novamente!!")
        }
    }
}

extension InitialScreenViewController: LoginViewControllerDelegate {
    func cancelLogin() {
        self.deleteAllSubViewsIfNeeded()
        self.animateComponents(self.titlePage, self.firstGenericButton, self.secondGenericButton)
    }
}
