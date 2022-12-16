//
//  ListUser.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 12/4/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation

struct ListUser: Codable {
    let displayName: String
    let bitmojiURL: URL
    let country: String?
    var otherUserSwipedList: [ListUser]?
    let requestMessage: String?
}

/// Preserves memberwise init
extension ListUser {
    public init(data: [String: Any]) {
        self.displayName = data["displayName"] as? String ?? ""
        let bitmojiURL = data["bitmojiURL"] as? String ?? ""
        self.bitmojiURL = URL(string: bitmojiURL)!
        self.country = data["country"] as? String ?? "US"
        self.otherUserSwipedList = data["otherUserSwipedList"] as? [ListUser] ?? []
        self.requestMessage = data["requestMessage"] as? String ?? nil
    }
}
