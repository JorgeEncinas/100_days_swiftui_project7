//
//  ContentView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/10/25.
//
import SwiftUI



struct ContentView: View {
    @State private var showingAddExpense = false
    @State private var expenses = Expenses2()
    

    var body : some View {
        ZStack {
            ExpensesListView2(
                expenses: $expenses,
                showingAddExpense: $showingAddExpense
            )
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
        //CodablesView()
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
