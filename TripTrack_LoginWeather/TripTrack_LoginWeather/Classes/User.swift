//
//  User.swift
//  TripTrack_LoginWeather
//
//  Created by Rob C on 2022-04-20.
//

import UIKit

class User: NSObject {

    var id: Int?
    var username: String?
    var password: String?
    
    
    func initWithData(theRow: Int, theUsername: String, thePassword: String){
        id = theRow
        username = theUsername
        password = thePassword
    }
}
