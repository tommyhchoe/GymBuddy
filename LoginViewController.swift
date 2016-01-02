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
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var FBLoginButton: UIButton!
    @IBOutlet weak var errorLabelHeightConstraint: NSLayoutConstraint!
    
    var errorLabelIsHidden = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Make navigationItem title reappear
        self.navigationItem.title = "Sign In"
        
        //Set errorLabel visibility
        if (!self.errorLabelIsHidden){
            self.errorLabel.text = "Your account has been created!"
            self.errorLabel.backgroundColor = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 0.8)
            self.toggleErrorLabel()
            self.errorLabelIsHidden = true
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (self.errorLabelHeightConstraint.constant == 30.0){
            self.toggleErrorLabel()
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
        
        //Hide errorLabel before checking TextFields
        if (self.errorLabelHeightConstraint.constant == 30.0){toggleErrorLabel()}
        
        //Disable login button
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        //Clear red borders around textFields
        self.usernameTextField.layer.borderWidth = 0.0
        self.passwordTextField.layer.borderWidth = 0.0
        
        //Check if any fields are missing first
        if (self.usernameTextField.text == "" || self.passwordTextField.text == ""){
            self.errorLabel.text = "Missing field!"
            
            if (self.usernameTextField.text == ""){
                self.usernameTextField.layer.borderWidth = 1.25
                self.usernameTextField.layer.borderColor = UIColor.redColor().CGColor
            }
            
            if (self.passwordTextField.text == ""){
                self.passwordTextField.layer.borderWidth = 1.25
                self.passwordTextField.layer.borderColor = UIColor.redColor().CGColor
            }
            
            if (self.errorLabel.backgroundColor == UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 0.8)){
                self.errorLabel.backgroundColor = UIColor.redColor()
            }
            self.prepareToPresentError()
        }else{
            PFUser.logInWithUsernameInBackground(self.usernameTextField.text!, password: self.passwordTextField.text!){
                (success, error) in
                if (success != nil){
                    self.performSegueWithIdentifier("loginUserSegue", sender: self)
                }else{
                    self.errorLabel.text = "Username/Password combination is not recognized"
                    self.prepareToPresentError()
                }
            }
        }
    }
    
    func registerNewUser(){
        performSegueWithIdentifier("registerUserSegue", sender: self)
    }
    
    func prepareToPresentError(){
        self.navigationItem.rightBarButtonItem?.enabled = true
        self.toggleErrorLabel()
    }
    
    func toggleErrorLabel(){
        if (self.errorLabelHeightConstraint.constant == 0.0){
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.errorLabelHeightConstraint.constant += 30.0
                self.view.layoutIfNeeded()
                }, completion: nil)
        }else{
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.errorLabelHeightConstraint.constant -= 30.0
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    @IBAction func retrieveUserInfo(sender: AnyObject) {
        performSegueWithIdentifier("retrieveUserInfoSegue", sender: self)
    }
    
    //MARK: - TextField Delegate Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (self.errorLabelHeightConstraint.constant == 30.0){
            self.toggleErrorLabel()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField.isEqual(self.usernameTextField)){
            self.passwordTextField.becomeFirstResponder()
        }
        if (textField.isEqual(self.passwordTextField)){
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
                self.performSegueWithIdentifier("loginUserSegue", sender: self)
            }else{
                print("Uh Oh. The user cancelled the Facebook login")
                self.errorLabel.text = "Uh Oh. Looks like you cancelled the Facebook login"
                self.toggleErrorLabel()
            }
        }
    }
}











