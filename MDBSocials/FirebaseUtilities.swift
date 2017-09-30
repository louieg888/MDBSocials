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
    
    static func addUser(dictVals: [String: String], password: String, success: @escaping () -> ()) {
        print(dictVals)
        print(password)
        let ref = Database.database().reference()
        ref.child("users").childByAutoId().setValue(dictVals)
        Auth.auth().createUser(withEmail: dictVals["email"]!, password: password, completion: { (user, error) in
            if user != nil {
                Auth.auth().signIn(withEmail: dictVals["email"]!, password: password, completion: {(user, error) in 
                    success()
                })
            }
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
    
    static func getUID(callback: @escaping (String) -> ()) {
        Database.database().reference().child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let unwrappedChild = child as! DataSnapshot
                if (unwrappedChild.value as! Dictionary)["email"]! == (Auth.auth().currentUser?.email!) {
                    callback(unwrappedChild.key)
                    break
                }
            }
        })
    }
    
    static func getName(callback: @escaping (String) -> ()) {
        Database.database().reference().child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let unwrappedChild = child as! DataSnapshot
                if (unwrappedChild.value as! Dictionary)["email"]! == (Auth.auth().currentUser?.email!) {
                    callback((unwrappedChild.value as! Dictionary)["name"]!)
                    break
                }
            }
        })
    }
    
    static func getUserInfo(callback: @escaping ([String:String]) -> ()) {
        Database.database().reference().child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let unwrappedChild = child as! DataSnapshot
                if (unwrappedChild.value as! Dictionary)["email"]! == (Auth.auth().currentUser?.email!) {
                    var returnValue: [String:String] = [
                        "email": (unwrappedChild.value as! Dictionary)["email"]!,
                        "username": (unwrappedChild.value as! Dictionary)["username"]!,
                        "name": (unwrappedChild.value as! Dictionary)["name"]!,
                        "uid": unwrappedChild.key
                    ]
                    
                    callback(returnValue)
                    break
                }
            }
        })
    }
    
    static func addPost(post: Post, image: UIImage) {
        let usersRef = Database.database().reference().child("users")
        let postsRef = Database.database().reference().child("posts").childByAutoId()
        // TODO: upload the image to storage and add the URL to the post object. For now just don't deal with it.
        postsRef.setValue(post.postDict)
    }
    
    static func storePhotoAndGetUrl(image: UIImage, callback: (String) -> ()) {
        let uuid = UUID.init().description
        let path = "images/\(uuid)/img.jpg"
        let imgMeta = StorageMetadata()
        imgMeta.contentType = "image/jpg"
        Storage.storage().reference().child(path).putData((UIImageJPEGRepresentation(image, 1.0))!, metadata: imgMeta)
        callback(path)
    }
}

