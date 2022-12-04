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
    var swipeRightList: [ListUser]?
}
