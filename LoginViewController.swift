//
//  LoginViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/23/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.configView()
    }
    
    //MARK: - Helper Methods
    func configView(){
        
        //Setup navigationItem for ViewController
        self.navigationItem.title = "Sign In"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("logInUser"))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("registerNewUser"))
    }

    func logInUser(){
        print("Verifying user credentials...")
    }
    
    func registerNewUser(){
        print("Register new user in process...")
        performSegueWithIdentifier("registerUserSegue", sender: self)
    }
    @IBAction func loginToFacebook(sender: AnyObject) {
        print("Logging in to Facebook")
    }
    @IBAction func loginToGooglePlus(sender: AnyObject) {
        print("Logging in to Google+")
    }
}











