//
//  Extension.swift
//  Conn
//
//  Created by Andrew Castro on 23/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}

extension UIViewController {
    
    func hiddenButtons(_ firstButton:UIButton, _ secondButton:UIButton) {
        UIView.animate(withDuration: 0.45, animations: {
            firstButton.alpha = 0
        }, completion: { (true) in
            hiddenSecondButton()
        })
        
        func hiddenSecondButton(){
            UIView.animate(withDuration: 0.45, animations: {
                secondButton.alpha = 0
            })
        }
    }
    
    func animateComponents(_ titlePage:UILabel, _ firstButton:UIButton, _ secondButton:UIButton){
        UIView.animate(withDuration: 0.75, animations: {
            titlePage.alpha = 1
        }) { (true) in
            self.showButtonLogin(firstButton, secondButton)
        }
    }
    
    func showButtonLogin(_ firstButton:UIButton,  _ secondButton:UIButton){
        UIView.animate(withDuration: 0.75, animations: {
            firstButton.alpha = 1
        }, completion: { (true) in
            self.showButtonRegister(secondButton)
        })
    }
    
    func showButtonRegister(_ secondButton:UIButton){
        UIView.animate(withDuration: 0.75, animations: {
            secondButton.alpha = 1
        })
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func colorEnabledButton(_ enabled:Bool, _ button:UIButton) {
        button.backgroundColor = enabled ? UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1.0) : UIColor.gray
    }
    
    func toastMessage(_ message:String) {
        let message = message
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        let duration: Double = 2.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }
}

extension String {
    func isValidEmail(_ email:String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailValid = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailValid.evaluate(with: email)
    }
    
    public func insert(string:String,index:Int) -> String {
        return  String(self.prefix(index)) + string + String(self.suffix(self.count-index))
    }
}
