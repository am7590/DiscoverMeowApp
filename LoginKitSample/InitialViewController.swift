//
//  LoginViewController.swift
//  LoginKitSample
//
//  Created by Samuel Chow on 1/9/19.
//  Copyright © 2019 Snap Inc. All rights reserved.
//

import UIKit
import SwiftUI
import SCSDKLoginKit

class InitialViewController: UIViewController {
    
    @IBOutlet fileprivate weak var loginButton: UIButton?
    @IBOutlet fileprivate weak var messageLabel: UILabel?
    @IBOutlet fileprivate weak var loginView: UIView?
    @IBOutlet fileprivate weak var titleLabel: UILabel?
    
    let discoverViewModel = DiscoverViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if SCSDKLoginClient.isUserLoggedIn && UserDefaultsStorageManager.shared.userHasCompletedOnboarding {
            moveToDiscoverView()
        }
        
        messageLabel?.textColor = .black
        titleLabel?.textColor = .black
        
        
//        let fakeUserList = [
//            User(displayName: "User1", bitmojiURL: URL(string: "https://avatars.githubusercontent.com/u/3534427?v=4")!, token: "User1Token"),
//            User(displayName: "User2", bitmojiURL: URL(string: "https://i.pinimg.com/originals/6d/0e/05/6d0e052a59840858186a37ba74de24b3.png")!, token: "User2Token"),
//            User(displayName: "User3", bitmojiURL: URL(string: "https://blog.tcea.org/wp-content/uploads/2020/12/happyface_noneck.png")!, token: "User3Token"),
//            User(displayName: "User4", bitmojiURL: URL(string: "https://i.pinimg.com/originals/6c/3a/19/6c3a191d302fcfc2ff7320fdd54ca664.png")!, token: "User4Token"),
//            User(displayName: "User5", bitmojiURL: URL(string: "https://i.pinimg.com/originals/5a/90/53/5a9053e149285b43f8dd58f842267f3c.png")!, token: "User5Token"),
//            User(displayName: "User6", bitmojiURL: URL(string: "https://www.drupal.org/files/user-pictures/picture-3688118-1632824492.png")!, token: "User6Token"),
//            User(displayName: "User7", bitmojiURL: URL(string: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/2b65ca6a-2e94-4b14-b8b3-fc4fc3ffa328/daoc64d-4fb367a7-325e-41c4-9099-dce58802d0e3.png/v1/fill/w_396,h_398,strp/my_bitstrips_avatar_bitmoji_style__by_isaiahcontrerasage08_daoc64d-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9Mzk4IiwicGF0aCI6IlwvZlwvMmI2NWNhNmEtMmU5NC00YjE0LWI4YjMtZmM0ZmMzZmZhMzI4XC9kYW9jNjRkLTRmYjM2N2E3LTMyNWUtNDFjNC05MDk5LWRjZTU4ODAyZDBlMy5wbmciLCJ3aWR0aCI6Ijw9Mzk2In1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.WlUKFbAFCUg97h8VSvOogaflSu_m1P5lH0hkYqPWtug")!, token: "User7Token")
//        ]
//
//        DatabaseManager.shared.addFakeUsersToDB(users: fakeUserList)

    }
}

// TODO: Depreciated code
extension InitialViewController {
    fileprivate func moveToDiscoverView() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: DiscoverView(viewModel: self.discoverViewModel))
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    fileprivate func moveToOnboardingView() {
        UserDefaultsStorageManager.shared.setHasLoggedIn(with: false)
        
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: MainOnboardingView())
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        SCSDKLoginClient.login(from: self) { (success: Bool, error: Error?) in
            if success {
                self.moveToOnboardingView()
                self.discoverViewModel.fetchUserData()
            }
            if let error = error {
                print("Login failed. Details: %@", error.localizedDescription)
            }
        }
    }
}


