//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Михаил Тихомиров on 14.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Text("Hello, world!")
                .foregroundColor(.green)
        }
        .padding()
        .foregroundColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
