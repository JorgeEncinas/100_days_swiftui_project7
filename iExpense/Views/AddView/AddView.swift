//
//  AddView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/11/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = "Add new expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Binding var expenseItems: [ExpenseItem2]
    
    let types = ["Business", "Personal"]
    
    var body : some View {
        Form {
            TextField("Name", text: $name)
            
            Picker("Type", selection: $type) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }
            
            TextField(
                "Amount",
                value: $amount,
                format: .currency(code: Locale.current.currency?.identifier ?? "USD")
            )
            .keyboardType(.decimalPad)
        }
        .navigationTitle($name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let item = ExpenseItem2(
                        name: name,
                        type: type,
                        amount: amount
                    )
                    expenseItems.append(item)
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    @Previewable @State var expenses = Expenses2()
    AddView(expenseItems: $expenses.items)
}
