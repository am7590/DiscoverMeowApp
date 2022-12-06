//
//  NotificationViewModel.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 12/4/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var matchedUsers = [ListUser]()
    @Published var blurredUsers = [ListUser]()
    
//    public init() {
//        self.fetchSwipeList()
//    }
    
    public func fetchMatchList() {
        DatabaseManager.shared.fetchListUsers(field: "matchList", completion: { users in
            self.matchedUsers = users
        })
    }
    
    public func fetchNonMatchList() {
        DatabaseManager.shared.fetchListUsers(field: "otherUserSwipedList", completion: { users in
            self.blurredUsers = users
        })
    }
}
