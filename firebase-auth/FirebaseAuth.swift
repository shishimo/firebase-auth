//
//  FirebaseAuth.swift
//  firebase-auth
//
//  Created by 下田 進一郎 on 2/21/20.
//  Copyright © 2020 Shinichiro Shimoda. All rights reserved.
//
import FirebaseUI

class FirebaseAuth: NSObject, FUIAuthDelegate {

    var user: FUser
    var authUI: FUIAuth? = nil
    var authViewController: UINavigationController? = nil

    init(user: FUser) {

        self.user = user

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
        self.user.firebaseUser = user
    }

    func signout() {
        if let auth = self.authUI {
            try! auth.signOut()
            self.user.firebaseUser = nil
        }
    }

}
