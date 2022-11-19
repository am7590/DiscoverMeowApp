//
//  SnapchatDataFetcher.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/17/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation
import SCSDKLoginKit

final class SnapchatDataFetcher {
    
    static let shared = SnapchatDataFetcher()
    
    public func fetchUserData() {
        
        let builder = SCSDKUserDataQueryBuilder().withDisplayName().withBitmojiTwoDAvatarUrl().withExternalId().withProfileLink().withIdToken().withBitmojiTwoDAvatarUrl()
        SCSDKLoginClient.fetchUserData(
            with: builder.build(),
            success:  { (userData, errors) in
                guard let userData = userData, let token = userData.idToken else { fatalError("No User Data") }
                
                // Check existing tokens for user
                let existingToken = DatabaseManager.shared.checkIfUserTokenExists(token: token)
                if existingToken {
                    print("Access users info in db")
                } else {
                    // If there's no token, create user
                    do {
                        let displayName = userData.displayName ?? "No Name"
                        let bitmojiURL = URL(string: userData.bitmojiTwoDAvatarUrl ?? "")!
                        let currentUser = User(displayName: displayName, bitmojiURL: bitmojiURL, token: token)
                        
                        DatabaseManager.shared.addUserInfo(user: currentUser)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
                
                
            },
            failure: { (error: Error?, isUserLoggedOut: Bool) in
                if let error = error {
                    print(String.init(format: "Failed to fetch user data. Details: %@", error.localizedDescription))
                }
            })
    }
}
