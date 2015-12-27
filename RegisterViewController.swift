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
    
    let imageFilename: String = "Icon-73"
    var didChangeImage = false
    var userDatabase: UserDatabase?
    
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
    
    func resetScrollView(){
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        self.wrapperScrollView.contentInset = contentInsets
        self.wrapperScrollView.scrollIndicatorInsets = contentInsets
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
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        activeField = nil
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
            
            //Store new user info in UserDatabase
            userDatabase = UserDatabase(username: usernameTextField.text!, displayName: displayNameTextField.text!, email: emailTextField.text!, profilePic: self.imageFilename, password: passwordTextField.text!, age: ageTextField.text!, gender: genderTextField.text!)
            if let username = userDatabase!.userDictionary["username"], displayName = userDatabase!.userDictionary["displayName"], email = userDatabase!.userDictionary["email"], password = userDatabase!.userDictionary["password"], age = userDatabase!.userDictionary["age"], gender = userDatabase!.userDictionary["gender"], profilePic = userDatabase!.userDictionary["profilePic"]{
                
                print("New user created with username \(username), password \(password), email \(email), displayName \(displayName), profilePic \(profilePic), age \(age), and gender \(gender).")
                performSegueWithIdentifier("loginAsNewUserSegue", sender: self)
            }
        }
    }
    
    @IBAction func changeProfileImage(sender: AnyObject) {
        print("Change the profile image")
        //prepare UIImagePickerController to be displayed with the appropriate settings
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imageButton.setImage(image, forState: UIControlState.Normal)
        didChangeImage = true
        imageButton.imageView!.contentMode = .ScaleAspectFill
        
        dismissViewControllerAnimated(false, completion: nil)
    }
}
















