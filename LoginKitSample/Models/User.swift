//
//  User.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/18/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
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
    
    public init(displayName: String, bitmojiURL: URL, token: String) {
        self.displayName = displayName
        self.bitmojiURL = bitmojiURL
        self.token = token
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.displayName = try container.decode(String.self, forKey: .displayName)
        self.bitmojiURL = try container.decode(URL.self, forKey: .bitmojiURL)
        self.token = try container.decode(String.self, forKey: .token)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.displayName, forKey: .displayName)
        try container.encode(self.bitmojiURL, forKey: .bitmojiURL)
        try container.encode(self.token, forKey: .token)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, displayName, bitmojiURL, token
    }
}

var dummyData = [
    User(displayName: "Alek", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-J8HAwwRJMzm411zWHUNU3V_68yXHukZVqxfbb_IwWGaE~YK_NKFXDg-v1.png?transparent=1&palette=1")!, token: ""),
    User(displayName: "Alek", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-J8HAwwRJMzm411zWHUNU3V_68yXHukZVqxfbb_IwWGaE~YK_NKFXDg-v1.png?transparent=1&palette=1")!, token: ""),
    User(displayName: "Alek", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-J8HAwwRJMzm411zWHUNU3V_68yXHukZVqxfbb_IwWGaE~YK_NKFXDg-v1.png?transparent=1&palette=1")!, token: ""),
    User(displayName: "Alek", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-J8HAwwRJMzm411zWHUNU3V_68yXHukZVqxfbb_IwWGaE~YK_NKFXDg-v1.png?transparent=1&palette=1")!, token: ""),
    User(displayName: "Alek", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-J8HAwwRJMzm411zWHUNU3V_68yXHukZVqxfbb_IwWGaE~YK_NKFXDg-v1.png?transparent=1&palette=1")!, token: ""),
    User(displayName: "Alek", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-J8HAwwRJMzm411zWHUNU3V_68yXHukZVqxfbb_IwWGaE~YK_NKFXDg-v1.png?transparent=1&palette=1")!, token: ""),
    User(displayName: "Alek", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-J8HAwwRJMzm411zWHUNU3V_68yXHukZVqxfbb_IwWGaE~YK_NKFXDg-v1.png?transparent=1&palette=1")!, token: ""),
    User(displayName: "Alek", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-J8HAwwRJMzm411zWHUNU3V_68yXHukZVqxfbb_IwWGaE~YK_NKFXDg-v1.png?transparent=1&palette=1")!, token: ""),
    User(displayName: "Alek", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-J8HAwwRJMzm411zWHUNU3V_68yXHukZVqxfbb_IwWGaE~YK_NKFXDg-v1.png?transparent=1&palette=1")!, token: ""),
    User(displayName: "Alek", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-J8HAwwRJMzm411zWHUNU3V_68yXHukZVqxfbb_IwWGaE~YK_NKFXDg-v1.png?transparent=1&palette=1")!, token: "")
    
    
]
