//
//  MainViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/26/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var usersDatabase: UsersDatabase?
    
    var currentUserUsername: String?
    var currentUserPassword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
        
    print(self.usersDatabase?.usersDictionary[currentUserUsername!]!.info["profilePic"]!)
        print(self.usersDatabase?.usersDictionary.keys.count)
    }
    
    //MARK: Helper Methods
    
    func configView(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("logoutUser"))
    }
    
    func logoutUser(){
        performSegueWithIdentifier("logoutUserSegue", sender: self)
    }
    
    //MARK: UITableViewDataSource && UITableViewDelegate Delegate Methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let userCount = self.usersDatabase?.usersDictionary.keys.count{
            return userCount
        }else{
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if let users = self.usersDatabase?.usersDictionary{
            for (_, userInfo) in users{
                cell.imageView?.image = UIImage(named: userInfo.info["profilePic"]!)
                cell.textLabel?.text = userInfo.info["displayName"]
            }
        }
        
        return cell
    }
}














