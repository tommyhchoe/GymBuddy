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
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(false)
        
        //Make navigationItem title reappear
        self.navigationItem.title = "Sign In"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "registerUserSegue"){
            self.navigationItem.title = nil
        }
        
        if (segue.identifier == "retrieveUserInfoSegue"){
            self.navigationItem.title = nil
        }
        
        if (segue.identifier == "loginUserSegue"){
            if let dvc = segue.destinationViewController as? MainViewController{
                dvc.navigationItem.title = "Home"
                dvc.navigationItem.setHidesBackButton(true, animated: false)
            }
            print("Successful verification!")
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

        if (usernameTextField.text == ""){
            print("Username not entered!")
        }else if (passwordTextField.text == ""){
            print("Password not entered!")
        }else{
            print("Verifying user credentials...")
            if (self.usernameTextField.text == "tchoe") && (self.passwordTextField.text == "whyyoualwayslying1234"){
                performSegueWithIdentifier("loginUserSegue", sender: self)
            }else{
                print("Wrong username/password combination")
            }
        }
    }
    
    func registerNewUser(){
        performSegueWithIdentifier("registerUserSegue", sender: self)
    }
    
    //MARK: - IBAction Methods
    
    @IBAction func loginToFacebook(sender: AnyObject) {
        print("Logging in to Facebook")
    }
    @IBAction func loginToGooglePlus(sender: AnyObject) {
        print("Logging in to Google+")
    }
    @IBAction func retrieveUserInfo(sender: AnyObject) {
        performSegueWithIdentifier("retrieveUserInfoSegue", sender: self)
    }
}











