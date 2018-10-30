//
//  UserService.swift
//  Conn
//
//  Created by Andrew Castro on 30/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import Foundation
import Firebase

class UserService {
    
    static var currentUserProfile:UserProfile?
    
    static func observeUserProfile(_ userId:String, completion: @escaping ((_ userProf:UserProfile?)-> ())) {
        
        let userReference = Database.database().reference().child("users/profile/\(userId)")
        
        userReference.observe(.value, with: { snapshot in
            var userProfile:UserProfile?
            
            if let dict = snapshot.value as? [String:Any], let username = dict["username"] as? String {
                userProfile = UserProfile(userId: snapshot.key, username: username)
            }
            completion(userProfile)
        })
    }
}
