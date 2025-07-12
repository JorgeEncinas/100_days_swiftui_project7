//
//  OpenAnotherView.swift
//  iExpense
//
//  Created by Jorge Encinas on 7/11/25.
//
import SwiftUI

struct SecondView : View {
    let name: String
    
    var body : some View {
        Text("Second View")
        Text("Hello, \(name)!")
    }
}

struct FirstView : View {
    @State private var showingSheet = false
    
    var body : some View {
        Button("Show sheet") {
            //show the sheet
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            //contents of the sheet
            SecondView(name: "Johnny")
        }
    }
}

struct SecondViewWithEnvironment : View {
    let name : String
    @Environment(\.dismiss) var dismiss
    
    var body : some View {
        Text("Hello, \(name)!")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct FirstViewWithEnvironment : View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show sheet") {
            showingSheet.toggle()
        }.sheet(isPresented: $showingSheet) {
            SecondViewWithEnvironment(
                name: "Johnathan"
            )
        }
    }
}
