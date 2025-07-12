//
//  UserDefaultsView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/11/25.
//
import SwiftUI

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


