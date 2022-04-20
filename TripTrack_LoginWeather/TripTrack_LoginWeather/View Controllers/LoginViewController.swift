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
    
    var username: String?
    var password: String?
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBAction func login() {
        for users in mainDelegate.userList {
            if (users.username == tfUsername.text && users.password == tfPassword.text){
                performSegue(withIdentifier: "nextView", sender: self)
            }
        }
        
    }
    
    @IBAction func addToDatabase() {
        let user: User = User.init()
        user.initWithData(
            theRow: 0,
            theUsername: tfUsername.text!,
            thePassword: tfPassword.text!)
        
        // Now insert into db
//        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
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
            handler: nil)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainDelegate.readDataFromDatabase()

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
