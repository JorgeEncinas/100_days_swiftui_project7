//
//  IdentifiableExpensesListView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/11/25.
//
import SwiftUI

struct ExpensesListItemView : View {
    var item : ExpenseItem2
    
    var body : some View {
        HStack
        {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }

            Spacer()
        Text(
            item.amount,
            format: .currency(
                code: Locale.current.currency?.identifier ?? "USD"
                )
        )
        .expenseItemCustomModifier(item: item)
        
        }
    }
}

