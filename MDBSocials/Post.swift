//
//  Event.swift
//  MDBSocials
//
//  Created by Louie McConnell on 9/28/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import Foundation
import UIKit

class Post {
    var postName: String?
    var postDescription: String?
    var imageUrl: String?
    var posterId: String?
    var posterName: String?
    var id: String?
    var image: UIImage?
    var intersted: [String]? // string of user ids
    var timePosted: Int?
    var rsvps: [String]? // string of user ids
    
    
    init(id: String, postDict: [String:Any]?) {
        self.id = id
        if postDict != nil {
            if let postName = postDict!["postName"] as? String {
                self.postName = postName
            }
            if let imageUrl = postDict!["imageUrl"] as? String {
                self.imageUrl = imageUrl
            }
            if let posterId = postDict!["posterId"] as? String {
                self.posterId = posterId
            }
            if let posterName = postDict!["posterName"] as? String {
                self.posterName = posterName
            }
        }
    }
    
    init() {
        self.postName = "This is a god dream"
        self.imageUrl = "https://cmgajcmusic.files.wordpress.com/2016/06/kanye-west2.jpg"
        self.id = "1"
        self.posterName = "Kanye West"
    }
    
    func getProfilePic(withBlock: @escaping () -> ()) {
        //TODO: Get User's profile picture
        
    }
}
