//
//  Untitled.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/10/25.
//
import SwiftUI
import Observation

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

// @OBSERVABLE
//      The line is a `macro`.
//      Swift quietly rewrites our code to add EXTRA FUNCTIONALITY
//  We imported `Observation` afterwards bc we're going to look into the definition
//  Right-click the `@Observable` in code to see the code. (Control+Click -> Expand Macro)

//  THREE THINGS TO NOTE.
//      1. Your properties are marked with `@ObservationTracked`
//          it means that Swift and SwiftUI are watching them for changes
//      2. If you right-click @ObservationTracked, you can expand THAT macro too.
//          This macro tracks when a property is read/written, so that SwiftUI
//          updates ONLY views that ABSOLUTELY NEED to be refreshed
//      3. Our class is made to conform to the `Observable` protocol.
//          Some parts of SwiftUI interpret this as "This class can be watched for changes"


// @State on STRUCT vs on CLASS
//      On structs it
//          1. keeps a value alive
//          2. Watches it for changes
//      on classes it just
//          1. Keeps alive an object!
//      Watching for changes and updating the view becomes the job of @Observable.

struct ClassObservation : View {
    @State private var user = User()
    
    var body : some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
        .padding()
    }
}
