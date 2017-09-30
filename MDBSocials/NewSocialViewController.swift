//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by Louie McConnell on 9/27/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit
import MobileCoreServices
import FirebaseAuth


class NewSocialViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var eventNameTextField: TextField!
    var descriptionTextView: UITextView!
    
    var startDateLabel: UILabel!
    var startDateTextField: TextField!
    var startDate: Date!
    
    var endDateLabel: UILabel!
    var endDateTextField: TextField!
    var endDate: Date!
    
    var eventImageView: UIImageView!
    var picker: UIImagePickerController = UIImagePickerController()
    var submitButton: UIButton!
    
    let placeholderTextColor = UIColor(colorLiteralRed: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Post"
        self.view.backgroundColor = UIColor(red: 64/255, green: 174/255, blue: 246/255, alpha: 1)

        addEventNameTextField()
        addDecriptionTextView()
        addStartDateLabel()
        addStartDateTextField()
        addEndDateLabel()
        addEndDateTextField()
        addEventImageView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(createPost))
    }
    
    func createPost() {
        /*    
         var postName: String?
         var postDescription: String?
         var imageUrl: String?
         var posterId: String?
         var posterName: String?
         var id: String?
         var image: UIImage?
         var intersted: [String]? // string of user ids
         var timePosted: Int?
        */
        
        //TODO: fix this shit
        
        var postDict: [String:Any] = [
            "postName": eventNameTextField.text!,
            "postDescription": descriptionTextView.text!,
            "imageUrl": "", // update this in the addpost method.
            "posterId": Auth.auth().currentUser?.uid ?? "posterId",
            "posterName": "default",    // fix
            "interested": [],
            "timePosted": String(NSDate().timeIntervalSince1970),
            "startTime" : startDateLabel.text!,
            "endTime": endDateLabel.text!
        ]
        
        FirebaseUtilities.getUserInfo(callback: { (userInfo) in
            let uid = userInfo["uid"]
            let name = userInfo["name"]
            postDict["posterId"] = uid
            postDict["posterName"] = name
            
            FirebaseUtilities.storePhotoAndGetUrl(image: self.eventImageView.image!, callback: { (imgUrl) in
                postDict["imageUrl"] = imgUrl
                let newPost = Post(id: (Auth.auth().currentUser?.uid)!, postDict: postDict)
                FirebaseUtilities.addPost(post: newPost, image: self.eventImageView.image!)
                self.navigationController?.popViewController(animated: true)
            })
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if startDate != nil {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            
            startDateTextField.text = formatter.string(from: startDate)
        }
        
        if endDate != nil {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            
            endDateTextField.text = formatter.string(from: endDate)
        }
    }

    func addEventNameTextField() {
        eventNameTextField = TextField()
        eventNameTextField.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: 75,
            width: 0.8 * view.frame.width,
            height: 40
        )
        // eventNameTextField.layer.borderWidth = 1
        eventNameTextField.backgroundColor = UIColor.white
        eventNameTextField.layer.cornerRadius = 16
        eventNameTextField.placeholder = "event name"
        view.addSubview(eventNameTextField)
    }
    
    func addDecriptionTextView() {
        descriptionTextView = UITextView()
        descriptionTextView.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: eventNameTextField.frame.maxY + 10,
            width: 0.8 * view.frame.width,
            height: 60
        )
        //descriptionTextView.layer.borderWidth = 1

        descriptionTextView.font = eventNameTextField.font
        descriptionTextView.textContainerInset = UIEdgeInsets.init(top: 10, left: 15, bottom: 10, right: 15)
        descriptionTextView.layer.cornerRadius = 16
        descriptionTextView.delegate = self
        descriptionTextView.text = "event description"
        descriptionTextView.textColor = self.placeholderTextColor
        descriptionTextView.backgroundColor = UIColor.white
        descriptionTextView.textContainer.maximumNumberOfLines = 2
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail

        view.addSubview(descriptionTextView)
    }
    
    func addStartDateLabel() {
        startDateLabel = UILabel()
        startDateLabel.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: descriptionTextView.frame.maxY + 10,
            width: 0.2 * view.frame.width,
            height: 40
        )
        startDateLabel.text = "Start Time"
        startDateLabel.textColor = UIColor.white
        //startDateLabel.layer.borderWidth = 1
        view.addSubview(startDateLabel)
    }
    
    func addStartDateTextField() {
        startDateTextField = TextField()
        startDateTextField.frame = CGRect(
            x: startDateLabel.frame.maxX + 10,
            y: startDateLabel.frame.minY,
            width: view.frame.width * 0.8 - startDateLabel.frame.width - 10,
            height: startDateLabel.frame.height
        )
        startDateTextField.layer.cornerRadius = 16
        startDateTextField.delegate = self
        startDateTextField.backgroundColor = UIColor.white
        startDateTextField.placeholder = "tap here"
        startDateTextField.textAlignment = .right
        // startDateTextField.layer.borderWidth = 1
        startDateTextField.layer.borderColor = UIColor.black.cgColor
        view.addSubview(startDateTextField)
    }
    
    func addEndDateLabel() {
        endDateLabel = UILabel()
        endDateLabel.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: startDateTextField.frame.maxY + 10,
            width: 0.2 * view.frame.width,
            height: 40
        )
        endDateLabel.textColor = UIColor.white
        endDateLabel.text = "End Time"
        //endDateLabel.layer.borderWidth = 1
        view.addSubview(endDateLabel)
    }
    
    func addEndDateTextField() {
        endDateTextField = TextField()
        endDateTextField.frame = CGRect(
            x: endDateLabel.frame.maxX + 10,
            y: endDateLabel.frame.minY,
            width: view.frame.width * 0.8 - startDateLabel.frame.width - 10,
            height: startDateLabel.frame.height
        )
        endDateTextField.layer.cornerRadius = 16
        endDateTextField.backgroundColor = UIColor.white
        endDateTextField.delegate = self
        endDateTextField.placeholder = "tap here"
        endDateTextField.textAlignment = .right
        // endDateTextField.layer.borderWidth = 1
        endDateTextField.layer.borderColor = UIColor.black.cgColor
        view.addSubview(endDateTextField)
    }
    
    func addEventImageView() {
        eventImageView = UIImageView()
        eventImageView.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: endDateTextField.frame.maxY + 10,
            width: 0.8 * view.frame.width,
            height: 200
        )
        eventImageView.image = #imageLiteral(resourceName: "default-landscape")
        eventImageView.clipsToBounds = true
        eventImageView.contentMode = .scaleAspectFill
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        eventImageView.isUserInteractionEnabled = true
        eventImageView.addGestureRecognizer(tapGestureRecognizer)
        
        view.addSubview(eventImageView)
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: nil, message: "How would you like to select your photo?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let chooseFromPhotoRoll = UIAlertAction(title: "Choose From Photo Roll", style: .default) { action in
            self.picker.delegate = self
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        
        alertController.addAction(chooseFromPhotoRoll)
        
        let takeNewPhoto = UIAlertAction(title: "Take New Photo", style: .default) { action in
            self.picker.delegate = self
            self.picker.allowsEditing = false
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)        }
        alertController.addAction(takeNewPhoto)
        
        self.present(alertController, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

extension NewSocialViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == self.placeholderTextColor {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "event description"
            textView.textColor = self.placeholderTextColor
        }
    }
    // start stackoverflow
    func sizeOfString (string: String, constrainedToWidth width: Double, font: UIFont) -> CGSize {
        return (string as NSString).boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude),
                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                         attributes: [NSFontAttributeName: font],
                                                         context: nil).size
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        var textWidth = UIEdgeInsetsInsetRect(textView.frame, textView.textContainerInset).width
        textWidth -= 2.0 * textView.textContainer.lineFragmentPadding;
        
        let boundingRect = sizeOfString(string: newText, constrainedToWidth: Double(textWidth), font: textView.font!)
        let numberOfLines = boundingRect.height / textView.font!.lineHeight;
        
        return numberOfLines <= 2;
    }
    //end stackoverflow
}

extension NewSocialViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: "toDatePickerVC", sender: self)
        return false
    }
}

extension NewSocialViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        eventImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
