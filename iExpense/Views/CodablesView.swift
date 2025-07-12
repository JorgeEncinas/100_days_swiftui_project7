//
//  CodablesView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/11/25.
//
import SwiftUI

// ARCHIVING Swift Objects with `Codable`

//  AppStorage is great for storing simple settings: Integers, Booleans

//  But for complex data, such as custom Swift types
//      we need to do a little more work.

//  Thus we now work with `UserDefaults`


// `Codable` is a PROTOCOL for ARCHIVING and UNARCHIVING data.
//      A fancy way of saying: "Converting objects into plain text and back again"
//  (So serialization/deserialization ?)

// For now, we want to archive a custom type so we can put it into UserDefaults
//  then unarchive it when it comes back OUT from UserDefaults.
struct User2 : Codable { //`User` exists in another view.
    let firstName : String
    let lastName : String
}

// We must tell Swift WHEN it will archive and unarchive User instances, and
// what to do with the data.

// JSONEncoder
//  its job is to take something that conforms to `Codable`
//  and send back that object in JSON

// You don't necessarily need to use JSON, other formats are available.
// We don't care right now, because we're just storing it in UserDefaults for now.

struct CodablesView : View {
    @State private var user = User2(
        firstName: "John",
        lastName: "Johnson"
    )
    
    var body : some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            // data is of type `Data`, designed to store ANY KIND OF DATA you can think of.
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(
                    data,
                    forKey: "UserData"
                )
            }
            //For decoding, we will use JSONDecoder(),
            // and the process is similar.
        }
    }
}

