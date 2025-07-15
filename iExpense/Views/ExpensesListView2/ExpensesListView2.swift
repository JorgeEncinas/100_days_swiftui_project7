//
//  ExpensesListView2.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/15/25.
//
import SwiftUI

enum ScreenTypes : Hashable {
    case addView
}

struct ExpensesListView2 : View {
    @StateObject private var expensesVM = ExpensesViewModel()
    @State private var navPath = [ScreenTypes]()
    
    var body : some View {
        NavigationStack(path: $navPath) {
                ListExpensesView(
                    personalItems: expensesVM.personalItems,
                    businessItems: expensesVM.businessItems,
                    removeItems: expensesVM.removeItems(idArray:)
                )
                .navigationTitle("iExpense")
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        //let expense = ExpenseItem2(
                        //    name: "Test",
                        //    type: "Personal",
                        //    amount: 5
                        //)
                        //expenses.items.append(expense)
                        //showingAddExpense = true
                        navPath.append(.addView)
                    }
                    EditButton()
                }
                .navigationDestination(for: ScreenTypes.self) { (type : ScreenTypes) in
                    AddView(
                        expenseItems: $expensesVM.expenses.items
                    )
                }
                //ForEach(expenses.items) { item in //id:\.id
                //    ExpensesListItemView(item: item)
                //}
                //.onDelete(perform: removeItems)
        }
            
    }
}

