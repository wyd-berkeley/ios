//
//  ProfileConsoleViewController.swift
//  WYD
//
//  Created by Fan Ye on 1/7/15.
//  Copyright (c) 2015 WYD. All rights reserved.
//

import UIKit

class ProfileConsoleViewController: UITableViewController{
    
    var options :[String] = ["logout"]
    var selectedMenuItem : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        var user = PFUser.currentUser()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.registerNib(UINib(nibName: "AvatarCell", bundle: nil), forCellReuseIdentifier: "avatar")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.clearsSelectionOnViewWillAppear = true
        
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count + 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("avatar", forIndexPath: indexPath) as AvatarCell
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        }
        
        if (cell.textLabel?.text == "") {
            cell.backgroundColor = UIColor.clearColor()
            let selectBgView = UIView(frame: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height))
            selectBgView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
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
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        selectedMenuItem = indexPath.row
        
        print(indexPath.row)
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = self
            break
        default:
            PFUser.logOut()
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("RootVC") as UIViewController
            
            break
        }
        
        sideMenuController()?.setContentViewController(destViewController)
    }

}
