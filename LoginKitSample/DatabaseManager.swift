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
            UserDefaultsStorageManager.shared.saveUserReferenceToUserDefaults(userReference: newUserReference)
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
                } else {
                    print("Error fetching users: \(error?.localizedDescription)")
                }
            })
        }
    }
    
    public func fetchSwipedUsers(completion: @escaping([ListUser]) -> Void) {
        var listUsers = [ListUser]()

        if let reference = UserDefaultsStorageManager.shared.getUserReferenceDocumentID() {
            let collection = Firestore.firestore().collection("users").document(reference)
           
            collection.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let docData = document.data()!["swipeRightList"] as? NSArray {
                        for item in docData {
                            let item = item as! NSDictionary
                            let displayName: String = item["displayName"] as! String
                            let bitmojiURL: URL = URL(string: item["bitmojiURL"] as! String)!
                            let country: String = item["country"] as! String
                            
                            let user = ListUser(displayName: displayName, bitmojiURL: bitmojiURL, country: country)
                            
                            listUsers.append(user)
                        }
                        
                        completion(listUsers)
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}

// MARK: Update user's database fields
extension DatabaseManager {
    
    public func addUserToSwipedArray(user: ListUser) {
        //setData(dict: ["swipeRightList": FieldValue.arrayUnion([user])])
        
        if let reference = UserDefaultsStorageManager.shared.getUserReferenceDocumentID() {
            do {
                db.collection("users").document(reference)
                    .updateData(
                        ["swipeRightList": FieldValue.arrayUnion([try Firestore.Encoder().encode(user)])]
                    ) { error in
                        guard let error = error else {
                            // no error
                            return
                        }
                        
                        print("Could not update field: \(error)")
                    }
            } catch {
                // encoding error
            }
        }
    }
    
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
    
    public func setData(dict: [String: Any], reference: String) {
        self.db.collection("users").document(self.userReference!.documentID).getDocument() { snapshot, error in
            if let error = error {
                print("Error finding user: \(error)")
            } else {
                snapshot?.reference.setData(
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
