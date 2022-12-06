//
//  DiscoverViewModel.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/18/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import Foundation
import SCSDKLoginKit

class DiscoverViewModel: ObservableObject {
    
    enum LoadingState {
        case loading, loaded, error
    }
    
    @Published var loadingState: LoadingState = .loading
    @Published var displayName: String?
    @Published var bitmojiURL: URL?
    @Published var swipeCount: Int = 0
    @Published var users = [User]()
    @Published var selectedUser: User?
    var otherUserSwipeList: [ListUser]?
    
    public init() {
        self.fetchCachedUserData()
        self.fetchUserData()
    }
    
    public func triggerConfetti() {
        self.swipeCount += 1
        
        // if I am in selectedUser's swipe list, add me to their match list, and add them to my match list
        // else, add me to their swipe list
        
        
        DatabaseManager.shared.fetchListUsers(field: "otherUserSwipedList", completion: { users in
            self.otherUserSwipeList = users
            
            if ((self.otherUserSwipeList?.contains(where: {$0.displayName == UserDefaultsStorageManager.shared.cachedUser?.displayName})) == nil) {
                print("adding to otherUserSwipedList")
                if let currentUser = UserDefaultsStorageManager.shared.cachedUser, let userReference = self.selectedUser?.id {
                    DatabaseManager.shared.addUserToList(field: "otherUserSwipedList", user: currentUser.getListUser(), reference: userReference)
                }
            } else {
                print("adding to matchList")
                if let currentUser = UserDefaultsStorageManager.shared.cachedUser, let userReference = self.selectedUser?.id {
                    DatabaseManager.shared.addUserToList(field: "matchList", user: currentUser.getListUser(), reference: userReference)
                    DatabaseManager.shared.addUserToList(field: "matchList", user: (self.selectedUser?.getListUser())!, reference: UserDefaultsStorageManager.shared.getUserReferenceDocumentID()!)
                }
            }
        })
        
        // TODO: Remove users from swipeRightList
        // TODO: Request message
        
        
       
        
        //DatabaseManager.shared.addUserToSwipedArray(user: self.selectedUser!.getListUser())
    }
    
    public func fetchUserData() {
        print("Fetching user data from LoginKit")
        let builder = SCSDKUserDataQueryBuilder().withDisplayName().withBitmojiTwoDAvatarUrl().withExternalId().withProfileLink().withIdToken().withBitmojiTwoDAvatarUrl()
        SCSDKLoginClient.fetchUserData(
            with: builder.build(),
            success:  { (userData, errors) in
                guard let userData = userData, let token = userData.externalID, let name = userData.displayName, let url = userData.bitmojiTwoDAvatarUrl else { fatalError("No User Data") }
                
                DispatchQueue.main.async {
                    self.displayName = userData.displayName ?? "No Name"
                    self.bitmojiURL = URL(string: userData.bitmojiTwoDAvatarUrl ?? "")!
                }

                let currentUser = User(displayName: name, bitmojiURL: URL(string: url)!, token: token)
                DatabaseManager.shared.doesUserExist(user: currentUser)
                UserDefaultsStorageManager.shared.setUser(with: currentUser)  // Caches User struct in UserDefaults. It will still refresh upon each login to refresh bitmoji url.
                UserDefaultsStorageManager.shared.setHasLoggedIn(with: true)
            },
            failure: { (error: Error?, isUserLoggedOut: Bool) in
                if let error = error {
                    print(String.init(format: "Failed to fetch user data. Details: %@", error.localizedDescription))
                }
            })
    }
    
    @Published var selectedBitmoji: User = User(displayName: "Alek", bitmojiURL: URL(string: "www.google.com")!, token: "")
    @Published var showSelectedBitmoji = false
    @Published var offset: CGSize = .zero
    @Published var scale : CGFloat = 1
    
    lazy var showClearBitmojiView = { (video: User) in
        return self.showSelectedBitmoji && self.selectedBitmoji.id == video.id
    }
    
    lazy var scaleEffect = { (video: User) in
        return self.showClearBitmojiView(video) ? self.scale : 1
    }
    
    private func fetchCachedUserData() {
        if let user = UserDefaultsStorageManager.shared.cachedUser {
            self.displayName = user.displayName
            self.bitmojiURL = user.bitmojiURL
            print("fetched cached user")
        }
    }
    
    public func loadUsers() {
        DatabaseManager.shared.fetchAllUsers(completion: { users in
            self.users = users
        })
    }
}
