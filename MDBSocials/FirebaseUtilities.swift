//
//  FirebaseUtilities.swift
//  MDBSocials
//
//  Created by Louie McConnell on 9/28/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUtilities {
    
    static func addUser(dictVals: [String: String], password: String) {
        print(dictVals)
        print(password)
        let ref = Database.database().reference()
        ref.child("users").childByAutoId().setValue(dictVals)
        Auth.auth().createUser(withEmail: dictVals["email"]!, password: password, completion: { (user, error) in
            print(user)
        })
    }
    
    static func getEmailFromUsername(username: String, completionClosure: @escaping (_: String) -> ()) {
        let ref = Database.database().reference()
        ref.child("users").observe(.value, with: { (snapshot) in
            let value = snapshot.value as? [String:Any]
            if let users = value {
                for user in users {
                    if (user.value as? [String:String])?["username"] == username {
                        completionClosure(((user.value as? [String:String])?["email"]!)!)
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

