//
//  ForgotViewController.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/25/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit

class ForgotViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        if (emailTextField.text != ""){
            print("Sending user info. Thanks!")
        }else{
            print("You didn't enter your email")
        }
    }
}




















