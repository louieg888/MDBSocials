//
//  FeedViewController.swift
//  MDBSocials
//
//  Created by Louie McConnell on 9/27/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    var tableView: UITableView!
    var posts: [Post]?
    var numCells: Int!
    var selectedPost: Post!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Social Feed"
        self.addNewPostButton()
        
        
        self.setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func addNewPostButton() {
        let rightButtonItem = UIBarButtonItem.init(
            title: "New Post",
            style: .done,
            target: self,
            action: #selector(goToNewSocialVC)
        )
        navigationItem.rightBarButtonItem = rightButtonItem

    }
    
    func goToNewSocialVC() {
        self.performSegue(withIdentifier: "toNewSocialVC", sender: self)
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "feedCell")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if a cell is selected
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.post = (self.tableView.cellForRow(at: self.tableView.indexPathForSelectedRow!) as! FeedTableViewCell).post
        }
    }

}

extension FeedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // make it segue to the Detail
        self.performSegue(withIdentifier: "toDetailVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return number of cells; keep a variable for that
        // perhaps start at count; do a DB call
        return numCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // WARNING: CELL IS NOT PROPERLY MADE YET.
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
}
