//
//  LoginViewController.swift
//  TripTrack_LoginWeather
//
//  Created by Rob C on 2022-04-20.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tfUsername: UITextField!
    @IBOutlet var tfPassword: UITextField!
    
//    var username: String?
//    var password: String?
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    // Function to log the user in. It first checks if
    @IBAction func login() {
        for users in mainDelegate.userList {
            if (users.username == tfUsername.text && users.password == tfPassword.text){
                performSegue(withIdentifier: "nextView", sender: self)
            } else {
                let alertController = UIAlertController(
                    title: "Error",
                    message: "Incorrect username/password. Please try again",
                    preferredStyle: .alert)
                let cancelAction = UIAlertAction(
                    title: "OK",
                    style: .cancel,
                    handler: nil)
                
                alertController.addAction(cancelAction)
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainDelegate.readDataFromDatabase()

    }
}
