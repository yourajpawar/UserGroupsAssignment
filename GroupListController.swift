//
//  GroupListController.swift
//  LookFwdApp
//
//  Created by Rohit Deshmukh on 8/15/17.
//  Copyright © 2017 Rohit Deshmukh. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class GroupListController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var groupsTableView: UITableView!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    @IBOutlet weak var activityView:UIView!

    
    var groups:[Group] = []
    var selectedRow:Int = -1
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        self.view.tintColor = UIColor.orange
        
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        
        self.tabBarController?.tabBar.tintColor = UIColor.orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        groups = AppManager.sharedInstance.groups
        
        self.groupsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showUsers") {
            
            let showUsersController = (segue.destination as? UsersInGroupController )
            
            showUsersController?.usersArray = groups[selectedRow].userArray
            
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count  // returns the count of collection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "groupcell"
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? GroupCell
        
        cell?.groupName.text = groups[indexPath.row].groupName
        cell?.numberOfUsersInGroup.text = "Number of users:  \(groups[indexPath.row].userArray.count)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //when user taps on the particular cell.
        
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "showUsers", sender: self)
    }
    
}
