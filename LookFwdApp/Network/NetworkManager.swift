//
//  NetworkManager.swift
//  LookFwdApp
//
//  Created by Rohit Deshmukh on 8/15/17.
//  Copyright © 2017 Rohit Deshmukh. All rights reserved.
//

import Foundation

//class NetworkManager{
//
//    let url:String = "https://api.lookfwd.io/v1/test/users"
//    var users = [[String: AnyObject]]()
//    
//    func networkCall() -> [[String: AnyObject]]{
//        let urlRequest = URL(string:url)
//       
//        URLSession.shared.dataTask(with: urlRequest!, completionHandler:{
//            
//        (data,response,error) in
//        
//            if let response = response{
//                print(response)
//            }
//            if let data = data{
//                
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [] )
//                    print(json)
//                    
//                } catch  {
//                    print(error)
//                }
//                
//            }
//            
//            }).resume()
//        
//    return users
//    }
//
//}

class NetworkManager {
    
    let kUsersJsonFilename = "users"
    let usersUrl = "https://api.lookfwd.io/v1/test/users"
    let groupsUrl = ""
    let someotherURl = "http://"
    
    //Get all users
    //    (id:Int,name:String)->Void
    
    func parseUser(json:Any) -> [User]? {
        
        var usersArray:[User] = []
        
        if json is Dictionary<String, Any> {
            
            let user:User = User.init(json: json as! JSON)!
            
            usersArray = [user]
        }
        else if (json is Array<Dictionary<String,Any>>) {
            
            //This array of dictionaries
            
            guard let array = [User].from(jsonArray: json as! [JSON]) else {
                
                print("Failure in Parsing User ")
                //failure(nil)
                return nil
            }
            
            usersArray = array
        }
        
        return usersArray
    }
    
    func getAllUsers(success:@escaping (Any)->Void, failure:@escaping (Error)->Void) {
        
        _ = fireApi(urlString:usersUrl, success:{ json in
            
            let usersJson = json as? Dictionary<String,Any>
            
            guard let arrayOfJson = usersJson?["users"] as? [Dictionary<String,Any>] else {
                
                print("Json parsing error")
                return
            }
            
            let usersArray = self.parseUser(json: arrayOfJson)
            
            success(usersArray!)
            
        }, failure:{ error in
            
            failure(error)
        })
    }
    
    func mockUsersData(success:@escaping (Any)->Void, failure:@escaping (Error)->Void) {
        
        let dictionary = Utilities.readFile(kUsersJsonFilename) as? Dictionary<String,Any>
        
        guard let arrayOfJson = dictionary?["users"] as? [Dictionary<String,Any>] else {
            
            print("Json parsing error")
            return
        }
        
        var usersArray = self.parseUser(json: arrayOfJson)
        
        
        if let usersArray = usersArray {
            
            //success
            success(usersArray)
        }
        else {
            
            //failure
            failure(fatalError("usersArray failed parsing") as! Error)
        }
    }
    
    // MARK: Session function
    func fireApi(urlString:String, success:@escaping (Any)->Void, failure:@escaping (Error)->Void) -> Any {
        
        guard let url = URL(string: urlString) else {return ""}
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse{
                
                if response.statusCode == 200 {
                    
                    print("Response Successful:\(response)")
                }
                else {
                    
                    print("Response Failed:\(response)")
                    failure(error!)
                }
                
            }
            if let data = data
            {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [] )
                    print("Data json:\(json)")
                    
                    success(json)
                    
                    
                } catch  {
                    print(error)
                }
                
            }
            
        }
        
        dataTask.resume()
        
        return ""
    }
    
}

