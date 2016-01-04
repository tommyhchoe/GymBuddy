//
//  Gym.swift
//  GymBuddy
//
//  Created by Tommy Choe on 1/1/16.
//  Copyright © 2016 Tommy Choe. All rights reserved.
//

import Foundation
import Parse

class Gym{
    
    var info: [String: String] = [:]

    init(name: String, location: String, profilePic: String){
        self.info["name"] = name
        self.info["location"] = location
        self.info["profilePic"] = profilePic
    }
}











