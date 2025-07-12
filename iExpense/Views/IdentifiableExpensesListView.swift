//
//  IdentifiableExpensesListView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/11/25.
//
import SwiftUI

// Identifiable items
//  with static views SwiftUI has no problem
//  with List and ForEach, making dynamic views,
//  SwiftUI needs to know how to identify
//  each item uniquely.

// On our ExpensesListView,
// we were lucky before even if they had the same name,
// because the `List` knew exactly which row we were swiping on


// But in many other places that extra information won't be available
// and we'll get unexpected results.

// the identifier we're using, is not unique, and we need it to be.
// Thus, we should add an ID property

struct ExpenseItem2 : Identifiable, Codable {
    var id : UUID = UUID() //Since all instances begin with a UUID, even an empty one, you can't use `let` now that it's serializable.
    let name : String
    let type : String
    let amount : Double
}

// Using UUID means we need to generate the UUID by hand
// then lOAD and SAVE the UUID alongside our data.
// in this instance, we'll ask Swift to generate a UUID automatically for us
// by creating it with UUID()

// We'll also conform it to a new protocol
//  IDENTIFIABLE
//      Means that "this type can be identified uniquely"
//      And it just requires a property `id` that contains a UNIQUE IDENTIFIER

//  We just added that, so we don't need to do any extra work.
//  Our type conforms to Identifiable as is.
//  What's the bonus?
//      We no longer need to tell ForEach what the `id` property should be!
//  ForEach(expenses.items) { item in
//      Text(item.name)
//  }


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

struct ExpensesListView2 : View {
    @Binding var expenses: Expenses2
    @Binding var showingAddExpense : Bool
    
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
    
    var personalItems : [ExpenseItem2] {
        filterItems(target: "Personal")
    }
    
    var businessItems : [ExpenseItem2] {
        filterItems(target: "Business")
    }
    
    var body : some View {
        NavigationStack {
            List {
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
                        removeItems(idArray: itemsPersonal)
                    }
                }
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
                        removeItems(idArray: itemsBusiness)
                    }
                }
                //ForEach(expenses.items) { item in //id:\.id
                //    ExpensesListItemView(item: item)
                //}
                //.onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    //let expense = ExpenseItem2(
                    //    name: "Test",
                    //    type: "Personal",
                    //    amount: 5
                    //)
                    //expenses.items.append(expense)
                    showingAddExpense = true
                }
                EditButton()
            }
        }
    }
}
