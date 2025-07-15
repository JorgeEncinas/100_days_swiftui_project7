//
//  ListExpensesView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/15/25.
//
import SwiftUI

struct ListExpensesView : View {
    var personalItems : [ExpenseItem2]
    var businessItems : [ExpenseItem2]
    var removeItems : removeItemsType
    
    
    var body : some View {
        List {
            PersonalExpensesView(
                personalItems: personalItems, removeItems: removeItems
            )
            BusinessExpensesView(
                businessItems: businessItems, removeItems: removeItems
            )
        }
    }
}
