//
//  DeleteRowsView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/11/25.
//
import SwiftUI

struct DeleteRowsView : View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    
    var body : some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id:\.self) { num in
                        Text("Row \(num)")
                    }
                    .onDelete(perform: removeRows)
                }
                //List(numbers, id:\.self) {
                //    Text("(Row \($0)")
                //}
                //While this second `List` View works,
                //  the `onDelete` modifier ONLY EXISTS ON ForEach
                
                //  To make onDelete work
                //  we need to implement a method that will receive
                //  a SINGLE parameters of type `IndexSet`
                
                //  This is a bit like a Set of Integers
                //  except it's SORTED
                //  and it's just telling use the positions
                //  of ALL the items in the ForEach
                //  that should be removed.
                Button("Add number \(currentNumber)") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }.toolbar {
                EditButton()
            }
        }
    }
}
