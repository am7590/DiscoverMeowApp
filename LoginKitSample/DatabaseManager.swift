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
    var user: User?
    private var userReference: DocumentReference?
    
//    public func checkIfUserTokenExists(token: String) -> DocumentReference {
//        return db.collection("users").document(token)
//    }
    
    public func addUserInfo(user: User) {
        do {
            let newUserReference = try db.collection("users").addDocument(from: user)
            self.userReference = newUserReference
            print("Added \(user.displayName) to the database with reference \(newUserReference)")
        } catch {
            fatalError("Could not add user to database")
        }
    }
    
    public func fetchUserInfo(userDocumentReference: DocumentReference) -> User? {
        print(userDocumentReference.path)
        
        userDocumentReference.getDocument(as: User.self) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let failure):
                fatalError(failure.localizedDescription)
            }
        }
        
        return user
    }
    
    public func doesUserExist(user: User) {
        
        db.collection("users").whereField("token", isEqualTo: user.token).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let count = querySnapshot!.documents.count
                print("found \(count) accounts with token \(user)")
                
                if count == 0 {
                    self.addUserInfo(user: user)
                } else {
                    let userDict = querySnapshot!.documents.first?.data()
                    let user = User(data: userDict!)
                    print(querySnapshot!.documents.first?.documentID)
                    self.user = user
                }
            }
        }        
    }
    
    // TODO: Refactor next two funcs
    public func updateCountry(country: String) {
        do {
            self.db.collection("users").document(self.userReference!.documentID).getDocument() { snapshot, error in
                if let error = error {
                    print("Error finding user: \(error)")
                } else {
                    snapshot?.reference.updateData([
                        "country": country
                    ])
                    print("Successfully updated country to \(country)")
                }  
            }
        } catch {
            fatalError("Could not add user to database")
        }
    }
    
    public func updateBirthdate(birthdate: Date) {
        do {
            self.db.collection("users").document(self.userReference!.documentID).getDocument() { snapshot, error in
                if let error = error {
                    print("Error finding user: \(error)")
                } else {
                    snapshot?.reference.updateData([
                        "birthdate": birthdate
                    ])
                    print("Successfully updated birthdate to \(birthdate)")
                }
            }
        } catch {
            fatalError("Could not add user to database")
        }
    }
}
