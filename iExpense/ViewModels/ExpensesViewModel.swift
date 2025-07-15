//
//  ExpensesViewModel.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/15/25.
//
import SwiftUI

typealias removeItemsType = (_ idArray : [UUID]) -> Void

class ExpensesViewModel : ObservableObject {
    @Published var expenses : Expenses2 = .init()
    @Published var showingAddExpense : Bool = false
    
    var personalItems : [ExpenseItem2] {
        filterItems(target: "Personal")
    }
    
    var businessItems : [ExpenseItem2] {
        filterItems(target: "Business")
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func removeItems(idArray : [UUID]) {
        for id in idArray {
            let actualIndexSet = expenses.items.firstIndex(where: { (item : ExpenseItem2) in
                return item.id == id
            })
            
            if let unwrappedIndexSet = actualIndexSet { //Checking it's not `nil`
                expenses.items.remove(at: unwrappedIndexSet)
            }
        }
    }
    
    func filterItems(target: String) -> [ExpenseItem2] {
        return expenses.items.filter { $0.type == target }
    }
    
    init() {
        
    }
}
