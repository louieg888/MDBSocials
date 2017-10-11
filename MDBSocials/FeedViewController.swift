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
        self.updateNumberOfPosts()
        self.setupTableView()
        // Do any additional setup after loading the view.
    }

    func updateNumberOfPosts() {
        numCells = 0
        FirebaseUtilities.getNumberOfPosts(callback: { (numPosts) in
            self.numCells = numPosts
            self.tableView.reloadData()
        })
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
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "feedCell")
        view.addSubview(tableView)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if a cell is selected
        
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! DetailViewController
            let cell = (self.tableView.cellForRow(at: self.tableView.indexPathForSelectedRow!) as! FeedTableViewCell)
            detailVC.post = cell.post
        }
    }
}

extension FeedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // make it segue to the Detail
        self.performSegue(withIdentifier: "toDetailVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numCells
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        self.updateAllFieldsAsynchronously(indexPath: indexPath, cell: cell)
        
        return cell
    }
    
    func updateAllFieldsAsynchronously(indexPath: IndexPath, cell: FeedTableViewCell) {
        FirebaseUtilities.getPostForIndex(indexPath: indexPath, callback: { (post) in
            cell.post = post
            // load and update cell eventNameLabel
            cell.eventNameLabel.text = post.postName
            
            // load and update cell eventCreatorLabel
            cell.eventCreatorLabel.text = "Created by \(String(describing: post.posterName!))"
            
            // load and update the interested count
            if let inters = cell.post.interested {
                // do some cool stuff
                // TODO: Implement
            }
            
            // load and update image
            FirebaseUtilities.retrieveImageFromUrl(url: post.imageUrl!, callback: { (img) in
                DispatchQueue.main.async {
                    cell.eventImageView.image = img
                }
                //self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            })
            
        })
    }
}
