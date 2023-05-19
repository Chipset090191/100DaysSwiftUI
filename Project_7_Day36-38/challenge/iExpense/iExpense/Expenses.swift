//
//  Expenses.swift
//  iExpense
//
//  Created by Михаил Тихомиров on 14.04.2023.
//

import Foundation

// this is our swift file here.

class Expenses: ObservableObject {     // by using ObservableObject you can use this class with as many view as you want
    
    @Published var items = [ExpenseItem]() {   // we use Published to see any announcements from the property
        
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
        
        
    }
        
    
}
