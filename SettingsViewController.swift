//
//  SettingsViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 1/2/16.
//  Copyright © 2016 Tommy Choe. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Bind sidebar menu to the menu button
        if self.revealViewController() != nil{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: Selector("revealToggle:"))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
