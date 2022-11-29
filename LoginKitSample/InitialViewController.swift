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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if SCSDKLoginClient.isUserLoggedIn {
            moveToDiscoverView()
        }
        
        if !UserDefaultsStorageManager.shared.userHasCompletedOnboarding {
            moveToOnboardingView()
        }
        
        messageLabel?.textColor = .black
        titleLabel?.textColor = .black
    }
}

// TODO: Depreciated code
extension InitialViewController {
    fileprivate func moveToDiscoverView() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: DiscoverView())
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }

    fileprivate func moveToOnboardingView() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: MainOnboardingView())
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }

    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        SCSDKLoginClient.login(from: self) { (success: Bool, error: Error?) in
            if success {
                self.moveToOnboardingView()
                UserDefaultsStorageManager.shared.setHasLoggedIn(with: false)
            }
            if let error = error {
                print("Login failed. Details: %@", error.localizedDescription)
            }
        }
    }
}
