//
//  UserMainInfo.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/28/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import Foundation

class UserMainInfo{
    var info: [String: String]
    
    init(username: String, displayName: String, email: String, profilePic: String, password: String, age: String, gender: String){
        info = ["username":username, "displayName":displayName, "email":email, "profilePic":profilePic, "password":password, "age":age, "gender":gender]
    }

}









