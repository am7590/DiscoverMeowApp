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
    let displayName: String
    let bitmojiURL: URL
    @DocumentID var token: String?
}
