//
//  NotificationViewModel.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 12/4/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var users = [ListUser]()
    
//    public init() {
//        self.fetchSwipeList()
//    }
    
    public func fetchSwipeList() {
        DatabaseManager.shared.fetchSwipedUsers(completion: { users in
            self.users = users
        })
    }
}
