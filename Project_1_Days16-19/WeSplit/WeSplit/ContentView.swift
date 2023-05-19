//
//  ContentView.swift
//  WeSplit
//
//  Created by Михаил Тихомиров on 02.03.2023.
//



import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused:Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var totalPerPerson:Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount

        
        return amountPerPerson
    }
    
    var currency_formatter:FloatingPointFormatStyle<Double>.Currency {
        
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    
    
    
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currency_formatter)
                    .keyboardType(.decimalPad)  // to use only numbers your key board
                    .focused($amountIsFocused) // we dismissed keyboard after we click DONE button above!
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text ("\($0) people")
                        }
                        
                    }
                    
                    
                }
                
                Section {
                    Picker ("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id:\.self){
                            Text($0, format:.percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much do you want to leave?")
                }

                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }header: {
                    Text ("Amount per person:")
                }
                
                // Total amount per check + tips
                Section {
                    Text(totalPerPerson * Double(numberOfPeople + 2), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .none)
                }header: {
                    Text ("Total amount for the check:")
                        
                }
                
                
            }
            .navigationTitle("WeSplit")
            
            // we are creating toolbar above the keyboard!
            .toolbar {
                ToolbarItemGroup(placement:.keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
