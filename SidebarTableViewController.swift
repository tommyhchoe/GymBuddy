//
//  SidebarTableViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 1/2/16.
//  Copyright © 2016 Tommy Choe. All rights reserved.
//

import UIKit
import Parse

class SidebarTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "logoutUserSegue"{
            PFUser.logOut()
        }
    }
    
    //MARK: -UITableViewController Delegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
