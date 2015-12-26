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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
    }
    
    func configView(){
        
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
        
        //Setup navigationItem
        self.navigationItem.title = "Register"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("loginAsNewUser"))
    }
    
    func loginAsNewUser(){
        print("Creating new user")
    }
    
    @IBAction func changeProfileImage(sender: AnyObject) {
        print("Change the profile image")
    }
}
















