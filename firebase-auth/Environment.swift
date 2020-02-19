//
//  Environment.swift
//  firebase-auth
//
//  Created by 下田 進一郎 on 2/21/20.
//  Copyright © 2020 Shinichiro Shimoda. All rights reserved.
//

import SwiftUI

struct UIWindowKey: EnvironmentKey {
    static let defaultValue: UIWindow? = nil
}

struct FirebaseAuthKey: EnvironmentKey {
    static let defaultValue: FirebaseAuth? = nil
}

extension EnvironmentValues {
    var window: UIWindow? {
        get {
            self[UIWindowKey.self]
        }
        set {
            self[UIWindowKey.self] = newValue
        }
    }

    var firebaseAuth: FirebaseAuth? {
        get {
            self[FirebaseAuthKey.self]
        }
        set {
            self[FirebaseAuthKey.self] = newValue
        }
    }
}
