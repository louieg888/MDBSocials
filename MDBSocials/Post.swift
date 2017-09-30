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
    var interested: [String]? // string of user ids
    var timePosted: String?
    var postDict: [String:Any]?
    var startTime: String?
    var endTime: String?
    
    init(id: String, postDict: [String:Any]?) {
        self.id = id
        self.postDict = postDict
        
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
            if let postDescription = postDict!["postDescription"] as? String {
                self.postDescription = postDescription
            }
            if let posterName = postDict!["posterName"] as? String {
                self.posterName = posterName
            }
            if let timePosted = postDict!["timePosted"] as? String {
                self.timePosted = timePosted
            }
            if let interested = postDict!["interested"] as? [String] {
                self.interested = interested
            } else {
                self.interested = []
            }
            if let startTime = postDict!["startTime"] as? String {
                self.startTime = startTime
            }
            if let endTime = postDict!["endTime"] as? String {
                self.endTime = endTime
            }
        }
    }
    
    func getJSONifiedPostDict() -> String {
        var jsonData: Data = Data()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: postDict!, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8)!
        } catch {
            print(error.localizedDescription)
        }
        return "failed"
    }
    
    /*
    init() {
        self.postName = "This is a god dream"
        self.imageUrl = "https://cmgajcmusic.files.wordpress.com/2016/06/kanye-west2.jpg"
        self.id = "1"
        self.posterName = "Kanye West"
    }
    */
    
    func getProfilePic(withBlock: @escaping () -> ()) {
        //TODO: Get User's profile picture
        
    }
}
