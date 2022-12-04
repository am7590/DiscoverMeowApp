//
//  UserDefaultsStorageManager.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/28/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation
import FirebaseFirestore

final class UserDefaultsStorageManager {
    
    struct Constants {
        static let hasLoggedInBefore = "hasLoggedInBefore"
        static let currentUser = "currentUser"
        static let userReference = "userReference"
    }
    
    static let shared = UserDefaultsStorageManager()
    
    let userDefaults = UserDefaults.standard
    
    init() {
        userDefaults.register(
            defaults: [
                Constants.hasLoggedInBefore: false
            ]
        )
    }
    
    public var userHasCompletedOnboarding: Bool {
        getHasLoggedIn()
    }
    
    public var cachedUser: User? {
        getUser()
    }
}

extension UserDefaultsStorageManager {
    
    private func getUser() -> User? {
        if let userData = userDefaults.data(forKey: Constants.currentUser) {
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: userData)
                return user
            } catch {
                print(DecodingError.decodeFailed(error: error.localizedDescription))
            }
        }
        
        return nil
    }
    
    private func getHasLoggedIn() -> Bool {
        let userHasLoggedIn = userDefaults.bool(forKey: Constants.hasLoggedInBefore)
        print("User has \(userHasLoggedIn ? "" : "not") logged in")
        return userHasLoggedIn
    }
    
    public func setUser(with user: User) {
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(user)
            userDefaults.set(userData, forKey: Constants.currentUser)
        } catch {
            print(EncodingError.encodeFailed(error: error.localizedDescription))
            print(error)
        }
    }
    
    public func setHasLoggedIn(with bool: Bool) {
        userDefaults.set(bool, forKey: Constants.hasLoggedInBefore)
    }
    
    public func saveUserReferenceToUserDefaults(userReference: DocumentReference) {
        UserDefaults.standard.set(userReference.documentID, forKey: Constants.userReference)
        UserDefaults.standard.synchronize()
    }
    
    public func getUserReferenceDocumentID() -> String? {
        let userHasLoggedIn = userDefaults.string(forKey: Constants.userReference)
        return userHasLoggedIn
    }
}
