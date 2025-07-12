//
//  ExpensesListView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/11/25.
//
import SwiftUI

// Let's create a list showing some expenses.
//  instead of using @State, let's use an `Expenses` class
//  attached to our list using @State

//  This lets the `Expenses` class load and save itself seamlessly.

struct ExpenseItem {
    let name : String
    let type : String
    let amount : Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}

struct ExpensesListView : View {
    @State private var expenses = Expenses()
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body : some View {
        NavigationStack {
            List {
                ForEach(expenses.items, id:\.name) { item in
                    // the `name` property might not necessarily be
                    // an appropriate unique identifier
                    // perhaps an `id` property of sorts is warranted, right?
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = ExpenseItem(
                        name: "Test",
                        type: "Personal",
                        amount: 5
                    )
                    expenses.items.append(expense)
                }
                EditButton()
            }
        }
    }
}

