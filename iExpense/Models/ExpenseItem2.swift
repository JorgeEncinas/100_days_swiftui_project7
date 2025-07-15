//
//  ExpenseItem2.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/15/25.
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
