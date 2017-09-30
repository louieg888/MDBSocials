//
//  DatePickerViewController.swift
//  MDBSocials
//
//  Created by Louie McConnell on 9/29/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    var startDateLabel: UILabel!
    var startDatePicker: UIDatePicker!
    var endDateLabel: UILabel!
    var endDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Start Time"
        self.view.backgroundColor = UIColor.white
        addSaveButton()
        
        addStartDateLabel()
        addStartDatePicker()
        addEndDateLabel()
        addEndDatePicker()
    }
    
    func addStartDateLabel() {
        startDateLabel = UILabel()
        startDateLabel.frame = CGRect(
            x: self.view.center.x - 50,
            y: self.view.frame.height * 0.1 + 20,
            width: 100,
            height: 40
        )
        startDateLabel.textAlignment = .center
        startDateLabel.text = "Start Date"
        view.addSubview(startDateLabel)
    }
    
    func addStartDatePicker() {
        
        startDatePicker = UIDatePicker()
        
        // setting properties of the datePicker
        startDatePicker.frame = CGRect(
            x: 0.1 * self.view.frame.width,
            y: startDateLabel.frame.maxY + 20,
            width: 0.8 * self.view.frame.width,
            height: 0.3 * self.view.frame.height
        )
        startDatePicker.timeZone = NSTimeZone.local
        startDatePicker.layer.cornerRadius = 5.0
        
        self.view.addSubview(startDatePicker)
    }
    
    func addEndDateLabel() {
        endDateLabel = UILabel()
        endDateLabel.frame = CGRect(
            x: self.view.center.x - 50,
            y: startDatePicker.frame.maxY + 20,
            width: 100,
            height: 40
        )
        endDateLabel.textAlignment = .center
        endDateLabel.text = "End Date"
        view.addSubview(endDateLabel)
    }
    
    func addEndDatePicker() {
        endDatePicker = UIDatePicker()
        
        // setting properties of the datePicker
        endDatePicker.frame = CGRect(
            x: 0.1 * self.view.frame.width,
            y: endDateLabel.frame.maxY + 20,
            width: 0.8 * self.view.frame.width,
            height: 0.3 * self.view.frame.height
        )
        endDatePicker.timeZone = NSTimeZone.local
        endDatePicker.layer.cornerRadius = 5.0
        
        self.view.addSubview(endDatePicker)
    }
    
    func addSaveButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(dismissVC))
    }
    
    func dismissVC() {
        let newSocialVC = navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 2] as! NewSocialViewController
        newSocialVC.startDate = startDatePicker.date
        newSocialVC.endDate = endDatePicker.date
        self.navigationController?.popViewController(animated: true)
        

    }
}
