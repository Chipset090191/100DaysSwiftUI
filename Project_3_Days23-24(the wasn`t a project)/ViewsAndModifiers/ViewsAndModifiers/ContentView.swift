//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Михаил Тихомиров on 11.03.2023.
//

import SwiftUI

struct Watermark: ViewModifier{
    var text:String
    
    func body(content:Content)-> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text (text)
                .font(.caption)
                
        }
    }
}

extension View {
    func watermarked(with text:String)-> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView:View {
    var body: some View {
        Color.blue
            .frame(width: 300, height: 200)
            .watermarked(with: "Hacking with")
    }
}
    




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
