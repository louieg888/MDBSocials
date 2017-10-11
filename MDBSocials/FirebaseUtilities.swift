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
                    let returnValue: [String:String] = [
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
        // let usersRef = Database.database().reference().child("users")
        
        let postsRef = Database.database().reference().child("posts").childByAutoId()
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
    
    static func getNumberOfPosts(callback: @escaping (Int) -> ()) {
        let postsRef = Database.database().reference().child("posts")
        postsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            callback(Int(snapshot.childrenCount))
        })
    }
    
    static func getPostForIndex(indexPath: IndexPath, callback: @escaping (Post) -> ()) {
        let index = indexPath.row
        Database.database().reference().child("posts")
            .queryOrdered(byChild: "timePosted")
            .queryLimited(toLast: UInt(50))
            .observeSingleEvent(of: .value, with: { (snapshot) in
                /*
                for child in (snapshot as! DataSnapshot).children.allObjects {
                    print(ch)
                }
                */
                let newIndex = Int(Int(snapshot.childrenCount) - 1) - index
                let desiredValue = (snapshot.children.allObjects[newIndex] as! DataSnapshot).value as! [String:Any]
                let newPost = Post(id: (snapshot.children.allObjects[newIndex] as! DataSnapshot).key, postDict: desiredValue)
                print(desiredValue)
                callback(newPost)

                
            })
    }
    
    static func retrieveImageFromUrl(url: String, callback: @escaping (UIImage) -> ()) {
        Storage.storage().reference(withPath: url).getData(maxSize: 100 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)!
                callback(image)
            }
        }
    }
}

