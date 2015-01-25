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
    
    func createLogoLable() -> UILabel {
        var logo = UILabel()
        logo.text = "WYD"
        logo.font = logo.font.fontWithSize(30)
        return logo
    }
    
    override func viewDidAppear(animated: Bool) {
        var currentUser = PFUser.currentUser()
        if (currentUser == nil){
            var logInController = PFLogInViewController()
            logInController.delegate = self
            logInController.facebookPermissions = ["friends_about_me"]
            logInController.fields = (PFLogInFields.LogInButton
                | PFLogInFields.SignUpButton
                | PFLogInFields.PasswordForgotten
                | PFLogInFields.UsernameAndPassword)

            logInController.logInView.logo = createLogoLable()
            logInController.signUpController = PFSignUpViewController()
            
            logInController.signUpController.delegate = self
            logInController.signUpController.signUpView.logo = createLogoLable()
            logInController.signUpController.signUpView.emailField.placeholder = "email: @XXX.edu"
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
        var eduEmail = true
        
        for (key, field) in info {
            if (field.length == 0) {
                informationComplete = false
                break
            }
            if (key == "email") && (!field.hasSuffix(".edu")) {
                eduEmail = false
                break
            }
        }
        
        if !informationComplete {
            var alert = UIAlertView(title: "Missing Information", message: "Make sure to fill out all of the information", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        if !eduEmail {
            var alert = UIAlertView(title: "Invalid Email", message: "We only accept .edu email registration", delegate: nil, cancelButtonTitle: "Use a different email")
            alert.show()
        }
        
        return informationComplete && eduEmail
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController!) {
        NSLog("User dismissed the signUpViewController")
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
        if (user != nil) {
            self.performSegueWithIdentifier("toMainCtrlSegue", sender: nil)
        } else {
            self.showViewController(self, sender: nil)
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didFailToSignUpWithError error: NSError!) {
        
        NSLog("Failed to sign up")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

