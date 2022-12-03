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
    
    func fetchAllUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                let dictionary = document.data()
                let user = User(data: dictionary)
                users.append(user)
                
                if users.count == snapshot?.documents.count {
                    completion(users)
                }
            })
        }
    }
}

// MARK: Update user's database fields
extension DatabaseManager {
    
    public func updateField(dict: [String: Any]) {
        self.db.collection("users").document(self.userReference!.documentID).getDocument() { snapshot, error in
            if let error = error {
                print("Error finding user: \(error)")
            } else {
                snapshot?.reference.updateData(
                    dict
                )
                print("Successfully updated field \(dict)")
            }
        }
    }
}


// MARK: Populate fake dummy accounts
extension DatabaseManager {
    public func addFakeUsersToDB(users: [User]) {
        for user in users {
            do {
                try db.collection("users").addDocument(from: user)
                print("Added \(user.displayName) to the database")
            } catch {
                fatalError("Could not add user \(user.displayName) to database")
            }
        }
        
    }
}
