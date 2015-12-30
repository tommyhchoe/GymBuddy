//
//  MainViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/26/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit
import Parse

class MainTableViewController: UITableViewController {
    
    var currentUser: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
    }
    
    override func viewWillAppear(animated: Bool) {
        currentUser = PFUser.currentUser()
    }
    
    //MARK: Helper Methods
    
    func configView(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("logoutUser"))
    }
    
    func logoutUser(){
        print(currentUser)
        PFUser.logOut()
        if let cUser = PFUser.currentUser(){
            print(cUser)
        }else {
            print("There is no user logged in")
        }
        performSegueWithIdentifier("logoutUserSegue", sender: self)
    }
    
    //MARK: UITableViewDataSource && UITableViewDelegate Delegate Methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        return cell
    }
}














