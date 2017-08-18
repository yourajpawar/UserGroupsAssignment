//
//  GroupListController.swift
//  LookFwdApp
//
//  Created by Rohit Deshmukh on 8/15/17.
//  Copyright © 2017 Rohit Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class GroupListController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var groupsTableView: UITableView!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    @IBOutlet weak var activityView:UIView!

    
    var groups:[Group] = []
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        groups = AppManager.sharedInstance.groups
        
        self.groupsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count  // returns the count of collection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "groupcell"
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? GroupCell
        
        cell?.groupName.text = groups[indexPath.row].groupName
        cell?.numberOfUsersInGroup.text = "\(groups[indexPath.row].userArray.count)"
        
        return cell!
    }


}
