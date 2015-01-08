//
//  RootViewController.swift
//  WYD
//
//  Created by Fan Ye on 1/6/15.
//  Copyright (c) 2015 WYD. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        var currentUser = PFUser.currentUser()
        if (currentUser == nil){
            var logInController = PFLogInViewController()
            logInController.delegate = self
            logInController.facebookPermissions = ["friends_about_me"]
            logInController.fields = (PFLogInFields.Default
                | PFLogInFields.Facebook
                | PFLogInFields.Twitter
                | PFLogInFields.DismissButton)
            
            self.presentViewController(logInController, animated: true, completion: nil)
        } else {
            self.performSegueWithIdentifier("toMainCtrlSegue", sender: nil)
        }
    }
    
    func logInViewController(logInController: PFLogInViewController!, shouldBeginLogInWithUsername username: String!, password: String!) -> Bool {
        if username != nil && password != nil && countElements(username) != 0 && countElements(password) != 0 {
            return true
        }
        var alert = UIAlertView(title: "Missing Information",
            message: "Make sure you fill out all of the information",
            delegate: nil,
            cancelButtonTitle: "ok")
        alert.show()
        return false
    }
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController!, didFailToLogInWithError error: NSError!) {
        NSLog("Failed to log in: " + error.localizedDescription)
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController!) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, shouldBeginSignUp info: [NSObject : NSString]!) -> Bool {
        var informationComplete = true
        
        for (key, field) in info {
            if (field.length == 0) {
                informationComplete = false
                break
            }
        }
        
        if !informationComplete {
            var alert = UIAlertView(title: "Missing Information", message: "Make sure to fill out all of the information", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        return informationComplete
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController!) {
        NSLog("User dismissed the signUpViewController")
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didFailToSignUpWithError error: NSError!) {
        NSLog("Failed to log in")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

