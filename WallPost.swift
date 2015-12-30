//
//  WallPost.swift
//  GymBuddy
//
//  Created by Tommy Choe on 12/29/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import Foundation
import Parse

class WallPost: PFObject, PFSubclassing {

    @NSManaged var image: PFFile
    @NSManaged var user: PFUser
    @NSManaged var comment: String?
    
    static func parseClassName() -> String {
        return "WallPost"
    }
    
    override class func initialize(){
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery?{
        let query = PFQuery(className: WallPost.parseClassName())
        query.includeKey("user")
        query.orderByDescending("createdAt")
        return query
    }
    
    init(image: PFFile, user: PFUser, comment: String?){
        super.init()
        
        self.image = image
        self.user = user
        self.comment = comment
    }
    
    override init(){
        super.init()
    }
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    