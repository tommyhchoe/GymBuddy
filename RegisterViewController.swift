//
//  RegisterViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/25/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var wrapperScrollView: UIScrollView!
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var FBLoginButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    @IBOutlet weak var genderPickerView: UIPickerView!
    @IBOutlet weak var agePickerView: UIPickerView!
    
    let defaultImage: String = "Icon-73"
    var didChangeImage = false
    
    let imagePicker = UIImagePickerController()
    var activeField: UITextField?
    
    var errorLabelIsHidden = true
    let genderOptions = ["Male", "Female", "Other", "Would Rather Not Say"]
    let ageOptions = [13,14,15,16,17]
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        //Set errorLabel visibility
        self.loginErrorLabel.hidden = self.errorLabelIsHidden
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.resetScrollView()
    }
    
    //MARK: - PrepareForSegue Method
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "loginAsNewUserSegue"){
            if let dvc = segue.destinationViewController as? LoginViewController{
                dvc.navigationItem.setHidesBackButton(true, animated: false)
                dvc.errorLabelIsHidden = false
            }
        }
        if (segue.identifier == "registerNewFBUserSegue"){
            if let dvc = segue.destinationViewController as? MainTableViewController{
                dvc.navigationItem.title = "My Gyms"
                dvc.navigationItem.setHidesBackButton(true, animated: false)
            }
        }
    }
    
    //MARK: - Helper Methods
    
    func configView(){
        
        //Add default image to profile pic
        self.imageButton.setImage(UIImage(named: self.defaultImage), forState: UIControlState.Normal)
        
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
        self.genderTextField.text = self.genderOptions[0]
        let paddingView5 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
        self.ageTextField.leftView = paddingView5
        self.ageTextField.leftViewMode = .Always
        let paddingView6 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
        self.usernameTextField.leftView = paddingView6
        self.usernameTextField.leftViewMode = .Always
        
        //Setup navigationItem
        self.navigationItem.title = "Register"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("registerAsNewUser"))
        
        //Setup UIPickerView
        self.genderPickerView.delegate = self
        self.agePickerView.delegate = self
        
        //Setup FBLoginButton
        self.FBLoginButton.setTitle("Register with Facebook", forState: UIControlState.Normal)
        self.FBLoginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.FBLoginButton.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        self.FBLoginButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
    }
    
    func resetScrollView(){
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        self.wrapperScrollView.contentInset = contentInsets
        self.wrapperScrollView.scrollIndicatorInsets = contentInsets
    }
    
    func registerAsNewUser(){
        
        if (self.loginErrorLabel.hidden == false){self.loginErrorLabel.hidden = true}
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        //Check if any TextFields are empty
        if (!didChangeImage){
            self.loginErrorLabel.text = "Missing profile pic"
            self.toggleErrorLabel()
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else if (displayNameTextField.text == ""){
            self.loginErrorLabel.text = "Missing display name"
            self.toggleErrorLabel()
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else if (usernameTextField.text == ""){
            self.loginErrorLabel.text = "Missing username"
            self.toggleErrorLabel()
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else if (emailTextField.text == ""){
            self.loginErrorLabel.text = "Missing email"
            self.toggleErrorLabel()
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else if (passwordTextField.text == ""){
            self.loginErrorLabel.text = "Missing password"
            self.toggleErrorLabel()
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else if (ageTextField.text == ""){
            self.loginErrorLabel.text = "Missing age"
            self.toggleErrorLabel()
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else if (genderTextField.text == ""){
            self.loginErrorLabel.text = "Missing gender"
            self.toggleErrorLabel()
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else{
            //Store new user info in Parse Core
            self.createNewUser(self.usernameTextField.text!, displayName: self.displayNameTextField.text!, email: self.emailTextField.text!, profilePic: self.imageButton.imageView!.image!, password: self.passwordTextField.text!, age: self.ageTextField.text!, gender: self.genderTextField.text!)
        }
    }
    
    //Create new user on Parse.com
    func createNewUser(username: String, displayName: String, email: String, profilePic: UIImage, password: String, age: String, gender: String){
        
        let user = PFUser()
        if let imageData = UIImagePNGRepresentation(profilePic),
            let imageFile = PFFile(data: imageData){
                
                user.username = username
                user.password = password
                user.email = email
                user["displayName"] = displayName
                user["profilePic"] = imageFile
                user["age"] = age
                user["gender"] = gender
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    if (error == nil){
                        self.performSegueWithIdentifier("loginAsNewUserSegue", sender: self)
                    }else{
                        let errorCode = error!.code
                        switch(errorCode){
                        case PFErrorCode.ErrorConnectionFailed.rawValue:
                            self.loginErrorLabel.text = "Connection failed."
                        case PFErrorCode.ErrorUserEmailTaken.rawValue:
                            self.loginErrorLabel.text = "Email is already taken."
                        case PFErrorCode.ErrorUsernameTaken.rawValue:
                            self.loginErrorLabel.text = "Username is already taken."
                        default:
                            self.loginErrorLabel.text = "Something went wrong. Try again."
                            break
                        }
                        self.toggleErrorLabel()
                        self.navigationItem.rightBarButtonItem?.enabled = true
                    }
                })
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
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if (textField.isEqual(self.genderTextField)){
            self.genderPickerView.hidden = false
            return false
        }else if (textField.isEqual(self.ageTextField)) {
            self.agePickerView.hidden = false
            return false
        }else {
            return true
        }
    }
    
    //MARK: - UIPickerView Delegate Methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.isEqual(self.genderPickerView)){
            return self.genderOptions.count
        }else {
            return self.ageOptions.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.isEqual(self.genderPickerView)){
            self.genderTextField.text = self.genderOptions[row]
            self.genderPickerView.hidden = true
        }else{
            self.ageTextField.text = String(self.ageOptions[row])
            self.agePickerView.hidden = true
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.isEqual(self.genderPickerView)){
            return self.genderOptions[row]
        }else {
            return String(self.ageOptions[row])
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
    @IBAction func FBLoginButtonPressed(sender: AnyObject) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"]) { (user: PFUser?, error: NSError?) -> Void in
            if let user = user{
                if user.isNew{
                    print("User signed up and logged in through FB")
                }else{
                    print("User logged in through FB")
                }
                self.performSegueWithIdentifier("registerNewFBUserSegue", sender: self)
            }else{
                print("Uh Oh. The user cancelled the Facebook login")
                self.loginErrorLabel.text = "Uh Oh. Looks like you cancelled the Facebook login"
                self.toggleErrorLabel()
            }
        }
    }
}




