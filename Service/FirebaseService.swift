//
//  FirebaseService.swift
//  Conn
//
//  Created by Andrew Castro on 27/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    
    let successCreate = "SUCCESS"
    let errorCreate = "ERROR"
    
    func createUser(email:String, password:String, userName:String, errorCompletion:@escaping(_ error:String) -> Void, successCompletion:@escaping(_ success:String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = userName
                changeRequest?.commitChanges { error in
                    if error == nil {
                        self.saveProfile(userName: userName) { success in
                            if success {
                                successCompletion(self.successCreate)
                            }
                        }
                    }else{
                        errorCompletion(self.errorCreate)
                    }
                }
            }else{
                errorCompletion(self.errorCreate)
            }
        }
    }
    
    func saveProfile(userName:String, completion: @escaping ((_ success:Bool)->())) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseReference = Database.database().reference().child("users/profile/\(uid)")
        let userObject = [
            "username" : userName
        ]
        
        databaseReference.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
    func signInFirebase(_ email:String, password:String, errorCompletion:@escaping(_ error:String) -> Void, successCompletion:@escaping(_ success:String) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                successCompletion(self.successCreate)
            }else {
                errorCompletion(self.errorCreate)
            }
        }
    }
}
