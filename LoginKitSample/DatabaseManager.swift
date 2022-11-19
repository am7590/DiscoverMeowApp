//
//  DatabaseManager.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/18/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private var db = Firestore.firestore()
    
    public func addUserInfo(user: User) {
        do {
            let newUserReference = try db.collection("users").addDocument(from: user)
            print("Added \(user.displayName) to the database with reference \(newUserReference)")
        } catch {
            fatalError("Could not add user to database")
        }
    }
    
    public func checkIfUserTokenExists(token: String) -> Bool {
        //do {
            let existingUserReference = db.collection("users").document(token)
            print("existingUserReference: \(existingUserReference)")
            return existingUserReference == existingUserReference
            
       // } catch {
            
       // }
    }
}
