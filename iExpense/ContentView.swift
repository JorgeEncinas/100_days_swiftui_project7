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



#Preview {
    ContentView()
}
