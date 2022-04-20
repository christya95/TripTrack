//
//  AppDelegate.swift
//  TripTrack_LoginWeather
//
//  Created by Rob C on 2022-04-18.
//

import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Store location key
    var locationKey: String = ""

    var databaseName: String? = "UserDB.db"
    var databasePath: String?
    var userList: [User] = []
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // First, retrieve location of documents folder
            // documentPaths is an array
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // first index is our base document path
        let documentsDir = documentPaths[0]
        // Define path by appending filename
        databasePath = documentsDir.appending("/" + databaseName!)
        
        // Does the file exist already?
        checkAndCreateDatabase()
        // Extract data from db
        readDataFromDatabase()
        
        return true
    }

    func checkAndCreateDatabase() {
        var success = false
        let fileManager = FileManager.default
        success = fileManager.fileExists(atPath: databasePath!)
        
//        print("CHECK 1")
        
        // does file exist?
        if success {
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
//        print("CHECK 2")
        
        return
    }
    
    func readDataFromDatabase(){
        // To ensure no duplicates, we remove
        userList.removeAll()
        // C pointer to reference the db
        var db: OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath)")
        
            var queryStatement: OpaquePointer? = nil
            var queryStatementString: String = "select * from users"
            
            // malloc up some memory for this query stmt object
            // Arguments passed are:
                // 1. Pointer to db
                // 2. String
                // 3. How many bytes do we want to limit this transaction by? -1 is no limit
                // 4. Memory location for query statement object
                // 5. any additional data needed
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                // While there is a row to deal with...
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    // Extract a row
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cUsername = sqlite3_column_text(queryStatement, 1)
                    let cPassword = sqlite3_column_text(queryStatement, 2)

                    // convert to String
                    let username = String(cString: cUsername!)
                    let password = String(cString: cPassword!)
                    
                    // ...and embed it in a User object
                    let user: User = User.init()
                    user.initWithData(
                        theRow: id,
                        theUsername: username,
                        thePassword: password)
                    // Put user object into [userList]
                    userList.append(user)
                    
                }
                // To free up allocated memory. Make sure to free up outside of while-loop
                sqlite3_finalize(queryStatement)
            } else {
                print("Select statement could not be prepared")
            }
            // Close connection
            sqlite3_close(db)
        } else {
            print("Database could not be opened and read")
        }
    }
    
    func insertIntoDatabase(user: User) -> Bool {
        var db: OpaquePointer? = nil
        var returnCode: Bool = true
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            var insertStatement: OpaquePointer? = nil
            // values(id, name, address, phone, email, age, gender, dob, avatar)
            var insertStatementString: String = "INSERT INTO users VALUES(NULL, ?, ?)"
            
            // malloc up some memory, identical to readingDataFromDatabase
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                // Convert String to NSString, then to CString
                let usernameStr = user.username! as NSString
                let passwordStr = user.password! as NSString
//                let avatarStr = user.avatar! as NSInteger
                
                // Set up the queries
                // Arguments passed in method below are:
                    // 1. insertStatement
                    // 2. Column Number; we only care about column1/2/3/4 (name, address, phoneNo, email)
                    // 3. Convert to CString
                    // 4. No limit on bytes
                    // 5. No extra arguments
                sqlite3_bind_text(insertStatement, 1, usernameStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, passwordStr.utf8String, -1, nil)

                // Now execute
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row \(rowID)")
                } else {
                    print("Error inserting row")
                    returnCode = false
                }
                // Free up memory after insert
                sqlite3_finalize(insertStatement)
                
            } else {
                print("INSERT statement failed")
                returnCode = false
            }
            // Close db
            sqlite3_close(db)
        } else{
            print("Could not open database")
            returnCode = false
        }
        
        return returnCode
    }
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

