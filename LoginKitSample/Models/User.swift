//
//  User.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/18/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct User: Codable, Identifiable {
    @DocumentID var id: String?  /// do not write to this- populated by Firebase
    let displayName: String
    let bitmojiURL: URL
    let token: String
    let country: String?
    let birthdate: Date?
    var matchList: [ListUser]?
    var otherUserSwipedList: [ListUser]?
    
    public init(data: [String: Any]) {
        let userId = data["id"] as? DocumentID<DocumentReference>
        self.id = userId?.wrappedValue?.documentID
        self.displayName = data["displayName"] as? String ?? ""
        let bitmojiURL = data["bitmojiURL"] as? String ?? ""
        self.bitmojiURL = URL(string: bitmojiURL)!
        self.token = data["token"] as? String ?? ""
        self.country = data["country"] as? String ?? "US"
        self.birthdate = data["birthdate"] as? Date ?? Date()
        self.matchList = data["matchList"] as? [ListUser] ?? []
        self.otherUserSwipedList = data["otherUserSwipedList"] as? [ListUser] ?? []
    }
    
    // This is for dummy data only
    public init(displayName: String, bitmojiURL: URL, token: String) {
        self.displayName = displayName
        self.bitmojiURL = bitmojiURL
        self.token = token
        self.country = nil
        self.birthdate = nil
        self.matchList = []
        self.otherUserSwipedList = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(DocumentID<DocumentReference>.self, forKey: .id)?.wrappedValue?.documentID
        self.displayName = try container.decode(String.self, forKey: .displayName)
        self.bitmojiURL = try container.decode(URL.self, forKey: .bitmojiURL)
        self.token = try container.decode(String.self, forKey: .token)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.birthdate = try container.decodeIfPresent(Date.self, forKey: .birthdate)
        self.matchList = try container.decodeIfPresent([ListUser].self, forKey: .matchList) ?? []
        self.otherUserSwipedList = try container.decodeIfPresent([ListUser].self, forKey: .otherUserSwipedList) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.displayName, forKey: .displayName)
        try container.encode(self.bitmojiURL, forKey: .bitmojiURL)
        try container.encode(self.token, forKey: .token)
        try container.encode(self.country, forKey: .country)
        try container.encode(self.birthdate, forKey: .birthdate)
        try container.encode(self.matchList, forKey: .matchList)
        try container.encode(self.otherUserSwipedList, forKey: .otherUserSwipedList)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, displayName, bitmojiURL, token, country, birthdate, matchList, otherUserSwipedList
    }
    
    public func getListUser() -> ListUser {
        return ListUser(displayName: self.displayName, bitmojiURL: self.bitmojiURL, country: self.country, otherUserSwipedList: otherUserSwipedList)
    }
}
