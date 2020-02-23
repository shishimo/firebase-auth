//
//  FUser.swift
//  firebase-auth
//
//  Created by 下田 進一郎 on 2/21/20.
//  Copyright © 2020 Shinichiro Shimoda. All rights reserved.
//

import Combine
import FirebaseUI
import SwiftUI

final class FUser: ObservableObject {

    @Published var firebaseUser: User? = nil

    func uid() -> String {
        if let u = self.firebaseUser {
            return u.uid
        }
        return ""
    }
}
