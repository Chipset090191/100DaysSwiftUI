//
//  ContentView.swift
//  Project_6_Day32-34_Animation
//
//  Created by Михаил Тихомиров on 28.03.2023.
//

import SwiftUI


// custom modifier for transition
struct CornerRotateModifier: ViewModifier{
    let amount:Double
    let anchor:UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount),anchor: anchor)
            .clipped() // play with this
    }
}

extension AnyTransition {
    static var pivot:AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var isSHowingRed = false
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width:200, height: 200)
            if isSHowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width:200, height: 200)
                    .transition(.pivot)
                
            }
        }
        .onTapGesture {
            withAnimation{
                isSHowingRed.toggle()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
