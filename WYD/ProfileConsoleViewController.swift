//
//  ProfileConsoleViewController.swift
//  WYD
//
//  Created by Fan Ye on 1/7/15.
//  Copyright (c) 2015 WYD. All rights reserved.
//

import UIKit

class ProfileConsoleViewController: UITableViewController{

    @IBOutlet var profileConsole: UITableView!
    
    var options :[String] = ["logout"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var user = PFUser.currentUser()
        self.profileConsole.tableFooterView = UIView(frame: CGRectZero)
        self.clearsSelectionOnViewWillAppear = true
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.row == 0 {
            cell = self.profileConsole.dequeueReusableCellWithIdentifier("avatar", forIndexPath: indexPath) as AvatarCell
            
        } else {
            cell = self.profileConsole.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        }
        
        if let cell = cell as? AvatarCell {
            let user = PFUser.currentUser()
            cell.usernameLabel.text = user.username
            cell.avatarImage.image = UIImage(named: "back")
        } else {
            cell.textLabel?.text = self.options[indexPath.row - 1]
            if self.options[indexPath.row - 1] == "logout" {
                cell.textLabel?.textAlignment = NSTextAlignment.Center
                cell.textLabel?.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            }
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 170
        } else {
            return UITableViewAutomaticDimension
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row > 0 {
            switch self.options[indexPath.row - 1] {
            case "logout":
                PFUser.logOut()
                self.performSegueWithIdentifier("returnHome", sender: nil)
            default:
                println(self.options[indexPath.row - 1])
            }
        }
    }

}
