//
//  CreateAccountViewController.swift
//  TripTrack_LoginWeather
//
//  Created by Rob C on 2022-04-20.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet var tfUsername: UITextField!
    @IBOutlet var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // For user creation
    @IBAction func addToDatabase() {
        
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let user: User = User.init()
        user.initWithData(
            theRow: 0,
            theUsername: tfUsername.text!,
            thePassword: tfPassword.text!)
        
        let returnCode = mainDelegate.insertIntoDatabase(user: user)
        
        var returnMsg: String = "Person Added"
        if returnCode == false {
            returnMsg = "Person Add Failed"
        }
        let alertController = UIAlertController(
            title: "Added to Database",
            message: returnMsg,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: {action in
                self.segueToLoginAgain()
            })
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    // To 
    func segueToLoginAgain() {
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
}
