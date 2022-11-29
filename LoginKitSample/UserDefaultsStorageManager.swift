//
//  UserDefaultsStorageManager.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/28/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation

final class UserDefaultsStorageManager {
    
    struct Constants {
        static let hasLoggedInBefore = "hasLoggedInBefore"
        static let currentUser = "currentUser"
    }
    
    init() {
        
    }
    
    static let shared = UserDefaultsStorageManager()
    
    let userDefaults = UserDefaults.standard
    
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
        return userDefaults.bool(forKey: Constants.hasLoggedInBefore)
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
}
