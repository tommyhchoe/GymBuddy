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
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var FBLoginButton: UIButton!
    @IBOutlet weak var messageLabelHeightConstraint: NSLayoutConstraint!
    
    var messageLabelIsHidden = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Make navigationItem title reappear
        self.navigationItem.title = "Sign In"
        
        //Set messageLabel visibility
        if !self.messageLabelIsHidden{
            self.messageLabel.text = "Your account has been created!"
            self.messageLabel.backgroundColor = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 0.8)
            self.toggleMessageLabel()
            self.messageLabelIsHidden = true
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if self.messageLabelHeightConstraint.constant == 30.0{
            self.toggleMessageLabel()
        }
    }
    
    //MARK: - PrepareForSegue Method
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "registerUserSegue"{
            self.navigationItem.title = nil
            let backItem = UIBarButtonItem()
            backItem.title = ""
            self.navigationItem.backBarButtonItem = backItem
        }
        
        if segue.identifier == "retrieveUserInfoSegue"{
            self.navigationItem.title = nil
            let backItem = UIBarButtonItem()
            backItem.title = ""
            self.navigationItem.backBarButtonItem = backItem
        }
    }
    
    //MARK: - Helper Methods
    
    func configView(){
        
        //Set all delegates
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        //Add indent to each TextField
        let textFieldList = [self.usernameTextField, self.passwordTextField]
        for textField in textFieldList{
            textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
            textField.leftViewMode = UITextFieldViewMode.Always
        }
        
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

    //User pressed login button
    func logInUser(){
        
        //Hide messageLabel before checking TextFields
        if self.messageLabelHeightConstraint.constant == 30.0{toggleMessageLabel()}
        
        //Disable login button
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        //Clear red borders around textFields
        self.usernameTextField.layer.borderWidth = 0.0
        self.passwordTextField.layer.borderWidth = 0.0
        
        //Check if any fields are missing first
        if self.usernameTextField.text == "" || self.passwordTextField.text == ""{
            self.messageLabel.text = "Missing field!"
            
            if self.usernameTextField.text == ""{
                self.usernameTextField.layer.borderWidth = 1.25
                self.usernameTextField.layer.borderColor = UIColor.redColor().CGColor
            }
            
            if self.passwordTextField.text == ""{
                self.passwordTextField.layer.borderWidth = 1.25
                self.passwordTextField.layer.borderColor = UIColor.redColor().CGColor
            }
            
            if self.messageLabel.backgroundColor == UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 0.8){
                self.messageLabel.backgroundColor = UIColor.redColor()
            }
            self.prepareToPresentMessage()
        }else{
            PFUser.logInWithUsernameInBackground(self.usernameTextField.text!, password: self.passwordTextField.text!){ (success, error) in
                if success != nil{
                    self.dismissViewControllerAnimated(true, completion: nil)
                    self.loginWasSuccessful()
                    self.navigationItem.rightBarButtonItem?.enabled = true
                }else{
                    self.messageLabel.text = "Username/Password combination is not recognized"
                    self.prepareToPresentMessage()
                }
            }
        }
    }
    
    func loginWasSuccessful(){
        print("login was Successful")
    }
    
    func registerNewUser(){
        performSegueWithIdentifier("registerUserSegue", sender: self)
    }
    
    func prepareToPresentMessage(){
        self.navigationItem.rightBarButtonItem?.enabled = true
        self.toggleMessageLabel()
    }
    
    func toggleMessageLabel(){
        if self.messageLabelHeightConstraint.constant == 0.0{
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.messageLabelHeightConstraint.constant += 30.0
                self.view.layoutIfNeeded()
                }, completion: nil)
        }else{
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.messageLabelHeightConstraint.constant -= 30.0
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    @IBAction func retrieveUserInfo(sender: AnyObject) {
        performSegueWithIdentifier("retrieveUserInfoSegue", sender: self)
    }
    
    //MARK: - TextField Delegate Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if self.messageLabelHeightConstraint.constant == 30.0{
            self.toggleMessageLabel()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.isEqual(self.usernameTextField){
            self.passwordTextField.becomeFirstResponder()
        }
        if textField.isEqual(self.passwordTextField){
            self.logInUser()
        }
        return true
    }
    
    //MARK: - IBAction Methods
    @IBAction func FBLoginButtonPressed(sender: AnyObject) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"]) { (user: PFUser?, error: NSError?) -> Void in
            if let user = user{
                if user.isNew{
                    print("User signed up and logged in through FB")
                }else{
                    print("User logged in through FB")
                }
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                print("Uh Oh. The user cancelled the Facebook login")
                self.messageLabel.text = "Uh Oh. Looks like you cancelled the Facebook login"
                self.toggleMessageLabel()
            }
        }
    }
}











