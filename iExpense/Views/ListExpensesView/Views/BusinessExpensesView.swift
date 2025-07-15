//
//  BusinessExpensesView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/15/25.
//
import SwiftUI

struct BusinessExpensesView : View {
    var businessItems : [ExpenseItem2]
    var removeItems : (_ idArray: [UUID]) -> Void
    
    var body : some View {
        Section("Business") {
            ForEach(businessItems) { item in
                ExpensesListItemView(item: item)
            }.onDelete { (indexOffsets : IndexSet) in
                let itemsBusiness : [UUID] = indexOffsets.reduce(into: [UUID]()) { (result : inout [UUID], index : Int) in
                    if (businessItems.indices.contains(index)) {
                        result.append(businessItems[index].id)
                    }
                }
                //Now itemsPersonal is a list of UUIDs, and we can use that to delete them!
                removeItems(itemsBusiness)
            }
        }
    }
}
