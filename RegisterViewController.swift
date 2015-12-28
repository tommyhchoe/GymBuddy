//
//  RegisterViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/25/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var wrapperScrollView: UIScrollView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    let imageFilename: String = "Icon-73"
    var didChangeImage = false
    var usersDatabase: UsersDatabase?
    
    let imagePicker = UIImagePickerController()
    var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.delegate = self
        self.usernameTextField.delegate = self
        self.emailTextField.delegate = self
        self.displayNameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.genderTextField.delegate = self
        self.ageTextField.delegate = self
        
        self.configView()
        self.registerForKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.resetScrollView()
    }
    
    //MARK: - PrepareForSegue Method
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "loginAsNewUserSegue"){
            if let dvc = segue.destinationViewController as? MainTableViewController{
                dvc.navigationItem.title = "Home"
                dvc.navigationItem.setHidesBackButton(true, animated: false)
                dvc.usersDatabase = self.usersDatabase
                let username = self.usersDatabase!.usersDictionary[self.usernameTextField.text!]
                dvc.currentUserUsername = username?.info["username"]
                dvc.currentUserPassword = username?.info["password"]
            }
        }
    }
    
    //MARK: - Helper Methods
    
    func configView(){
        
        //Add default image to profile pic
        self.imageButton.setImage(UIImage(named: imageFilename), forState: UIControlState.Normal)
        
        //Add indent to each TextField
        let paddingView1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
        self.emailTextField.leftView = paddingView1
        self.emailTextField.leftViewMode = .Always
        let paddingView2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
        self.displayNameTextField.leftView = paddingView2
        self.displayNameTextField.leftViewMode = .Always
        let paddingView3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
        self.passwordTextField.leftView = paddingView3
        self.passwordTextField.leftViewMode = .Always
        let paddingView4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
        self.genderTextField.leftView = paddingView4
        self.genderTextField.leftViewMode = .Always
        let paddingView5 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
        self.ageTextField.leftView = paddingView5
        self.ageTextField.leftViewMode = .Always
        let paddingView6 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
        self.usernameTextField.leftView = paddingView6
        self.usernameTextField.leftViewMode = .Always
        
        //Setup navigationItem
        self.navigationItem.title = "Register"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("loginAsNewUser"))
    }
    
    func resetScrollView(){
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        self.wrapperScrollView.contentInset = contentInsets
        self.wrapperScrollView.scrollIndicatorInsets = contentInsets
    }
    
    func loginAsNewUser(){
        
        if (self.loginErrorLabel.hidden == false){self.loginErrorLabel.hidden = true}
        
        //Check if any TextFields are empty
        if (!didChangeImage){
            self.loginErrorLabel.text = "Missing profile pic"
            self.toggleErrorLabel()
        }else if (displayNameTextField.text == ""){
            self.loginErrorLabel.text = "Missing display name"
            self.toggleErrorLabel()
        }else if (usernameTextField.text == ""){
            self.loginErrorLabel.text = "Missing username"
            self.toggleErrorLabel()
        }else if (emailTextField.text == ""){
            self.loginErrorLabel.text = "Missing email"
            self.toggleErrorLabel()
        }else if (passwordTextField.text == ""){
            self.loginErrorLabel.text = "Missing password"
            self.toggleErrorLabel()
        }else if (ageTextField.text == ""){
            self.loginErrorLabel.text = "Missing age"
            self.toggleErrorLabel()
        }else if (genderTextField.text == ""){
            self.loginErrorLabel.text = "Missing gender"
            self.toggleErrorLabel()
        }else{
            //Store new user info in UserDatabase
            usersDatabase!.addNewUser(self.usernameTextField.text!, displayName: self.displayNameTextField.text!, email: self.emailTextField.text!, profilePic: self.imageFilename, password: self.passwordTextField.text!, age: self.ageTextField.text!, gender: self.genderTextField.text!)
            performSegueWithIdentifier("loginAsNewUserSegue", sender: self)
        }
    }
    
    func toggleErrorLabel(){
        if (self.loginErrorLabel.hidden == true){
            self.loginErrorLabel.hidden = false
        }else{
            self.loginErrorLabel.hidden = true
        }
    }
    
    //Mark: - Keyboard Delegate Methods
    
    //Call this method somewhere in your view controller setup code.
    func registerForKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillBeHidden:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWasShown(aNotification: NSNotification){
        let info: NSDictionary = aNotification.userInfo!
        let kbSize: CGSize? = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize!.height, 0.0)
        self.wrapperScrollView.contentInset = contentInsets
        self.wrapperScrollView.scrollIndicatorInsets = contentInsets
        
        //If active text is invisible, scroll it so it's visible
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize!.height
        if let activeFieldPresent = activeField{
            if (!CGRectContainsPoint(aRect, activeFieldPresent.frame.origin)){
                self.wrapperScrollView.scrollRectToVisible(activeFieldPresent.frame, animated: true)
            }
        }
    }
    
    //Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWillBeHidden(aNotification: NSNotification){
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        self.wrapperScrollView.contentInset = contentInsets
        self.wrapperScrollView.scrollIndicatorInsets = contentInsets
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        activeField = textField
        if (self.loginErrorLabel.hidden == false){
            self.loginErrorLabel.hidden = true
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        activeField = nil
        if (self.loginErrorLabel.hidden == false){
            self.loginErrorLabel.hidden = true
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imageButton.setImage(image, forState: UIControlState.Normal)
        didChangeImage = true
        imageButton.imageView!.contentMode = .ScaleAspectFill
        
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    //MARK: - IBAction Methods
    
    @IBAction func changeProfileImage(sender: AnyObject) {
        //prepare UIImagePickerController to be displayed with the appropriate settings
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}
















