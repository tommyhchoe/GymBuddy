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
    var gyms = Gyms()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //User currently using the app
        currentUser = PFUser.currentUser()
        if currentUser != nil{
            print("User is logged in!")
        }else{
            self.performSegueWithIdentifier("showLoginSegue", sender: self)
        }
    }
    
    //MARK: Helper Methods
    
    func configView(){
        
        //Setup navigationBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("addMyGym"))
        self.navigationItem.title = "My Gym"
        
        //Bind sidebar menu to the menu button
        if self.revealViewController() != nil{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: Selector("revealToggle:"))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func addMyGym(){
        print("Adding my gym")
    }
    
    func logoutUser(){
        print(currentUser)
        self.performSegueWithIdentifier("logoutUserSegue", sender: self)
    }
    
    //MARK: UITableViewDataSource && UITableViewDelegate Delegate Methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gyms.list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = gyms.list[indexPath.row].info["name"]
        cell.detailTextLabel!.text = gyms.list[indexPath.row].info["location"]
        cell.imageView?.image = UIImage(named: "Home-25")
        return cell
    }
}














