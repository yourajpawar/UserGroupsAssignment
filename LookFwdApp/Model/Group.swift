//
//  User.swift
//  LookFwdApp
//
//  Created by Rohit Deshmukh on 8/16/17.
//  Copyright © 2017 Rohit Deshmukh. All rights reserved.
//

import Foundation


struct Group {
    
    var userArray:[User] = []
    var groupName:String = ""
    var groupId:Int = 0
    
    init?(userArray:[User], groupName:String) {
        
        if userArray.count > 0 {
            
        self.userArray = userArray
        self.groupName = groupName
        
        //Get
        let count = UserDefaults.standard.integer(forKey: "groupId")
        
        self.groupId = count + 1
            
        }
    }
    
    
    init?(userArray:[User], groupName:String, groupID:Int) {
        
        if userArray.count > 0 {
            
            self.userArray = userArray
            self.groupName = groupName
            self.groupId = groupID
            
        }
    }
}
