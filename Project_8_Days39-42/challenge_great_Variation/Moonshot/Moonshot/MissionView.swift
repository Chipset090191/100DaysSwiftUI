//
//  MissionView.swift
//  Moonshot
//
//  Created by Михаил Тихомиров on 25.04.2023.
//

import SwiftUI

struct CustomSeparator:View {

    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }


}


struct MissionView: View {
    struct CrewMember {
        let role:String
        let astronaut:Astronaut     // { id, name, description}
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image (mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    Text (mission.formattedLaunchDate)
                        .italic()
                        .bold()
                        .padding(.top)
                  
                    
                    VStack(alignment: .leading) {
                        
                        
                        CustomSeparator()
                        
                        Text ("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text (mission.description)
                        
                        CustomSeparator()
                        
                        Text ("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                    }
                    .padding(.horizontal)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                }label: {
                                    HStack {
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 140, height: 90)
                                            .clipShape(Capsule())
                                            .overlay(
                                                Capsule()
                                                    .strokeBorder(.white, lineWidth: 1)
                                            )

                                        VStack(alignment: .leading) {
                                            Text (crewMember.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)

                                            Text (crewMember.role)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.horizontal)

                                }
                            }
                        }
                    }
                
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts:[String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions:[Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
