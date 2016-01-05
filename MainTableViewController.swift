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
    var userGyms = UserGyms()
    
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: Selector("addMyGym"))
        self.navigationItem.title = "My Gym"
        
        //Bind sidebar menu to the menu button
        if self.revealViewController() != nil{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "HMenu-20"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: Selector("revealToggle:"))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func addMyGym(){
        self.performSegueWithIdentifier("showGymSearchSegue", sender: self)
    }
    
    //MARK: UITableViewDataSource && UITableViewDelegate Delegate Methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGyms.list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if let name = userGyms.list[indexPath.row]?.info["name"],
            let location = userGyms.list[indexPath.row]?.info["location"]{
            cell.textLabel!.text = name
            cell.detailTextLabel!.text = location
        }else{
            cell.textLabel!.text = "Gym name"
            cell.detailTextLabel!.text = "Default location"
        }
        cell.imageView?.image = UIImage(named: "Home-25")
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}














