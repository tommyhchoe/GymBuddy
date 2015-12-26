//
//  userDatabase.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/26/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import Foundation

class UserDatabase{
    var userDictionary: [String:String]
    
    init(username: String, displayName: String, email: String, profilePic: String, password: String, age: String, gender: String){
        userDictionary = ["username":username, "displayName":displayName, "email":email, "profilePic":profilePic, "password":password, "age":age, "gender":gender]
    }
}







