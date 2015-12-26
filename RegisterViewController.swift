//
//  RegisterViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/25/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    let imageFilename: String = "Icon-72"
    var didChangeImage = false
    var userDatabase: UserDatabase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "loginAsNewUserSegue"){
            if let dvc = segue.destinationViewController as? MainViewController{
                dvc.navigationItem.title = "Home"
                dvc.navigationItem.setHidesBackButton(true, animated: false)
            }
        }
    }
    
    //MARK: - Helper Methods
    
    func configView(){
        
        //Add default image to profile pic
        imageButton.setImage(UIImage(named: imageFilename), forState: UIControlState.Normal)
        
        //Add indent to each TextField
        let paddingView1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 30.0))
        emailTextField.leftView = paddingView1
        emailTextField.leftViewMode = UITextFieldViewMode.Always
        let paddingView2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 30.0))
        displayNameTextField.leftView = paddingView2
        displayNameTextField.leftViewMode = UITextFieldViewMode.Always
        let paddingView3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 30.0))
        passwordTextField.leftView = paddingView3
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        let paddingView4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 30.0))
        genderTextField.leftView = paddingView4
        genderTextField.leftViewMode = UITextFieldViewMode.Always
        let paddingView5 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 30.0))
        ageTextField.leftView = paddingView5
        ageTextField.leftViewMode = UITextFieldViewMode.Always
        let paddingView6 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 30.0))
        usernameTextField.leftView = paddingView6
        usernameTextField.leftViewMode = UITextFieldViewMode.Always
        
        //Setup navigationItem
        self.navigationItem.title = "Register"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("loginAsNewUser"))
    }
    
    func loginAsNewUser(){
        
        //Check if any TextFields are empty
        if (!didChangeImage){
            print("Missing profile pic")
        }else if (displayNameTextField.text == ""){
            print("Missing display name")
        }else if (usernameTextField.text == ""){
            print("Missing username")
        }else if (emailTextField.text == ""){
            print("Missing email")
        }else if (passwordTextField.text == ""){
            print("Missing password")
        }else if (ageTextField.text == ""){
            print("Missing age")
        }else if (genderTextField.text == ""){
            print("Missing gender")
        }else{
            userDatabase = UserDatabase(username: usernameTextField.text!, displayName: displayNameTextField.text!, email: emailTextField.text!, profilePic: self.imageFilename, password: passwordTextField.text!, age: ageTextField.text!, gender: genderTextField.text!)
            if let username = userDatabase!.userDictionary["username"], displayName = userDatabase!.userDictionary["displayName"], email = userDatabase!.userDictionary["email"], password = userDatabase!.userDictionary["password"], age = userDatabase!.userDictionary["age"], gender = userDatabase!.userDictionary["gender"], profilePic = userDatabase!.userDictionary["profilePic"]{
                
                print("New user created with username \(username), password \(password), email \(email), displayName \(displayName), profilePic \(profilePic), age \(age), and gender \(gender).")
                performSegueWithIdentifier("loginAsNewUserSegue", sender: self)
            }
        }
    }
    
    @IBAction func changeProfileImage(sender: AnyObject) {
        print("Change the profile image")
        didChangeImage = true
    }
}
















