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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "registerUserSegue"){
            
        }
    }
    
    //MARK: - Helper Methods
    func configView(){
        
        //Add indent to each TextField
        let paddingView1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 30.0))
        usernameTextField.leftView = paddingView1
        usernameTextField.leftViewMode = UITextFieldViewMode.Always
        let paddingView2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 30.0))
        passwordTextField.leftView = paddingView2
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        
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
    
    //MARK: - IBAction Methods
    @IBAction func loginToFacebook(sender: AnyObject) {
        print("Logging in to Facebook")
    }
    @IBAction func loginToGooglePlus(sender: AnyObject) {
        print("Logging in to Google+")
    }
}











