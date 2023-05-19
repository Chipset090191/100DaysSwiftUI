//
//  ContentView.swift
//  Unit_conversation
//
//  Created by Михаил Тихомиров on 06.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var input_unit = ""
    @State private var output_unit = ""
    @State private var input_number = 0.0
    @FocusState private var amountIsFocused:Bool

    

    let Units = ["Celsius", "Fahrenheit", "Kelvin"]
//    let Units = [1.3, 2.0, 3.0]
    
   
    
    var result:Double {
        
        

        if input_unit == "Celsius" && output_unit == "Fahrenheit" {
            return (9/5) * input_number + 32
        }else if input_unit == "Celsius" && output_unit == "Kelvin" {
            return input_number + 273.15
        }else if input_unit == "Fahrenheit" && output_unit == "Celsius" {
            return (input_number - 32) * 5/9
        }else if input_unit == "Fahrenheit" && output_unit == "Kelvin" {
            return (input_number - 32) * 5/9 + 273.15
        }else if input_unit == "Kelvin" && output_unit == "Celsius" {
            return input_number - 273.15
        }else if input_unit == "Kelvin" && output_unit == "Fahrenheit" {
            return (input_number - 273.15) * 9/5 + 32
        }
        
        
        return input_number
        
    }
    
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Text ("Choose an input Unit A:").foregroundColor(.accentColor)
                    Picker("Input Unit", selection: $input_unit){
                        ForEach(Units, id:\.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section {
                    Text("Choose an output Unit B:").foregroundColor(.accentColor)
                    Picker("Output Unit", selection: $output_unit) {
                        ForEach(Units, id:\.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section {
                    Text("Enter the value:").bold()
                    TextField("Input_number", value: $input_number, format:.number)
                }
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
                
                Section {
                    Text(result, format:.number)
                    
                }header: {
                    Text("The result of conversion:").foregroundColor(.green).font(.headline)
                }
                
            }
            .navigationTitle("Conversion of Units")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done"){
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
