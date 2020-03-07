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

    @State private var collection = "users"
    @State private var document = ""
    @State private var nickname = ""
    @State private var showAlert = false

    var alert: Alert {
        Alert(title: Text("iOScreator"), message: Text("Hello SwiftUI"), dismissButton: .default(Text("Dismiss")))
    }

    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 5) {
                Text("User ID:")
                Text(user.uid())
            }
            TextField("Input collection name", text: $collection,
                onEditingChanged: { begin in
                    if !begin {
                        print("Edit end: input data: \(self.collection)")
                    }
                }
            )
           .textFieldStyle(RoundedBorderTextFieldStyle())
           .padding()
            TextField("Input document name", text: $document,
                onEditingChanged: { begin in
                    if !begin {
                        print("Edit end: input data: \(self.document)")
                    }
                }
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            TextField("Input nickname", text: $nickname,
                onEditingChanged: { begin in
                    if !begin {
                        print("Edit end: input data: \(self.nickname)")
                    }
                }
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            Button(action: {
                if self.document == "" || self.collection == "" {
                    print("no doc or no collection")
                    self.showAlert = true
                    return
                }
                if self.user.uid() == "" {
                    print("not logged in")
                    return
                }
                let db = Firestore.firestore()
                db.collection(self.collection).document(self.document).setData([
                    "uid": self.user.uid(),
                    "nickname": self.nickname,
                    "updated_at": FieldValue.serverTimestamp(),
                ], merge: true)
            }) {
                Text("Save")
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .border(Color.red, width: 5)
                .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                self.alert
            }

            Spacer()
            HStack {
                Button(action: {
                    let db = Firestore.firestore()
                    db.collection("users").getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            let num = querySnapshot!.documents.count
                            print("Get \(num) documents")
                        }
                    }
                }) {
                    Text("Get Information")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .padding(10)
                        .border(Color.red, width: 5)
                        .cornerRadius(10)
                }   .border(Color.blue, width: 1)
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
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .border(Color.blue, width: 5)
                        .cornerRadius(10)
                }   .border(Color.blue, width: 1)
            }
            HStack {
                Button(action: {
                    self.window?.rootViewController?.present(self.firebaseAuth!.authViewController!, animated: true, completion: nil)
                }) {
                    Text("Login")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .padding(10)
                    .border(Color.green, width: 5)
                    .cornerRadius(10)
                }
                Button(action: {
                    if let auth = self.firebaseAuth {
                        auth.signout()
                    }
                }) {
                    Text("Logout")
                    .fontWeight(.bold)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FUser())
    }
}
