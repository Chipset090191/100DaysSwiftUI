//
//  ContentView.swift
//  iExpense
//
//  Created by Михаил Тихомиров on 12.04.2023.
//

import SwiftUI


struct ContentView:View {
    
    // to make an instance of our class
    @StateObject var expenses = Expenses()   // StateObject - watches for those announcements from Published property that is equal our object
    
    @State private var showingAddExpense = false
    
//    public var currency_formatter:FloatingPointFormatStyle<Double>.Currency {
//        .currency(code: Locale.current.currency?.identifier ?? "USD")
//    }
    
    var body: some View {
        NavigationView{
            displayList()
                .toolbar{
                    Button {
                        showingAddExpense = true
                    }label: {
                        Image (systemName: "plus")
                    }
                }
                .navigationTitle("iExpense")
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
            
        }
    
    func displayList() -> some View {
        let businessExpenses = expenses.items.filter { expenseItem in
            expenseItem.type == ExpenseType.business
        }
        
        let personalExpenses = expenses.items.filter { expenseItem in
            expenseItem.type == ExpenseType.personal
        }
        
        
        return List {
            if !businessExpenses.isEmpty {
                // code
                displayExpenseListByType(title: ExpenseType.business.rawValue, expenses: businessExpenses)
            }
            
            if !personalExpenses.isEmpty {
                // code
                displayExpenseListByType(title: ExpenseType.personal.rawValue, expenses: personalExpenses)
            }
            
        }
    } // end displaylist()
    
    func displayExpenseListByType(title: String, expenses: [ExpenseItem]) -> some View {
        Section (title) {
            ForEach (expenses, id: \.id) { item in
                HStack {
                    VStack(alignment: .leading){
                        Text (item.name)
                            .font(.headline)
                    }

                    Spacer ()

                    Text(item.amount, format: .currency(code: item.currency))
                        .foregroundStyle(item.amount <= 10 ? .green : item.amount > 10 && item.amount <= 100 ? .yellow : item.amount > 100 ? .red : .purple)
                        
                }
            }
            // --------------------------------------------------
            
//            .onDelete{ indexSet in
//                var arrItemIds = [UUID]()
//                for eachIndex in indexSet {
//
//                    arrItemIds.append(expenses[eachIndex].id)
//                }
//
//                removeItemsByIds(ids: arrItemIds)
//            }
            .onDelete(perform: removeItems)
            
            
        }
    }

// this is one of the methods of deleting the objects   ---------
    
//    func removeItemsByIds(ids: [UUID]) {
//        expenses.items = expenses.items.filter{ expenseItem in
//            return ids.contains(expenseItem.id)
//        }
//    }
    
        func removeItems (at offsets: IndexSet) {
            expenses.items.remove(atOffsets: offsets)
        }
        
    
    
}
    

    



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



// in this we`ve used id as UUid and Identifiable protocol to our struct, we don`t need to use id in this costruction anymore (look at ExpensesItem)
//
//                    ForEach(expenses.items){ item in
//
//                            HStack {
//                                VStack(alignment: .leading){
//                                    Text (item.name)
//                                        .font(.headline)
//                                }
//
//                                Spacer ()
//
//                                Text(item.amount, format: .currency(code: item.currency))
//                                    .foregroundStyle(item.amount <= 10 ? .green : item.amount > 10 && item.amount <= 100 ? .yellow : item.amount > 100 ? .red : .purple)
//                            }
//
//                    }
//                    .onDelete(perform: removeItems)
