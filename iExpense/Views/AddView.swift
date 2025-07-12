//
//  AddView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/11/25.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    var expenses: Expenses2
    
    let types = ["Business", "Personal"]
    
    var body : some View {
        NavigationStack {
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
                    format: .currency(code: "USD")
                )
                .keyboardType(.decimalPad)
            }.navigationTitle("Add new Expense")
        }
    }
}

#Preview {
    let expenses = Expenses2()
    AddView(expenses: expenses)
}
