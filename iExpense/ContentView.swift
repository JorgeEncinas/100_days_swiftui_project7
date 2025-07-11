//
//  ContentView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/10/25.
//
import SwiftUI

struct SecondView : View {
    let name: String
    
    var body : some View {
        Text("Second View")
        Text("Hello, \(name)!")
    }
}

struct FirstView : View {
    @State private var showingSheet = false
    
    var body : some View {
        Button("Show sheet") {
            //show the sheet
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            //contents of the sheet
            SecondView(name: "Johnny")
        }
    }
}

struct SecondViewWithEnvironment : View {
    let name : String
    @Environment(\.dismiss) var dismiss
    
    var body : some View {
        Text("Hello, \(name)!")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct FirstViewWithEnvironment : View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show sheet") {
            showingSheet.toggle()
        }.sheet(isPresented: $showingSheet) {
            SecondViewWithEnvironment(
                name: "Johnathan"
            )
        }
    }
}

struct DeleteRowsView : View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    
    var body : some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id:\.self) { num in
                        Text("Row \(num)")
                    }
                    .onDelete(perform: removeRows)
                }
                //List(numbers, id:\.self) {
                //    Text("(Row \($0)")
                //}
                //While this second `List` View works,
                //  the `onDelete` modifier ONLY EXISTS ON ForEach
                
                //  To make onDelete work
                //  we need to implement a method that will receive
                //  a SINGLE parameters of type `IndexSet`
                
                //  This is a bit like a Set of Integers
                //  except it's SORTED
                //  and it's just telling use the positions
                //  of ALL the items in the ForEach
                //  that should be removed.
                Button("Add number \(currentNumber)") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }.toolbar {
                EditButton()
            }
        }
    }
}

struct UserDefaultsExample : View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    //We have changed this tapCount to load it from UserDefaults.
    
    // Notice that since you're looking for an `integer`, it will return back `0`
    // if nothing is found.
    // if you retrieve `boolean()` it will return `false`
    
    // Another thing to take into account is that saving this takes time
    // because updates might be done several at a time
    // it waits some time before writing out all changes at once.
    //  So if you try to add tapCount a lot and quickly relaunch the app from XCode
    // your tapCount won't be saved.
    
    var body : some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set( //.standard is the built-in instance attached to our app
                tapCount,
                forKey: "Tap"
            )
            // in more advanced apps you can create your own instances
            // if you want to share defaults across several app extensions
            // you might create your own `UserDefaults` instance
            
            // set() accepts any kind of data
            
            // we attach a string name to this data in `forKey`
            //  we need to use the same key to read the data back out of `UserDefaults`
        }
    }
}

struct UserDefaultsExample2 : View {
    @AppStorage("tapCount2") private var tapCount = 0
    
    // Property Wrapper around `UserDefaults`
    // useful for simple situations like this
    
    // We can ignore UserDefaults entirely, using @AppStorage instead of @State
    
    var body : some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

// 1. Our access to the UserDefaults system is through the `AppStorage` property wrapper
//      it works like State: when the value changes, it will reinvoke
//      the `body` property, so our UI reflects the new data.

// 2. We attach a string name, which is the `UserDefaults` key
//      where we want to store the data.
//      I've used `tapCount`, but it can be anything at all.
//      It doesn't need to match the property name

// 3. The rest of the property is declared as normal, including a default of -
//      it will be used if no existing value is found in UserDefaults.

// The issue with AppStorage is that it doesn't make it easy to
//  handle storing complex objects such as Swift structs
//  probably because it's a bad idea to do so, they made it hard for you to do it.

// When submitting an App to the App Store, Apple asks
//  to let them know WHY you're loading and saving data using UserDefaults / AppStorage

// They want to make sure developers aren't trying to identify users across apps.

//Showing a second sheet
struct ContentView: View {

    var body : some View {
        Text("Hello World")
    }
}

// @ENVIRONMENT
// To programmatically dismiss our view
// This `property wrapper` allows us to create PROPERTIES
//  that store VALUES provided to us externally.
// Light Mode / Dark Mode
// Smaller / Larger font
// Timezone...
// These and more come from the environment.

// We need to ask the environment to dismiss our view,
//      because it might have been presented in ANY number of DIFFERENT WAYS.
//      "Figure out how this view was presented, then dismiss it appropriately".

// UserDefaults.
//  you can store a small amount of data
//  great for simple user preferences.
//  Everything stored in here is automatically loaded when your app launches.

//  if you store a lot in there, your app slows down.
//  aim to store no more than 512 KB there.
//  It's about as much text as days 1-36 have.

//  It's useful for storing things like
//      - When the user last launched the app
//      - Which news story they last read
//      - Ohter passively collected information

//  SwiftUI often can wrap up UserDefaults inside a nice and simple property wrapper
//      called `@AppStorage`
//      it only supports a subset of functionality right now, but it can be really helpful


#Preview {
    ContentView()
}
