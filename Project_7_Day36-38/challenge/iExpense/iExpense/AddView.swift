//
//  AddView.swift
//  iExpense
//
//  Created by Михаил Тихомиров on 15.04.2023.
//

// this is our swiftUI View + to our content View

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses   // that is instead of  @StateObject var expenses = Expenses() in contentView. We just share expenses in this View From contentView
    @Environment(\.dismiss) var dismiss      // that`s for close roll up our sheet after we type save button
    
    @State private var name = ""
    @State private var type = ExpenseType.personal
    @State private var amount = 0.0
    @State private var currency = "USD"
    
    
    let types = ["Business", "Personal"]
    let currencies = ["USD", "RUB"]         // you can add as many currencies as you want to support
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases,id: \.self) {
                        Text ($0.rawValue)
                    }
                }
                HStack{
                    TextField("Amount", value:$amount, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("", selection: $currency) {
                        ForEach (currencies, id: \.self) {
                            Text ($0)
                        }
                    }
                    
                }
                
            }
            .navigationTitle("Add new expense")
            .toolbar{
                Button ("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                    
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())  // we add the parameter here so as canvas over rigth can generate code 
    }
}
