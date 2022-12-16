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
            guard let users = users else {
                print("Could not find any matches")
                return
            }
            
            self.matchedUsers = users
        })
    }
    
    public func fetchNonMatchList() {
        DatabaseManager.shared.fetchListUsers(field: "otherUserSwipedList", completion: { users in
            guard let users = users else {
                print("Could not find any non-matches")
                return
            }
            
            self.blurredUsers = users
        })
    }
}
