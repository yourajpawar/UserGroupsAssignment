//
//  UserListController.swift
//  LookFwdApp
//
//  Created by Rohit Deshmukh on 8/15/17.
//  Copyright © 2017 Rohit Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class UserListController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    override func viewDidLoad() {
        var a = NetworkManager()
        a.networkCall()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8  // returns the count of collection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "usercell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        
        
        return cell!
    }

    


}
