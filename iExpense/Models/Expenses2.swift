//
//  Expenses2.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/15/25.
//
import SwiftUI

@Observable
class Expenses2 {
    var items = [ExpenseItem2]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(
                    encoded,
                    forKey: "Items"
                )
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(
            forKey: "Items"
        ) {
            if let decodedItems = try? JSONDecoder().decode(
                [ExpenseItem2].self, //Here, `.self` is about specifying that we're referring to the type!
                from: savedItems
            ) {
                self.items = decodedItems
                return
            }
        }
        self.items = []
    }
}

