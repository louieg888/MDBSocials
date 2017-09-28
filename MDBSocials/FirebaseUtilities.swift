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
        let ref = Database.database().reference()
        ref.child("users").childByAutoId().setValue(dictVals)
        Auth.auth().createUser(withEmail: dictVals["email"]!, password: password, completion: nil)
    }
}

