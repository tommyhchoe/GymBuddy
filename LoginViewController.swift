//
//  LoginViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/23/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginErrorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var FBLoginButton: UIButton!
    
    var errorLabelIsHidden = true

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
        
        //Set errorLabel visibility
        self.loginErrorLabel.hidden = self.errorLabelIsHidden
        if (self.errorLabelIsHidden == false){
            self.loginErrorLabel.text = "Your account has been created!"
            self.loginErrorLabel.backgroundColor = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 0.8)
        }
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
                dvc.navigationItem.title = "My Gyms"
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
        
        //Setup FBLoginButton
        self.FBLoginButton.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        self.FBLoginButton.setTitle("Login with Facebook", forState: UIControlState.Normal)
        self.FBLoginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.FBLoginButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
    }

    func logInUser(){
        
        //Hide errorLabel before checking TextFields
        if (self.loginErrorLabel.hidden == false){self.loginErrorLabel.hidden = true}
        
        if (usernameTextField.text == ""){
            self.loginErrorLabel.text = "Username not entered!"
            if (self.loginErrorLabel.backgroundColor == UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 0.8)){
                self.loginErrorLabel.backgroundColor = UIColor.redColor()
            }
            self.toggleErrorLabel()
        }else if (passwordTextField.text == ""){
            self.loginErrorLabel.text = "Password not entered!"
            if (self.loginErrorLabel.backgroundColor == UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 0.8)){
                self.loginErrorLabel.backgroundColor = UIColor.redColor()
            }
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
    
    @IBAction func retrieveUserInfo(sender: AnyObject) {
        performSegueWithIdentifier("retrieveUserInfoSegue", sender: self)
    }
    
    //MARK: - TextField Delegate Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (self.loginErrorLabel.hidden == false){
            self.loginErrorLabel.hidden = true
        }
    }
    @IBAction func FBLoginButtonPressed(sender: AnyObject) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"]) { (user: PFUser?, error: NSError?) -> Void in
            if let user = user{
                if user.isNew{
                    print("User signed up and logged in through FB")
                }else{
                    print("User logged in through FB")
                }
                self.performSegueWithIdentifier("loginUserSegue", sender: self)
            }else{
                print("Uh Oh. The user cancelled the Facebook login")
                self.loginErrorLabel.text = "Uh Oh. Looks like you cancelled the Facebook login"
                self.toggleErrorLabel()
            }
        }
    }
}











