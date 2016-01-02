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
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var genderPickerView: UIPickerView!
    @IBOutlet weak var agePickerView: UIPickerView!
    
    var didChangeImage = false
    
    let imagePicker = UIImagePickerController()
    var keyboardSize: CGSize?
    
    let genderOptions = PickerOptionList().genderOptions
    let ageOptions = PickerOptionList().ageOptions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        //Set all delegates
        self.genderPickerView.delegate = self
        self.agePickerView.delegate = self
        self.imagePicker.delegate = self
        self.usernameTextField.delegate = self
        self.emailTextField.delegate = self
        self.displayNameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.genderTextField.delegate = self
        self.ageTextField.delegate = self
        
        //Add default image to profile pic
        self.imageButton.setImage(UIImage(named: "Icon-73"), forState: UIControlState.Normal)
        
        //Add indent to each TextField
        let textFieldList = [self.emailTextField,
                            self.displayNameTextField,
                            self.passwordTextField,
                            self.genderTextField,
                            self.ageTextField,
                            self.usernameTextField]
        
        for textField in textFieldList{
            textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 0.0))
            textField.leftViewMode = .Always
        }
        self.genderTextField.text = self.genderOptions[0]
        
        //Setup navigationItem
        self.navigationItem.title = "Register"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("registerAsNewUser"))
    
        //Setup FBLoginButton
        self.FBLoginButton.setTitle("Register with Facebook", forState: UIControlState.Normal)
        self.FBLoginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.FBLoginButton.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        self.FBLoginButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
    }
    
    //Resets the scrollView's content insets
    func resetScrollView(){
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 50.0, right: 0.0)
        self.wrapperScrollView.contentInset = contentInsets
        self.wrapperScrollView.scrollIndicatorInsets = contentInsets
    }
    
    //User presses the register button
    func registerAsNewUser(){
        
        if (self.errorLabelHeightConstraint.constant == 30.0){self.toggleErrorLabel()}
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        //Check if any TextFields are empty
        if (!didChangeImage || self.displayNameTextField.text == "" || self.usernameTextField.text == "" || self.emailTextField.text == "" || self.passwordTextField.text == "" || self.ageTextField.text == "" || self.genderTextField.text == ""){
            self.errorLabel.text = "Missing fields"
            self.prepareToPresentError()
        }else if (self.usernameTextField.text!.characters.count <= 7){
            self.errorLabel.text = "Make sure that username has more than 7 characters."
            self.prepareToPresentError()
        }else if (self.passwordTextField.text!.characters.count <= 7){
            self.errorLabel.text = "Make sure that password has more than 7 characters."
            self.prepareToPresentError()
        }else{
            //Store new user info in Parse Core
            self.createNewUser(self.usernameTextField.text!,
                displayName: self.displayNameTextField.text!,
                email: self.emailTextField.text!,
                profilePic: self.imageButton.imageView!.image!,
                password: self.passwordTextField.text!,
                age: self.ageTextField.text!,
                gender: self.genderTextField.text!)
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
                            self.errorLabel.text = "Connection failed."
                        case PFErrorCode.ErrorUserEmailTaken.rawValue:
                            self.errorLabel.text = "Email is already taken."
                        case PFErrorCode.ErrorUsernameTaken.rawValue:
                            self.errorLabel.text = "Username is already taken."
                        default:
                            self.errorLabel.text = "Something went wrong. Try again."
                            break
                        }
                        self.prepareToPresentError()
                    }
                })
        }
    }
    
    func prepareToPresentError(){
        self.navigationItem.rightBarButtonItem?.enabled = true
        self.toggleErrorLabel()
    }
    
    func toggleErrorLabel(){
        if (self.errorLabelHeightConstraint.constant == 30.0){
            self.errorLabelHeightConstraint.constant -= 30.0
        }else {
            self.errorLabelHeightConstraint.constant += 30.0
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
        keyboardSize = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, self.keyboardSize!.height, 0.0)
        self.wrapperScrollView.contentInset = contentInsets
        self.wrapperScrollView.scrollIndicatorInsets = contentInsets
        
        //If active text is invisible, scroll it so it's visible
        var aRect: CGRect = self.view.frame
        aRect.size.height -= self.keyboardSize!.height
        if (!CGRectContainsPoint(aRect, self.ageTextField.frame.origin)){
            self.wrapperScrollView.scrollRectToVisible(self.ageTextField.frame, animated: true)
        }
    }
    
    //Called when the UIKeyboardWillHideNotification is sent.
    func keyboardWillBeHidden(aNotification: NSNotification){
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        self.wrapperScrollView.contentInset = contentInsets
        self.wrapperScrollView.scrollIndicatorInsets = contentInsets
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        if (self.errorLabelHeightConstraint.constant == 30.0){
            self.toggleErrorLabel()
        }
    
        //If active text is invisible, scroll it so it's visible
        var aRect: CGRect = self.view.frame
        if let keyboardSize = self.keyboardSize{
            aRect.size.height -= keyboardSize.height
            if (!CGRectContainsPoint(aRect, self.ageTextField.frame.origin)){
                self.wrapperScrollView.scrollRectToVisible(self.ageTextField.frame, animated: false)
            }
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        if (self.errorLabelHeightConstraint.constant == 30.0){
            self.toggleErrorLabel()
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
    
    //Whenever user presses the return button
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField.isEqual(self.displayNameTextField)){
            self.usernameTextField.becomeFirstResponder()
        }
        if (textField.isEqual(self.usernameTextField)){
            self.emailTextField.becomeFirstResponder()
        }
        if (textField.isEqual(self.emailTextField)){
            self.passwordTextField.becomeFirstResponder()
        }
        if (textField.isEqual(self.passwordTextField)){
            textField.resignFirstResponder()
        }
        return true
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
                self.errorLabel.text = "Uh Oh. Looks like you cancelled the Facebook login"
                self.toggleErrorLabel()
            }
        }
    }
}




