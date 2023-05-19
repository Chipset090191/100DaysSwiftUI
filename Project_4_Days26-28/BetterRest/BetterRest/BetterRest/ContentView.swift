//
//  ContentView.swift
//  BetterRest
//
//  Created by Михаил Тихомиров on 19.03.2023.
//
import CoreML
import SwiftUI

struct ContentView: View {
    enum ModelError:Error{
        case anError
    }
    
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var recommendedBedtime:Date {
    
            let config = MLModelConfiguration()
            let model = try? SleepCalculator(configuration: config)

            // More code to come here
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60 // to convert to seconds
            let minute = (components.minute ?? 0) * 60 // to convert to seconds


        let prediction = try? model?.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

        let sleepTime = wakeUp - (prediction?.actualSleep ?? 0) // that`s a date format!

        return sleepTime
        
        
    }
    
    
    
    var body: some View {
        NavigationView{
            Form{
                
                Section{

                    DatePicker ("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }header: {
                    Text ("When do you want to wake up?")
//                        .font(.headline)
                }
                
                Section{
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }header: {
                    Text ("Desired amount of sleep:")
//                        .font(.headline)
                }
                
                Section{
                    
                    Picker("Daily coffee intake:", selection: $coffeeAmount ){
                        ForEach(1..<21){number in
                            Text(number == 1 ? "1 cup" : "\(number) cups")
                        }
                    }
                    
//                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                }header: {
                    Text("Coffee:")
//                        .font(.headline)
                }
            
                Section{
                    Text("\(recommendedBedtime.formatted(date: .omitted, time: .shortened))")
                        .bold()
                    
                }header: {
                    Text("Your recommended bedtime:")
                        .font(.headline)
                        .foregroundColor(.green)
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar{
//                Button("Calculate",action: calculateBedtime)
//            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK"){}
            }message: {
                Text(alertMessage)
            }
        }
    }
//    func calculateBedtime () throws ->Date {
//
//            let config = MLModelConfiguration()
//            let model = try? SleepCalculator(configuration: config)
//
//            // More code to come here
//
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60 // to convert to seconds
//            let minute = (components.minute ?? 0) * 60 // to convert to seconds
//            guard let prediction = try? model?.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount)) else {throw ModelError.anError}
//
//            let sleepTime = wakeUp - prediction.actualSleep // that`s a date format!
//
//            return sleepTime
//
//    }
//
   
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
