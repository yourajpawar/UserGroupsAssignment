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
    
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    @IBOutlet weak var activityView:UIView!
    
    var networkManager:NetworkManager? = nil
    
    var usersArray:Array<User> = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.usersTableView.tintColor = UIColor.orange
        
        self.view.tintColor = UIColor.orange
        
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        
        networkManager = NetworkManager()
        
        self.activityView.isHidden = false
        
        activityIndicator.startAnimating()
        
        networkManager?.getAllUsers(success: { array in
            
            self.usersArray = array as! Array<User>
            
            DispatchQueue.main.async { [unowned self] in
                
                self.activityIndicator.stopAnimating()
                
                self.activityIndicator.hidesWhenStopped = true
                
                self.activityView.isHidden = true
                
                self.usersTableView.reloadData()
            }
            
        }, failure: { error in
            
            print("Error in getting data from Network Manager, Error \(error)")
            self.activityIndicator.stopAnimating()
            
        })
        
        
//        networkManager?.mockUsersData(success: { array in
//            
//            self.usersArray = array as! Array<User>
//            
//            //Adding to main thread
//            DispatchQueue.main.async { [unowned self] in
//                
//                self.activityIndicator.stopAnimating()
//                
//                self.activityIndicator.hidesWhenStopped = true
//                
//                self.activityView.isHidden = true
//                
//                self.usersTableView.reloadData()
//            }
//            
//        }, failure: { error in
//            
//            print("Error in getting data from Network Manager, Error \(error)")
//            self.activityIndicator.stopAnimating()
//            
//        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usersArray.count   // returns the count of collection
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //
    //        if let cell = cell as? UserCell {
    //
    //            let user = usersArray[indexPath.row]
    //
    //            if user.isSelected {
    //
    //                cell.backgroundColor = UIColor.blue
    //
    //            }
    //            else {
    //
    //                cell.backgroundColor = UIColor.white
    //            }
    //
    //        }
    //    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //when user taps on the particular cell.
        
        if let cell = tableView.cellForRow(at: indexPath) as? UserCell {
            
            var user = usersArray[indexPath.row]
            
            user.isSelected = !user.isSelected
            
            if user.isSelected {
                
                cell.accessoryType = .checkmark
                
            }
            else {
                
                cell.accessoryType = .none
            }
            
            //Replace updated user value
            usersArray[indexPath.row] = user
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let cellIdentifier = "usercell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! UserCell
        
        cell.usernameLabel.text = usersArray[indexPath.row].username
        cell.userid.text = usersArray[indexPath.row].userid
        
        if usersArray[indexPath.row].isSelected {
            
            cell.accessoryType = .checkmark
            
        }
        else {
            
            cell.accessoryType = .none
        }
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90.0
    }
    
    
    //MARK:  IBACTIONS
    @IBAction func createGroupButtonClicked(_ sender:UIBarButtonItem) {
        
        //SHOW UI ALERT DIALOG
        print("Create Group clicked")
    }
    
}
