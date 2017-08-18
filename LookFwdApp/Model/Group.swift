//
//  User.swift
//  LookFwdApp
//
//  Created by Rohit Deshmukh on 8/16/17.
//  Copyright © 2017 Rohit Deshmukh. All rights reserved.
//

import Foundation


struct Group {
    
    let userArray:[User]
    let groupName:String
    var groupId:Int = 0
    
    init(userArray:[User], groupName:String) {
        
        self.userArray = userArray
        self.groupName = groupName
        
        //Get
        let count = UserDefaults.standard.integer(forKey: "groupsCount")
        
        self.groupId = count + 1
    }
}
