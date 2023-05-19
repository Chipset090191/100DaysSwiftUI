//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Михаил Тихомиров on 14.04.2023.
//

// this is our swift file here.

import Foundation

enum ExpenseType:String, Codable, CaseIterable {   // CaseIterable allows us to use rawValue through our app
    case business = "Business"
    case personal = "Personal"
}


struct ExpenseItem: Identifiable,Codable {
    let id = UUID ()
    let name: String
    let type: ExpenseType
    let amount:Double
    let currency: String
}
