//
//  NetworkManager.swift
//  LookFwdApp
//
//  Created by Rohit Deshmukh on 8/15/17.
//  Copyright © 2017 Rohit Deshmukh. All rights reserved.
//

import Foundation

class NetworkManager{

    let url:String = "https://api.lookfwd.io/v1/test/users"
    var users = [[String: AnyObject]]()
    
    func networkCall() -> [[String: AnyObject]]{
        let urlRequest = URL(string:url)
       
        URLSession.shared.dataTask(with: urlRequest!, completionHandler:{
            
        (data,response,error) in
        
            if let response = response{
                print(response)
            }
            if let data = data{
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [] )
                    print(json)
                    
                } catch  {
                    print(error)
                }
                
            }
            
            }).resume()
        
    return users
    }

}
