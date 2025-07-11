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

//Showing a second sheet
struct ContentView: View {
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



#Preview {
    ContentView()
}
