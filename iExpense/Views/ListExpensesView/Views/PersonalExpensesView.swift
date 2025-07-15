//
//  PersonalExpensesView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/15/25.
//
import SwiftUI

struct PersonalExpensesView : View {
    var personalItems : [ExpenseItem2]
    var removeItems : removeItemsType
    
    var body : some View {
        Section("Personal") {
            ForEach(personalItems) { item in
                ExpensesListItemView(item: item)
            }.onDelete { (indexOffsets : IndexSet) in
                let itemsPersonal : [UUID] = indexOffsets.compactMap { (index : Int) in
                    if (personalItems.indices.contains(index)) {
                        return personalItems[index].id
                    }
                    return nil
                }
                //Now itemsPersonal is a list of UUIDs, and we can use that to delete them!
                removeItems(itemsPersonal)
            }
        }
    }
    
}
