//
//  ContentView.swift
//  Drawing
//
//  Created by Михаил Тихомиров on 04.05.2023.
//

import SwiftUI


struct ColorCyclingRectangle:View {
    var amount = 0.0
    var steps = 100   // how many steps to draw
    
    var body: some View{
        ZStack{
                
                Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [color(for: 3, brightness: 1), color(for: 2, brightness: 0.3)]), startPoint: UnitPoint(x: 0.5, y: 1), endPoint: UnitPoint(x: 1, y: amount)))
                
                
                
        }
        
        // with this modifier we can fix glitching in work with gradients like in this task
        .drawingGroup()
    }
    
    func color(for value: Int, brightness:Double) -> Color {
        var targetHue = Double(value) / Double (steps)
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


struct ContentView: View {
 
    @State private var position = 0.0
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: position)
                .frame (width: 300, height: 300)
            
                
            Slider(value: $position, in: 0.0...1)
                .padding(.horizontal)
            Text("\(position, format: .number.precision(.fractionLength(2)))")
                
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
