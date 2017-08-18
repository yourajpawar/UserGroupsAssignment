//
//  UsersInGroupController.swift
//  
//
//  Created by Rohit Deshmukh on 8/15/17.
//  Copyright © 2017 Rohit Deshmukh. All rights reserved.
//
//

import Foundation
import UIKit


class UsersInGroupController: UITableViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var usersArray:Array<User> = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.usersTableView.tintColor = UIColor.orange
        
        self.view.tintColor = UIColor.orange
        
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usersArray.count   // returns the count of collection
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let cellIdentifier = "usercell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! UserCell
        
        cell.usernameLabel.text = usersArray[indexPath.row].username
        cell.userid.text = usersArray[indexPath.row].userid
        
        return cell
        
        
    }
    
  override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90.0
    }
    
}
