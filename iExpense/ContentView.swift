//
//  ContentView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/10/25.
//

import SwiftUI

// First we had this, but since we need to share, we will change it into a class instead.
//struct User {
//    var firstName = "Bilbo"
//    var lastName = "Baggins"
//}

// This one doesn't work with `@State` though
// that's because with `struct`s, each time we modify it, we actually create
// a NEW INSTANCE of struct.
// But with `class`es, the value is modified directly.
@Observable //Fixes the @State issue.
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

// Classes don't need the `mutating` keyword for functions that modify variables,
// unlike `struct`s.
// @State does NOT monitor the State variables.

struct ContentView: View {
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
