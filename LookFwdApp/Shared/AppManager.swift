//
//  AppManager.swift
//  
//
//  Created by Pawar, Youraj on 8/17/17.
//
//

import Foundation

class AppManager {
    
    var users:[User] = []
    var groups:[Group] =  []
    var groupsCount = 0
    
    static let sharedInstance : AppManager = {
        let instance = AppManager()
        return instance
    }()
    
    func selectedUsers(usersArray:[User]) -> [User]? {
        
        let selectedUsers =  usersArray.filter ({ user in
            
            return user.isSelected
            
        })
        
        return selectedUsers
    }
    
    
    func createGroup(usersArray:[User], groupName:String) -> Group? {
        
        var group:Group? = nil
        
        users = usersArray
        
        let selectedUsers = self.selectedUsers(usersArray: usersArray)!
        
        if selectedUsers.count > 0 {
            
            group = Group.init(userArray: selectedUsers, groupName: groupName)
            
            AppManager.sharedInstance.groups.append(group!)
            
            groupsCount = AppManager.sharedInstance.groups.count
            
            //Set
            UserDefaults.standard.set(groupsCount, forKey: "groupsCount")
            
        }
        
        return group

    }
}

