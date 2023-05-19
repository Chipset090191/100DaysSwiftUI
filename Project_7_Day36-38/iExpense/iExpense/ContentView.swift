//
//  ContentView.swift
//  iExpense
//
//  Created by Михаил Тихомиров on 12.04.2023.
//

import SwiftUI


struct ContentView:View {
    
    // to make an instance of our class
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    public var currency_formatter:FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    
    var body: some View {
        NavigationView{
            List{
                // in this we`ve used id as UUid and Identifiable protocol to our struct, we don`t need to use id in this costruction anymore (look at ExpensesItem)
                ForEach(expenses.items){ item in
                    HStack {
                        VStack(alignment: .leading){
                            Text (item.name)
                                .font(.headline)
                            Text (item.type)
                        }
                        
                        Spacer ()
                        
                        Text(item.amount, format: currency_formatter)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button {
                    showingAddExpense = true
                }label: {
                    Image (systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
        
    }
    
    func removeItems (at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
