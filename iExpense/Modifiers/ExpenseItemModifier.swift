//
//  ExpenseItemModifier.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/15/25.
//
import SwiftUI

struct ExpenseItemModifier : ViewModifier {
    var item : ExpenseItem2
    
    func body(content: Content) -> some View {
        content
        .foregroundStyle(
            item.amount < 10.0 ? .red :
                item.amount < 100.0 ?
                    .yellow : .green
        )
    }
}

extension View {
    func expenseItemCustomModifier(item: ExpenseItem2) -> some View {
        modifier(ExpenseItemModifier(item: item))
    }
}

