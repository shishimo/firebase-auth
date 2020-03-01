//
//  ContentView.swift
//  firebase-auth
//
//  Created by Shinichiro Shimoda on 2019/10/02.
//  Copyright © 2019 Shinichiro Shimoda. All rights reserved.
//

import Firebase
import SwiftUI

struct ContentView: View {

    @Environment(\.window) var window
    @Environment(\.firebaseAuth) var firebaseAuth

    @EnvironmentObject var user: FUser

    var body: some View {
        VStack {
            Text("User ID:")
            Text(user.uid())
            Spacer()
            Button(action: {
                let db = Firestore.firestore()

                // Add a new document with a generated ID
                var ref: DocumentReference? = nil
                ref = db.collection("users").addDocument(data: [
                    "nickname": "shishimo",
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
            }) {
                Text("User Create")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .padding(10)
                    .border(Color.blue, width: 5)
                    .cornerRadius(10)
            }   .border(Color.blue, width: 1)
            Spacer()
            Button(action: {
                self.window?.rootViewController?.present(self.firebaseAuth!.authViewController!, animated: true, completion: nil)
            }) {
                Text("Login")
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .padding(10)
                .border(Color.green, width: 5)
                .cornerRadius(10)
            }
            .frame(width: 250, height: 200, alignment: .center)
            Spacer()
            Button(action: {
                if let auth = self.firebaseAuth {
                    auth.signout()
                }
            }) {
                Text("Logout")
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .padding(10)
                .border(Color.purple, width: 5)
                .cornerRadius(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FUser())
    }
}
