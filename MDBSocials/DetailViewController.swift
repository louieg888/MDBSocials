//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Louie McConnell on 9/27/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var post: Post!
    
    var imageView: UIImageView!
    var eventTitleLabel: UILabel!
    var createdByLabel: UILabel!
    var descriptionTextView: UITextView!
    var startDateLabel: UILabel!
    
    var interestedButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Event Details"
        self.addImageView()
        self.addEventTitle()
        self.addCreatedBy()
        self.addDescription()
        self.addStartDateLabel()
        self.addInterestedButton()
        
        // Do any additional setup after loading the view.
    }
    
    func addImageView() {
        imageView = UIImageView()
        imageView.frame = CGRect(
            x: view.frame.width * 0.1,
            y: view.frame.width * 0.1 + 60,
            width: view.frame.width * 0.8,
            height: view.frame.width * 0.8
        )
        FirebaseUtilities.retrieveImageFromUrl(url: post.imageUrl!) { (img) in
            self.imageView.image = img
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
    }
    
    func addEventTitle() {
        eventTitleLabel = UILabel(frame: CGRect(x: Double(0.1 * view.frame.width), y: Double(imageView.frame.maxY + view.frame.width * 0.1 - 30), width: Double(view.frame.width * 0.8), height: Double(35)))
        eventTitleLabel.text = post.postName
        eventTitleLabel.font = eventTitleLabel.font.withSize(30)
        eventTitleLabel.textAlignment = .center
        view.addSubview(eventTitleLabel)
    }
    
    func addCreatedBy() {
        createdByLabel = UILabel(frame: CGRect(x: Double(0.1 * view.frame.width), y: Double(eventTitleLabel.frame.maxY) + 10, width: Double(view.frame.width * 0.8), height: Double(20)))
        createdByLabel.text = "created by \(String(describing: post.posterName!))"
        createdByLabel.font = createdByLabel.font.withSize(15)
        createdByLabel.textColor = UIColor.lightGray
        createdByLabel.textAlignment = .center
        view.addSubview(createdByLabel)
    }
    
    func addDescription() {
        descriptionTextView = UITextView(frame: CGRect(
            x: 0.1 * view.frame.width,
            y: createdByLabel.frame.maxY + 20,
            width: 0.8 * view.frame.width,
            height: 50
        ))
        descriptionTextView.isEditable = false
        descriptionTextView.text = post.postDescription
        descriptionTextView.textAlignment = .center
        descriptionTextView.font = descriptionTextView.font?.withSize(19)
        descriptionTextView.backgroundColor = UIColor.white
        descriptionTextView.textContainer.maximumNumberOfLines = 2
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail
        
        view.addSubview(descriptionTextView)
    }
    
    func addStartDateLabel() {
        startDateLabel = UILabel(frame: CGRect(x: Double(0.1 * view.frame.width), y: Double(descriptionTextView.frame.maxY + 30), width: Double(view.frame.width * 0.8), height: Double(35)))
        startDateLabel.text = post.startTime
        startDateLabel.font = startDateLabel.font.withSize(30)
        startDateLabel.textColor = UIColor.black
        startDateLabel.textAlignment = .center
        view.addSubview(startDateLabel)
    }
    
    func addInterestedButton() {
        interestedButton = UIButton()
        interestedButton.frame = CGRect(
            x: self.view.center.x - 0.4*view.frame.width,
            y: self.view.frame.height - 60,
            width: 0.8 * view.frame.width,
            height: 40
        )
        interestedButton.setTitle("interested", for: .normal)
        interestedButton.setTitleColor(UIColor.white, for: .normal)
        interestedButton.layer.cornerRadius = 16
        interestedButton.backgroundColor = UIColor(red: 64/255, green: 174/255, blue: 246/255, alpha: 1)
        interestedButton.contentHorizontalAlignment = .center
        interestedButton.addTarget(self, action: #selector(indicateInterested), for: .touchUpInside)
        self.view.addSubview(interestedButton)
    }
    
    func indicateInterested() {
        // TODO: Implement
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
