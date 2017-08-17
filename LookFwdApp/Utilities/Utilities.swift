//
//  Utilities.swift
//  JSON_IOS
//
//  Created by Rohit Deshmukh on 7/2/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import Foundation


class Utilities {
    
    
    //Call this function to get Dictionary from json file
    //Call this function to get Dictionary from json file
    static func readFile(_ fileName:String) -> Any
    {
        var filecontent:Any = []
        if let path = Bundle.main.path(forResource: fileName, ofType: "json")
        {
            do
            {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options:[])
                if let jsonResult: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
                {
                    if jsonResult is Dictionary<String,Any> {
                        
                        filecontent = (jsonResult as? Dictionary<String,Any>)!
                    }
                    else if jsonResult is Array<Dictionary<String,Any>> {
                        
                        filecontent = (jsonResult as? Array<Dictionary<String,Any>>)!
                    }
                    
                }
            }
            catch
            {
                NSLog("Error loading the JSON file: \(path)")
            }
        }
        return filecontent
    }
    

}
