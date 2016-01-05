//
//  GymSearchContainerViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 1/4/16.
//  Copyright © 2016 Tommy Choe. All rights reserved.
//

import UIKit

class GymSearchContainerViewController: UIViewController, TableListener {
    
    var tableVC: GymSearchTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Setup navigationBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("cancelSearch"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("finishAddingGym"))
        self.navigationItem.title = "Find your gym"
    }
    
    //MARK: -Helper Methods
    
    func cancelSearch(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func finishAddingGym(){
        print("Something magical is being added")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -GymSearchTableViewController Delegate Methods
    
    func needAddButton() {
        print("Do something here")
        
        //Add the + button when user adds a check to a table cell)
        
    }
    
    func deleteAddButton(){
        print("Delete add button yo")
        
        //Delete the + button when user has no more checks on table cells
        self.navigationItem.rightBarButtonItem?.enabled = false
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toChildSegue"{
            if let dvc = segue.destinationViewController as? GymSearchTableViewController{
                tableVC = dvc
            }
        }
    }

}
