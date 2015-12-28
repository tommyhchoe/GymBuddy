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

    @IBOutlet weak var loginErrorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.delegate = self

        self.configView()
    }
    
    //MARK: - Helper Methods
    
    func configView(){
        
        //Add intent to TextField
        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5.0, height: 30.0))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = UITextFieldViewMode.Always
        
        //Setup navigationItem
        self.navigationItem.title = "Enter email"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Retrieve", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("sendUserInfoByEmail"))
        
    }
    
    func sendUserInfoByEmail(){
        
        //Hide loginErrorLabel before checking if any TextField is incomplete
        if(self.loginErrorLabel.hidden == false){self.loginErrorLabel.hidden = true}
        
        if (emailTextField.text != ""){
            self.loginErrorLabel.text = "Alright. We sent your login information"
            self.loginErrorLabel.backgroundColor = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 0.8)
            self.toggleErrorLabel()
        }else{
            if (self.loginErrorLabel.backgroundColor! == UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 0.8)){
                self.loginErrorLabel.backgroundColor = UIColor.redColor()
            }
            self.loginErrorLabel.text = "You didn't enter your email"
            self.toggleErrorLabel()
        }
    }
    
    func toggleErrorLabel(){
        if (self.loginErrorLabel.hidden == true){
            self.loginErrorLabel.hidden = false
        }else{
            self.loginErrorLabel.hidden = true
        }
    }
    
    //MARK: - UITextField Delegate Method(s)
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (self.loginErrorLabel.hidden == false){
            self.loginErrorLabel.hidden = true
        }
    }
}




















