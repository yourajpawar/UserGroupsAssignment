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


    override func viewDidLoad() {
       super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8  // returns the count of collection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "groupcell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        
        
        return cell!
    }


}
