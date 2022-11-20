//
//  User.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/18/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?  /// do not write to this
    let displayName: String
    let bitmojiURL: URL
    let token: String
    
    public init(data: [String: Any]) {
        self.displayName = data["displayName"] as? String ?? ""
        let bitmojiURL = data["bitmojiURL"] as? String ?? ""
        self.bitmojiURL = URL(string: bitmojiURL)!
        self.token = data["token"] as? String ?? ""
    }
}
