//
//  User.swift
//  JSON_IOS
//
//  Created by Rohit Deshmukh on 7/1/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import Foundation

struct User:Decodable, Equatable {
    
    let userid:String
    let username:String
    var isSelected:Bool = false
    
//    {
//    "id": "95a8bd3c-bd1c-4c26-8959-d449eb7e4c6c",
//    "name": "Antione Milch"
//    }
    
    //Gloss for parsing
    init?(json:JSON) {
        
       guard let userid:String = "id" <~~ json,
        let name:String = "name" <~~ json
        else {
            
            return nil
        }
        
        self.userid = userid
        self.username = name
        
    }
    
    public static func ==(lhs:User, rhs:User) -> Bool {
        
        return lhs.userid == rhs.userid
    }
}
