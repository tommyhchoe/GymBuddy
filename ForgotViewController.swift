//
//  ForgotViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/25/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit

class ForgotViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorLabelHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configView()
    }
    
    //MARK: - Helper Methods
    
    func configView(){
        
        //Add all delegates
        self.emailTextField.delegate = self
        
        //Add intent to TextField
        self.emailTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 30.0))
        self.emailTextField.leftViewMode = UITextFieldViewMode.Always
        
        //Setup navigationItem
        self.navigationItem.title = "Enter email"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Retrieve", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("sendUserInfoByEmail"))
        
    }
    
    //MARK: - Helper Methods
    
    //User clicked send button
    func sendUserInfoByEmail(){
        
        //Hide errorLabel before checking if any TextField is incomplete
        if(self.errorLabelHeightConstraint.constant == 30.0){self.toggleErrorLabel()}
        
        //Disable barButtonItem
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        //Reset border around textField
        self.emailTextField.layer.borderWidth = 0.0
        
        let greenColor = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 0.8)
        
        //Check if email field is empty first
        if (emailTextField.text != ""){
            self.errorLabel.text = "Alright. We sent your login information"
            self.errorLabel.backgroundColor = greenColor
            self.prepareToPresentError()
        }else{
            if (self.errorLabel.backgroundColor! == greenColor){
                self.errorLabel.backgroundColor = UIColor.redColor()
            }
            self.emailTextField.layer.borderWidth = 1.25
            self.emailTextField.layer.borderColor = UIColor.redColor().CGColor
            self.errorLabel.text = "You didn't enter your email"
            self.prepareToPresentError()
        }
    }
    
    func prepareToPresentError(){
        self.navigationItem.rightBarButtonItem?.enabled = true
        self.toggleErrorLabel()
    }
    
    func toggleErrorLabel(){
        if (self.errorLabelHeightConstraint.constant == 30.0){
            self.errorLabelHeightConstraint.constant -= 30.0
        }else{
            self.errorLabelHeightConstraint.constant += 30.0
        }
    }
    
    //MARK: - UITextField Delegate Method(s)
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (self.errorLabelHeightConstraint.constant == 30.0){
            self.toggleErrorLabel()
        }
    }
}




















