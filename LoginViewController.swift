//
//  LoginViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/23/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginErrorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    
        self.configView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        
        //Make navigationItem title reappear
        self.navigationItem.title = "Sign In"
    }
    
    //MARK: - PrepareForSegue Method
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "registerUserSegue"){
            self.navigationItem.title = nil
            let backItem = UIBarButtonItem()
            backItem.title = ""
            self.navigationItem.backBarButtonItem = backItem
        }
        
        if (segue.identifier == "retrieveUserInfoSegue"){
            self.navigationItem.title = nil
            let backItem = UIBarButtonItem()
            backItem.title = ""
            self.navigationItem.backBarButtonItem = backItem
        }
        
        if (segue.identifier == "loginUserSegue"){
            if let dvc = segue.destinationViewController as? MainTableViewController{
                dvc.navigationItem.title = "Home"
                dvc.navigationItem.setHidesBackButton(true, animated: false)
            }
        }
    }
    
    //MARK: - Helper Methods
    
    func configView(){
        
        //Add indent to each TextField
        let paddingView1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
        usernameTextField.leftView = paddingView1
        usernameTextField.leftViewMode = UITextFieldViewMode.Always
        let paddingView2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
        passwordTextField.leftView = paddingView2
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        
        //Setup navigationItem for ViewController
        self.navigationItem.title = "Sign In"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("logInUser"))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("registerNewUser"))
    }

    func logInUser(){
        
        //Hide errorLabel before checking TextFields
        if (self.loginErrorLabel.hidden == false){self.loginErrorLabel.hidden = true}
        
        if (usernameTextField.text == ""){
            self.loginErrorLabel.text = "Username not entered!"
            self.toggleErrorLabel()
        }else if (passwordTextField.text == ""){
            self.loginErrorLabel.text = "Password not entered!"
            self.toggleErrorLabel()
        }else{
            PFUser.logInWithUsernameInBackground(self.usernameTextField.text!, password: self.passwordTextField.text!){
                (success, error) in
                if (success != nil){
                    self.performSegueWithIdentifier("loginUserSegue", sender: self)
                }else{
                    self.loginErrorLabel.text = "Username/Password combination is not recognized"
                    self.toggleErrorLabel()
                }
            }
        }
    }
    
    func registerNewUser(){
        performSegueWithIdentifier("registerUserSegue", sender: self)
    }
    
    func toggleErrorLabel(){
        if (self.loginErrorLabel.hidden == true){
            self.loginErrorLabel.hidden = false
        }else{
            self.loginErrorLabel.hidden = true
        }
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
    
    //MARK: - TextField Delegate Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (self.loginErrorLabel.hidden == false){
            self.loginErrorLabel.hidden = true
        }
    }
}











