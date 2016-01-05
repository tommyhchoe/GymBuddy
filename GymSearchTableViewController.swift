//
//  GymSearchTableViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 1/3/16.
//  Copyright © 2016 Tommy Choe. All rights reserved.
//

import UIKit

protocol TableListener{
    func needAddButton()
    func deleteAddButton()
}

class GymSearchTableViewController: UITableViewController {
    
    var gyms = Gyms()
    
    var delegate: TableListener?
    
    var cellCheckCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.delegate = GymSearchContainerViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gyms.list.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if let name = self.gyms.list[indexPath.row].info["name"],
            let location = self.gyms.list[indexPath.row].info["location"],
            let profilePic = self.gyms.list[indexPath.row].info["profilePic"]{
                cell.textLabel!.text = name
                cell.detailTextLabel!.text = location
                cell.imageView?.image = UIImage(named: profilePic)
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
            if cell.accessoryType != UITableViewCellAccessoryType.Checkmark{
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                self.cellCheckCounter++
                self.delegate!.needAddButton()
            }else{
                cell.accessoryType = UITableViewCellAccessoryType.None
                self.cellCheckCounter--
                if self.cellCheckCounter == 0{
                    self.delegate!.deleteAddButton()
                }
            }
        }

        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
