//
//  AstronautView.swift
//  Moonshot
//
//  Created by Михаил Тихомиров on 29.04.2023.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut:Astronaut
    
    var body: some View {
        ScrollView{
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
        
                Text (astronaut.description)
                    .padding()
            }
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts:[String:Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts["grissom"]!)
    }
}
