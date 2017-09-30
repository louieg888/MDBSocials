//
//  FeedTableViewCell.swift
//  MDBSocials
//
//  Created by Louie McConnell on 9/28/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    var eventName: String!
    var eventCreator: String!
    var userIsInterested: Bool!
    var numIntersted: Int!
    
    var eventImageView: UIImageView!
    var eventNameLabel: UILabel!
    var eventCreatorLabel: UILabel!
    var interestedButton: UIButton!
    
    var cellImage: UIImage!
    
    var post: Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
        setupEventLabel()
        setupCreatorLabel()
        setupInterestedButton()
    }
    
    func setupImageView() {
        eventImageView = UIImageView()
        eventImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: contentView.frame.height - 10,
            height: contentView.frame.height - 10
        )
        eventImageView.image = #imageLiteral(resourceName: "default-landscape")
        eventImageView.clipsToBounds = true
        eventImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(eventImageView)
    }
    
    func setupEventLabel() {
        eventNameLabel = UILabel()
        eventNameLabel.frame = CGRect(
            x: eventImageView.frame.maxX + 10,
            y: eventImageView.frame.minY,
            width: 300,
            height: 36
        )
        eventNameLabel.font = UIFont(name: "Helvetica Neue", size: 26)
        eventNameLabel.textAlignment = .left
        eventNameLabel.text = "Default Event Name"
        contentView.addSubview(eventNameLabel)
    }
    
    func setupCreatorLabel() {
        eventCreatorLabel = UILabel()
        eventCreatorLabel.frame = CGRect(
            x: eventNameLabel.frame.minX,
            y: eventNameLabel.frame.maxY + 10,
            width: 300,
            height: 20
        )
        eventCreatorLabel.font = UIFont(name: "Helvetica Neue", size: 18)
        eventCreatorLabel.textColor = UIColor.lightGray
        eventCreatorLabel.textAlignment = .left
        eventCreatorLabel.text = "Created by: (Creator)"
        contentView.addSubview(eventCreatorLabel)
    }
    
    func setupInterestedButton() {
        interestedButton = UIButton()
        interestedButton.frame = CGRect(
            x: eventCreatorLabel.frame.minX,
            y: eventImageView.frame.maxY - 30,
            width: 250,
            height: 30
        )
        interestedButton.setTitle("Interested (0)", for: .normal)
        interestedButton.layer.cornerRadius = 5
        interestedButton.setTitleColor(UIColor.black, for: .normal)
        interestedButton.layer.borderWidth = 1
        //TODO: Add a target for the interested button
        contentView.addSubview(interestedButton)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
