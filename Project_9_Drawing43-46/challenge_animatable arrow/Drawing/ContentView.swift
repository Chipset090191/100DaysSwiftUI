//
//  ContentView.swift
//  Drawing
//
//  Created by Михаил Тихомиров on 04.05.2023.
//

import SwiftUI


struct Arrow: Shape {
    
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX / 1.5, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + (rect.midX / 1.5), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.midX / 1.5), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.midX / 1.5), y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.midX / 4.0), y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + 30))
        path.addLine(to: CGPoint(x: rect.minX + (rect.midX / 4.0), y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + (rect.midX / 1.5), y: rect.midY))
        return path
    }
}


struct ContentView: View {
    
    @State private var line_Width = 5.0
    
    var body: some View {
        Arrow()
            .stroke(.black, style: StrokeStyle(lineWidth: line_Width, lineCap: .round,  lineJoin: .round))
            .frame(width: 400, height: 500)
            .onTapGesture {
                withAnimation{
                    line_Width = Double.random(in: 5...20)
                }
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
