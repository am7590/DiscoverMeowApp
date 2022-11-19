//
//  BitmojiDataFetcher.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/17/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation
import SCSDKLoginKit

final class BitmojiDataFetcher {
    
    static let shared = BitmojiDataFetcher()
    
    func getBitmoji() {
        let builder = SCSDKUserDataQueryBuilder().withDisplayName().withBitmojiTwoDAvatarUrl()
        SCSDKLoginClient.fetchUserData(
            with: builder.build(),
            success:  { (userData, errors) in
                let displayName = userData?.displayName ?? ""
                let avatar = userData?.bitmojiTwoDAvatarUrl ?? ""
                
                DatabaseManager.shared.addUserInfo(data: ["displayName": displayName])
                
                    //self.loadAndDisplayAvatar(url: URL(string: avatar))
                    print(displayName)
                    print(avatar)
            },
            failure: { (error: Error?, isUserLoggedOut: Bool) in
                if let error = error {
                    print(String.init(format: "Failed to fetch user data. Details: %@", error.localizedDescription))
                }
            })
    }
}
