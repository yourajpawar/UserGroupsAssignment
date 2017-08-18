//
//  AppManager.swift
//
//
//
//
//


import Foundation
import Firebase

class AppManager {
    
    var users:[User] = []
    var groups:[Group] =  []
    var groupsCount = 0
    
    //Firebase
    var ref: FIRDatabaseReference?
    
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
            
            //Set
            UserDefaults.standard.set(group?.groupId, forKey: "groupId")
            
            registerForGroupAddedOnFirebase()
            
            //Upload to firebase
            self.uploadGroupOnFireBase(group: group)
            
        }
        
        return group
        
    }
    
    func uploadGroupOnFireBase(group:Group?) {
        
        ref = FIRDatabase.database().reference()
        
        guard let group = group else {
            
            print("Group is nil")
            
            return
        }
        
        var dictionaryOfUser:[String:Any] = [:]
        var arrayOfDictionary:Array<Dictionary<String,Any>> = Array()
        
        for user in group.userArray {
            
            dictionaryOfUser["id"] = user.userid
            dictionaryOfUser["name"] = user.username
            
            arrayOfDictionary.append(dictionaryOfUser)
        }
        
        
        
        let groupsFbase  = ref?.child("groups")
        groupsFbase?.childByAutoId().setValue(["groupid":"\(group.groupId)",
            "groupname":"\(group.groupName)",
            "users":arrayOfDictionary])
    }
    
    func registerForGroupAddedOnFirebase() {
        
        ref = FIRDatabase.database().reference()
        
        //FETCH
        ref?.child("groups").queryOrderedByKey().observeSingleEvent(of: .childAdded, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? Dictionary<String,Any>
            let groupid = Int((value?["groupid"] as? String ?? ""))
            let groupname = value?["groupname"] as? String ?? ""
            let users = value?["users"] as? Array<Dictionary<String,Any>>
            
            let userArray = NetworkManager().parseUser(json: users!)
            
            print("Child Added")
            
            if (userArray?.count)! > 0 {
                
                let group = Group.init(userArray:  userArray!, groupName: groupname, groupID:groupid!)
                
                AppManager.sharedInstance.groups.append(group!)
            }
            
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

