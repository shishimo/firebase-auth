//
//  FirebaseAuth.swift
//  firebase-auth
//
//  Created by 下田 進一郎 on 2/21/20.
//  Copyright © 2020 Shinichiro Shimoda. All rights reserved.
//
import FirebaseUI

class FirebaseAuth: NSObject, FUIAuthDelegate {

    var authUI: FUIAuth? = nil
    var authViewController: UINavigationController? = nil

    override init() {

        super.init()

        let providers: [FUIAuthProvider] = [
            FUIFacebookAuth()
        ]

        self.authUI = FUIAuth.defaultAuthUI()

        if let authUI = self.authUI {
            authUI.delegate = self
            authUI.providers = providers
            self.authViewController = authUI.authViewController()
        }

    }

    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if user == nil {
            print("Error: \(String(describing: error))")
        }
        print("User ID: \(String(describing: user?.uid))")
    }

}
