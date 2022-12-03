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
        
        DatabaseManager.shared.fetchAllUsers(completion: { users in
            print(users)
        }) 
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
